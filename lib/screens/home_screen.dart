import 'package:flutter/material.dart';
import 'meu_cadastro_screen.dart';
import 'veiculos_screen.dart';
import 'agendamento_screen.dart';
import 'status_servico_screen.dart';
import 'pagamentos_screen.dart';
import 'login_screen.dart';
import 'historico_servicos_screen.dart';

class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Lava Rápido'),
                actions: [
                    IconButton(
                        tooltip: 'Sair',
                        onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                ),
                            );
                        },
                        icon: const Icon(Icons.logout),
                    ),
                ],
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Text(
                            'Bem-vindo ao Lava Rápido!',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                ),
                            ),

                        const SizedBox(height: 30),

                        SizedBox(
                            width: 250,
                            child: ElevatedButton(
                                onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const MeuCadastroScreen(),
                                        ),
                                    );
                                },
                                child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        Icon(Icons.person),
                                        SizedBox(width: 8),
                                        Text('Meu Cadastro'),
                                    ],
                                ),
                            ),
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                            width: 250,
                            child: ElevatedButton(
                                onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const VeiculosScreen(),
                                        ),
                                    );
                                },
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        Icon(Icons.directions_car),
                                        SizedBox(width: 8),
                                        Text('Meus Veículos'),
                                    ],
                                ),
                            ),
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                            width: 250,
                            child: ElevatedButton(
                                onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const AgendamentoScreen(),
                                        ),
                                    );
                                },
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        Icon(Icons.calendar_month),
                                        SizedBox(width: 8),
                                        Text('Agendar Serviço'),
                                    ],
                                ),
                            ),
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                            width: 250,
                            child: ElevatedButton(
                                onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const StatusServicoScreen(),
                                        ),
                                    );
                                },
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        Icon(Icons.track_changes),
                                        SizedBox(width: 8),
                                        Text('Acompanhar Serviço'),
                                    ],
                                ),
                            ),
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                            width: 250,
                            child: ElevatedButton(
                                onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const HistoricoServicosScreen(),
                                            ),
                                        );
                                    },
                                    child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            Icon(Icons.history),
                                            SizedBox(width: 8),
                                            Text('Histórico de Serviços'),
                                        ],
                                    ),
                                ),
                            ),

                        const SizedBox(height: 16),

                        SizedBox(
                            width:250,
                            child: ElevatedButton(
                                onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const PagamentosScreen(),
                                        ),
                                    );
                                },
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        Icon(Icons.payment),
                                        SizedBox(width: 8),
                                        Text('Pagamentos'),
                                    ],
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}