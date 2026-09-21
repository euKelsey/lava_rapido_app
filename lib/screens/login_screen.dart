import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cadastro_screen.dart';

class LoginScreen extends StatefulWidget {
    const LoginScreen({super.key});

    @override
    State<LoginScreen> createState() => _LoginScreenState();
    
}
class _LoginScreenState extends State<LoginScreen> {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController senhaController = TextEditingController();

    @override
    void dispose() {
        emailController.dispose();
        senhaController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Lava Rápido'),
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            controller: senhaController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Senha',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                            ),
                        ),

                        const SizedBox(height: 24),

                        ElevatedButton(
                            onPressed: () {
                                String email = emailController.text.trim();
                                String senha = senhaController.text.trim();

                                if (email.isEmpty || senha.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Preencha o e-mail e a senha'),
                                        ),
                                   );
                                } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Login realizado com sucesso!'),
                                        ),
                                    );

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const HomeScreen(),
                                        ),
                                    );
                                }
                            },
                            child: const Text('Entrar'),
                        ),

                        const SizedBox(height: 16),

                        TextButton(
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CadastroScreen(),
                                    ),
                                );
                            },
                            child: const Text('Criar Conta'),
                        ),
                    ],
                ),
                ),
            ),
        );
    }
}