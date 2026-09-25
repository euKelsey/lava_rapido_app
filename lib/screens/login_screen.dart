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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fast_splash.gif',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.35),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Fast Splash',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            offset: Offset(0, 2),
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Seu carro limpo de um jeito rápido e fácil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            offset: Offset(0, 1),
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'Digite seu e-mail',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.white70,
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: senhaController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.white70,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
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
                                content: Text(
                                  'Login realizado com sucesso!',
                                ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          side: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CadastroScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black.withValues(alpha: 0.35),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Ainda não tem conta? Criar Conta',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
