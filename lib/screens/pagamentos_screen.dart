import 'package:flutter/material.dart';
import '../data/dados_temporarios.dart';
import '../models/agendamento.dart';

class PagamentosScreen extends StatefulWidget {
  const PagamentosScreen({super.key});

  @override
  State<PagamentosScreen> createState() => _PagamentosScreenState();
}

class _PagamentosScreenState extends State<PagamentosScreen> {

  List<Agendamento> get pagamentosPendentes {
    return agendamentos
      .where((agendamento) => !agendamento.pago)
      .toList();
  }

  List<Agendamento> get pagamentosPagos {
    return agendamentos
      .where((agendamento) => agendamento.pago)
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamentos'),
      ),
      body: agendamentos.isEmpty
          ? const Center(
            child: Text('Nenhum pagamento disponível'),
          )
        : ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Pagamentos Pendentes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (pagamentosPendentes.isEmpty)
                const Text('Nenhum pagamento pendente'),

              ...pagamentosPendentes.map(
                (agendamento) => _criarCardPagamento(agendamento),
              ),

              const SizedBox(height: 24),

              const Text(
                'Pagamentos Realizados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (pagamentosPagos.isEmpty)
                const Text('Nenhum pagamento realizado'),

              ...pagamentosPagos.map(
                (agendamento) => _criarCardPagamento(agendamento),
              ),
            ],
          ),
        );
  }

  void _confirmarPagamento(Agendamento agendamento) {
    String? formaPagamento;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Forma de Pagamento'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('PIX'),
                    value: 'PIX',
                    groupValue: formaPagamento,
                    onChanged: (String? valor) {
                      setStateDialog(() {
                        formaPagamento = valor;
                      });
                    },
                  ),

                  RadioListTile<String>(
                    title: const Text('Cartão'),
                    value: 'Cartão',
                    groupValue: formaPagamento,
                    onChanged: (String? valor) {
                      setStateDialog(() {
                        formaPagamento = valor;
                      });
                    },
                  ),

                  RadioListTile<String>(
                    title: const Text('Dinheiro'),
                    value: 'Dinheiro',
                    groupValue: formaPagamento,
                    onChanged: (String? valor) {
                      setStateDialog(() {
                        formaPagamento = valor;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),

                ElevatedButton(
                  onPressed: formaPagamento == null
                      ? null
                      : () {
                          setState(() {
                            agendamento.pago = true;
                            agendamento.formaPagamento = formaPagamento;
                          });

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Pagamento realizado via $formaPagamento!',
                              ),
                            ),
                          );
                        },
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  
  Widget _criarCardPagamento(Agendamento agendamento) {
    String nomesServicos = agendamento.servicos
        .map((servico) => servico.nome)
        .join(', ');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${agendamento.veiculo.marca} '
              '${agendamento.veiculo.modelo}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text('Serviços: $nomesServicos'),

            const SizedBox(height: 8),

            Text('Data: ${agendamento.data}'),

            const SizedBox(height: 8),

            Text(
              'Valor: R\$ ${agendamento.valorTotal.toStringAsFixed(2)}',
            ),

            const SizedBox(height: 8),

            Text(
              agendamento.pago
                  ? 'Status do pagamento: Pago'
                  : 'Status do pagamento: Pendente',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            if (agendamento.pago && agendamento.formaPagamento != null) ...[
              const SizedBox(height: 8),

              Text(
                'Forma de pagamento: ${agendamento.formaPagamento}',
              ),
            ],

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: agendamento.pago
                    ? null
                    : () {
                        _confirmarPagamento(agendamento);
                      },
                child: Text(
                  agendamento.pago ? 'Pago' : 'Pagar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}    