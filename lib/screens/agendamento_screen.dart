import 'package:flutter/material.dart';
import '../models/veiculo.dart';
import '../data/dados_temporarios.dart';
import '../models/servico.dart';
import '../models/agendamento.dart';

class AgendamentoScreen extends StatefulWidget {
    const AgendamentoScreen({super.key});

    @override
    State<AgendamentoScreen> createState() => _AgendamentoScreenState();
}

class _AgendamentoScreenState extends State<AgendamentoScreen> {
    
    final TextEditingController dataController = TextEditingController();
    final TextEditingController horarioController = TextEditingController();

    Veiculo? veiculoSelecionado;

    final List<Servico> servicosSelecionados = [];

    double get valorTotal {
        double total = 0;

        for (var servico in servicosSelecionados) {
            total += servico.preco;
        }

        return total;
    }

    Future<void> _selecionarServicos() async {
        List<Servico> servicosTemporarios = List.from(servicosSelecionados);

        bool? confirmar = await showDialog<bool>(
            context: context,
            builder: (context) {
                return StatefulBuilder(
                    builder: (context, setStateDialog) {
                        return AlertDialog(
                            title: const Text('Selecionar Serviços'),
                            content: SingleChildScrollView(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: servicosDisponiveis.map((servico) {
                                        return CheckboxListTile(
                                            title: Text(servico.nome),
                                            subtitle: Text(
                                                'R\$ ${servico.preco.toStringAsFixed(2)}',
                                            ),
                                            value: servicosTemporarios.contains(servico),
                                             onChanged: (bool? selecionado) {
                                                setStateDialog(() {
                                                    if (selecionado == true) {
                                                        servicosTemporarios.add(servico);
                                                    } else {
                                                        servicosTemporarios.remove(servico);
                                                    }
                                                });
                                            },
                                        );
                                    }).toList(),
                                ),
                            ),
                            actions: [
                            TextButton(
                                onPressed: () {
                                Navigator.pop(context, false);
                                },
                                child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                Navigator.pop(context, true);
                                },
                                child: const Text('Confirmar'),
                            ),
                        ],
                    );
                },
            );
        },
    );

    if (confirmar == true) {
        setState(() {
            servicosSelecionados.clear();
            servicosSelecionados.addAll(servicosTemporarios);
        });
    }
}

    @override
    void dispose() {
    dataController.dispose();
    horarioController.dispose();
    super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Agendar Serviço'),
            ),
            body: Center(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                DropdownButtonFormField<Veiculo>(
                                    value: veiculoSelecionado,
                                    decoration: const InputDecoration(
                                        labelText: 'Veículo',
                                        prefixIcon: Icon(Icons.directions_car),
                                        border: OutlineInputBorder(),
                                    ),
                                    items: veiculosCadastrados.map((Veiculo veiculo) {
                                        return DropdownMenuItem<Veiculo>(
                                            value: veiculo,
                                            child: Text(
                                                '${veiculo.marca} ${veiculo.modelo} - ${veiculo.placa}',
                                            ),
                                        );
                                    }).toList(),
                                    onChanged: (Veiculo? novoVeiculo) {
                                        setState(() {
                                            veiculoSelecionado = novoVeiculo;
                                        });
                                    },
                                ),
                                const SizedBox(height: 16),

                                InkWell(
                                    onTap: () {
                                        _selecionarServicos();
                                    },
                                    child: InputDecorator(
                                        decoration: const InputDecoration(
                                            labelText: 'Serviços',
                                            prefixIcon: Icon(Icons.local_car_wash),
                                            suffixIcon: Icon(Icons.arrow_drop_down),
                                            border: OutlineInputBorder(),
                                        ),
                                        child: Text(
                                        servicosSelecionados.isEmpty
                                            ? 'Selecionar serviços'
                                            : servicosSelecionados
                                                .map((servico) => servico.nome)
                                                .join(', '),
                                        ),
                                    ),
                                ),

                                const SizedBox(height: 16),

                                TextField(
                                    controller: dataController,
                                    readOnly: true,
                                    onTap: () async {
                                        DateTime? dataSelecionada = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2030),
                                        );

                                        if (dataSelecionada != null) {
                                            dataController.text =
                                            '${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}';
                                        }
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'Data',
                                        prefixIcon: Icon(Icons.calendar_today),
                                        border: OutlineInputBorder(),
                                    ),
                                ),

                                const SizedBox(height: 16),

                                TextField(
                                    controller: horarioController,
                                    readOnly: true,
                                    onTap: () async {
                                        TimeOfDay? horarioSelecionado = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                        );

                                        if (horarioSelecionado != null) {
                                            horarioController.text = horarioSelecionado.format(context);
                                        }
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'Horário',
                                        prefixIcon: Icon(Icons.access_time),
                                        border: OutlineInputBorder(),
                                    ),
                                ),

                                const SizedBox(height: 16),

                                if (servicosSelecionados.isNotEmpty)
                                    Text(
                                        'Valor total: R\$ ${valorTotal.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                        ),
                                    ),

                                const SizedBox(height: 24),

                                SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                            Veiculo? veiculo = veiculoSelecionado;
                                            String data = dataController.text;
                                            String horario = horarioController.text;

                                            if (veiculo == null ||
                                                servicosSelecionados.isEmpty ||
                                                data.isEmpty ||
                                                horario.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    content: Text('Preencha todos os campos'),
                                                ),
                                            );
                                        } else {
                                            String nomesServicos = servicosSelecionados
                                            .map((servico) => servico.nome)
                                            .join(', ');

                                            double totalAgendamento = valorTotal;

                                            bool? confirmar = await showDialog<bool>(
                                                context: context,
                                                builder: (context) {
                                                    return AlertDialog(
                                                        title: const Text('Confirmar Agendamento'),
                                                        content: Text(
                                                            'Veículo: ${veiculo.marca} ${veiculo.modelo}\n\n'
                                                            'Serviços: $nomesServicos\n\n'
                                                            'Data: $data\n'
                                                            'Horário: $horario\n\n'
                                                            'Total: R\$ ${totalAgendamento.toStringAsFixed(2)}',
                                                        ),
                                                        actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                    Navigator.pop(context, false);
                                                            },
                                                            child: const Text('Cancelar'),
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                                Navigator.pop(context, true);
                                                            },
                                                            child: const Text('Confirmar'),
                                                        ),
                                                    ],
                                                    );
                                                },
                                                );

                                                if (confirmar == true) {
                                                    agendamentos.add(
                                                        Agendamento(
                                                            veiculo: veiculo,
                                                            servicos: List.from(servicosSelecionados),
                                                            data: data,
                                                            horario: horario,
                                                            status: 'Agendado',
                                                            valorTotal: totalAgendamento,
                                                            pago: false,
                                                        ),
                                                    );
                                                    
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                            content: Text('Agendamento confirmado!'),
                                                        ),
                                                    );

                                                    setState(() {
                                                        veiculoSelecionado = null;
                                                        servicosSelecionados.clear();
                                                    });

                                                    dataController.clear();
                                                    horarioController.clear();
                                                }
                                            }
                                        },
                                        child: const Text('Confirmar Agendamento'),
                                    ),
                               ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}