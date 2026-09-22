import 'package:flutter/material.dart';
import '../data/dados_temporarios.dart';
import '../models/agendamento.dart';

class HistoricoServicosScreen extends StatelessWidget {
  const HistoricoServicosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Agendamento> historico = agendamentos
        .where(
          (agendamento) =>
              agendamento.status == 'Finalizado' ||
              agendamento.status == 'Cancelado',
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Serviços'),
      ),
      body: historico.isEmpty
          ? const Center(
              child: Text('Nenhum serviço no histórico'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: historico.length,
              itemBuilder: (context, index) {
                Agendamento agendamento = historico[index];

                String nomesServicos = agendamento.servicos
                    .map((servico) => servico.nome)
                    .join(', ');

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Icon(
                      agendamento.status == 'Finalizado'
                          ? Icons.check_circle
                          : Icons.cancel,
                    ),
                    title: Text(
                      '${agendamento.veiculo.marca} '
                      '${agendamento.veiculo.modelo}',
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Serviços: $nomesServicos'),
                        Text('Data: ${agendamento.data}'),
                        Text('Horário: ${agendamento.horario}'),
                        Text('Status: ${agendamento.status}'),
                        Text('Valor: R\$ ${agendamento.valorTotal.toStringAsFixed(2)}',
                      ),

                    const SizedBox(height: 8),

                    Text(
                      agendamento.pago
                        ? 'Pagamento: Pago'
                        : 'Pagamento: Não realizado',
                      ),

                      if (agendamento.pago &&
                          agendamento.formaPagamento != null)
                        Text(
                          'Forma de pagamento: ${agendamento.formaPagamento}',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}