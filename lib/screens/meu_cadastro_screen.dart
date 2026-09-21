import 'package:flutter/material.dart';

class MeuCadastroScreen extends StatefulWidget {
    const MeuCadastroScreen({super.key});

    @override
    State<MeuCadastroScreen> createState() => _MeuCadastroScreenState();
}

class _MeuCadastroScreenState extends State<MeuCadastroScreen> {
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController telefoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController cpfController = TextEditingController();

    @override
    void dispose() {
        nomeController.dispose();
        telefoneController.dispose();
        emailController.dispose();
        cpfController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Meu Cadastro'),
            ),
                body: Center(
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                TextField(
                                    controller: nomeController,
                                    decoration: const InputDecoration(
                                        labelText: 'Nome',
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(),
                                    ),
                                ),

                                const SizedBox(height: 16),

                                TextField(
                                    controller: telefoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        labelText: 'Telefone',
                                        prefixIcon: Icon(Icons.phone),
                                        border: OutlineInputBorder(),
                                    ),
                                ),

                                const SizedBox(height: 16),

                                TextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        labelText: 'E-mail',
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(),
                                    ),
                                ),

                                const SizedBox(height: 16),

                                TextField(
                                    controller: cpfController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'CPF',
                                        prefixIcon: Icon(Icons.badge),
                                        border: OutlineInputBorder(),
                                    ),
                                ),

                                const SizedBox(height: 24),

                                SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                            String nome = nomeController.text.trim();
                                            String telefone = telefoneController.text.trim();
                                            String email = emailController.text.trim();
                                            String cpf = cpfController.text.trim();

                                            if (nome.isEmpty ||
                                            telefone.isEmpty ||
                                            email.isEmpty ||
                                            cpf.isEmpty) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                        content: Text('Preencha todos os campos'),
                                                    ),
                                                );
                                            } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                        content: Text('Dados atualizados com sucesso!'),
                                                    ),
                                                );
                                            }
                                        },
                                        child: const Text('Salvar Alterações'),
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