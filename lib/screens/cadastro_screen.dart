import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController telefoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController cpfController = TextEditingController();
    final TextEditingController senhaController = TextEditingController();
    final TextEditingController confirmarSenhaController = TextEditingController();

    @override
    void dispose() {
        nomeController.dispose();
        telefoneController.dispose();
        emailController.dispose();
        cpfController.dispose();
        senhaController.dispose();
        confirmarSenhaController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Text('Criar Conta'),
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

                            const SizedBox(height: 16),

                            TextField(
                                controller: senhaController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: 'Senha',
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(),
                                ),
                            ),

                            const SizedBox(height: 16),

                            TextField(
                                controller: confirmarSenhaController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: 'Confirmar Senha',
                                    prefixIcon: Icon(Icons.lock_outline),
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
                                        String senha = senhaController.text.trim();
                                        String confirmarSenha = confirmarSenhaController.text.trim();

                                        if (nome.isEmpty ||
                                            telefone.isEmpty ||
                                            email.isEmpty ||
                                            cpf.isEmpty ||
                                            senha.isEmpty ||
                                            confirmarSenha.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Preencha todos os campos'),
                                                ),
                                            );
                                        } else if (senha != confirmarSenha) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('As senhas não coincidem'),
                                                ),
                                            );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Conta criada com sucesso!'),
                                                ),
                                            );

                                            Navigator.pop(context);
                                            
                                        }
                                        },
                                        child: const Text('Criar Conta'),
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