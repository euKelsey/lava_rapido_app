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
        List<Agendamento> agendamentosAtivos = agendamentos
            .where(
                (agendamento) =>
                    agendamento.status != 'Finalizado' &&
                    agendamento.status != 'Cancelado',
            )
            .toList();

        return Scaffold(
            appBar: AppBar(
                title: const Text('Acompanhar Serviço'),
            ),
            body: agendamentosAtivos.isEmpty
            ? const Center(
                child: Text('Nenhum agendamento encontrado'),
                )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: agendamentosAtivos.length,
                itemBuilder: (context, index) {
                    Agendamento agendamento = agendamentosAtivos[index];

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
                            trailing: const Icon(Icons.chevron_right),
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
                        if (agendamento.status == 'Agendado')
                            TextButton(
                                onPressed: () async {
                                    bool? confirmarCancelamento = await showDialog<bool>(
                                        context: context,
                                        builder: (context) {
                                            return AlertDialog(
                                                title: const Text('Cancelar Agendamento'),
                                                content: const Text(
                                                    'Tem certeza que deseja cancelar este agendamento?',
                                                ),
                                                actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                            Navigator.pop(context, false);
                                                        },
                                                        child: const Text('Não'),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                            Navigator.pop(context, true);
                                                        },
                                                        child: const Text('Sim, cancelar'),
                                                    ),
                                                ],
                                            );
                                        },
                                    );

                                    if (confirmarCancelamento == true) {
                                        setState(() {
                                            agendamento.status = 'Cancelado';
                                        });

                                        Navigator.pop(context);

                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Agendamento cancelado com sucesso!'),
                                            ),
                                        );
                                    }
                                },
                                child: const Text('Cancelar Agendamento'),
                            ),
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