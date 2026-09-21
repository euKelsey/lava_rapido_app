import 'package:flutter/material.dart';
import '../data/dados_temporarios.dart';
import '../models/agendamento.dart';

class StatusServicoScreen extends StatefulWidget {
    const StatusServicoScreen({super.key});

    @override
    State<StatusServicoScreen> createState() => _StatusServicoScreenState();
}

class _StatusServicoScreenState extends State<StatusServicoScreen> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Acompanhar Serviço'),
            ),
            body: agendamentos.isEmpty
            ? const Center(
                child: Text('Nenhum agendamento encontrado'),
                )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: agendamentos.length,
                itemBuilder: (context, index) {
                    Agendamento agendamento = agendamentos[index];

                    String nomesServicos = agendamento.servicos
                        .map((servico) => servico.nome)
                        .join(', ');

                    return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                            leading: const Icon(Icons.local_car_wash),
                            title: Text(
                                '${agendamento.veiculo.marca} ${agendamento.veiculo.modelo}',
                            ),
                            subtitle: Text(
                                'Serviços: $nomesServicos\n'
                                'Data: ${agendamento.data}\n'
                                'Horário: ${agendamento.horario}\n'
                                'Status: ${agendamento.status}\n'
                                'Valor: R\$ ${agendamento.valorTotal.toStringAsFixed(2)}',
                            ),
                            onTap: () {
                                _abrirDetalhes(agendamento);
                            },
                        ),
                    );
                },
            ),
        );
    }
    
    void _abrirDetalhes(Agendamento agendamento) {
        showDialog(
            context: context,
            builder: (context) {
                String nomesServicos = agendamento.servicos
                    .map((servico) => servico.nome)
                    .join(', ');

                bool emAndamento =
                    agendamento.status == 'Em andamento' ||
                    agendamento.status == 'Finalizado';

                bool finalizado = agendamento.status == 'Finalizado';

                return AlertDialog(
                    title: const Text('Detalhes do Serviço'),
                    content: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    'Veículo: ${agendamento.veiculo.marca} '
                                    '${agendamento.veiculo.modelo}',
                                ),

                                const SizedBox(height: 12),

                                Text('Serviços: $nomesServicos'),

                                const SizedBox(height: 12),

                                Text('Data: ${agendamento.data}'),

                                const SizedBox(height: 12),

                                Text('Horário: ${agendamento.horario}'),

                                const SizedBox(height: 12),

                                Text(
                                    'Valor: R\$ ${agendamento.valorTotal.toStringAsFixed(2)}',
                                ),

                                const SizedBox(height: 24),

                                const Text(
                                    'Acompanhamento',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),

                                const SizedBox(height: 16),

                                Row(
                                    children: [
                                        const Icon(Icons.check_circle),
                                        const SizedBox(width: 10),
                                        const Text('Agendado'),
                                    ],
                                ),

                                const SizedBox(height: 16),

                                Row(
                                    children: [
                                        Icon(
                                            emAndamento
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                        ),
                                        const SizedBox(width: 10),
                                        const Text('Em andamento'),
                                    ],
                                ),

                                const SizedBox(height: 16),

                                Row(
                                    children: [
                                        Icon(
                                            finalizado
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                        ),
                                        const SizedBox(width: 10),
                                        const Text('Finalizado'),
                                    ],
                                ),
                            ],
                        ),
                    ),
                    actions: [
                        TextButton(
                            onPressed: () {
                                Navigator.pop(context);
                            },
                            child: const Text('Fechar'),
                        ),
                    ],
                );
            },
        );
    }
}