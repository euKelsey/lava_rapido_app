import 'package:flutter/material.dart';
import '../models/veiculo.dart';
import '../data/dados_temporarios.dart';

class VeiculosScreen extends StatefulWidget {
    const VeiculosScreen({super.key});

    @override
    State<VeiculosScreen> createState() => _VeiculosScreenState();
}

class _VeiculosScreenState extends State<VeiculosScreen>{
    final TextEditingController placaController = TextEditingController();
    final TextEditingController marcaController = TextEditingController();
    final TextEditingController modeloController = TextEditingController();
    final TextEditingController corController = TextEditingController();

    bool mostrarFormulario = false;
    Veiculo? veiculoEmEdicao;

    @override
    void dispose() {
        placaController.dispose();
        marcaController.dispose();
        modeloController.dispose();
        corController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Meus Veículos'),
            ),
            body: Center(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Text(
                                    'Veículos cadastrados',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),

                                const SizedBox(height: 16),

                                ...veiculosCadastrados.map(
                                    (veiculo) => ListTile(
                                        leading: const Icon(Icons.directions_car),
                                        title: Text('${veiculo.marca} ${veiculo.modelo}'),
                                        subtitle: Text(
                                            'Placa: ${veiculo.placa} | Cor: ${veiculo.cor}',
                                        ),

                                        trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                IconButton(
                                                    onPressed: () {
                                                        setState(() {
                                                        veiculoEmEdicao = veiculo;
                                                        mostrarFormulario = true;

                                                        marcaController.text = veiculo.marca;
                                                        modeloController.text = veiculo.modelo;
                                                        placaController.text = veiculo.placa;
                                                        corController.text = veiculo.cor;
                                                    });
                                                    },
                                                    icon: const Icon(Icons.edit),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                        bool? confirmar = await showDialog<bool>(
                                                            context: context,
                                                            builder: (context) {
                                                                return AlertDialog(
                                                                    title: const Text('Excluir veículo'),
                                                                    content: Text(
                                                                        'Deseja excluir ${veiculo.marca} ${veiculo.modelo}?',
                                                                    ),
                                                                    actions: [
                                                                        TextButton(
                                                                            onPressed: () {
                                                                                Navigator.pop(context, false);
                                                                            },
                                                                            child: const Text('Cancelar'),
                                                                        ),
                                                                        TextButton(
                                                                            onPressed: () {
                                                                                Navigator.pop(context, true);
                                                                            },
                                                                            child: const Text('Excluir')
                                                                        ),
                                                                    ],
                                                                );
                                                            },
                                                        );

                                                        if (confirmar == true) {
                                                            setState(() {
                                                                veiculosCadastrados.remove(veiculo);
                                                            });
                                                        }
                                                    },
                                                    icon: const Icon(Icons.delete),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                        onPressed: () {
                                            setState(() {
                                                mostrarFormulario = !mostrarFormulario;

                                                if (!mostrarFormulario) {
                                                    veiculoEmEdicao = null;
                                                    placaController.clear();
                                                    marcaController.clear();
                                                    modeloController.clear();
                                                    corController.clear();
                                                }
                                            });
                                        },
                                        icon: const Icon(Icons.add),
                                        label:Text(
                                            mostrarFormulario ? 'Cancelar' : 'Adicionar Veículo',
                                        ),
                                    ),
                                ),

                                const SizedBox(height: 24),

                                if(mostrarFormulario) ...[
                                    TextField(
                                        controller: placaController,
                                        decoration: const InputDecoration(
                                            labelText: 'Placa',
                                            prefixIcon: Icon(Icons.confirmation_number),
                                            border: OutlineInputBorder(),
                                        ),
                                    ),

                                    const SizedBox(height: 16),

                                    TextField(
                                        controller: marcaController,
                                        decoration: const InputDecoration(
                                            labelText: 'Marca',
                                            prefixIcon: Icon(Icons.business),
                                            border: OutlineInputBorder(),
                                        ),
                                    ),

                                    const SizedBox(height: 16),

                                    TextField(
                                        controller: modeloController,
                                        decoration: const InputDecoration(
                                            labelText: 'Modelo',
                                            prefixIcon: Icon(Icons.directions_car),
                                            border: OutlineInputBorder(),
                                        ),
                                    ),

                                    const SizedBox(height: 16),

                                    TextField(
                                        controller: corController,
                                        decoration: const InputDecoration(
                                            labelText: 'Cor',
                                            prefixIcon: Icon(Icons.color_lens),
                                            border: OutlineInputBorder(),
                                        ),
                                    ),

                                    const SizedBox(height: 24),

                                    SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                            onPressed: () {
                                                String placa = placaController.text.trim();
                                                String marca = marcaController.text.trim();
                                                String modelo = modeloController.text.trim();
                                                String cor = corController.text.trim();

                                                if (placa.isEmpty ||
                                                    marca.isEmpty ||
                                                    modelo.isEmpty ||
                                                    cor.isEmpty) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                        content: Text('Preencha todos os campos'),
                                                    ),
                                                );
                                            } else {
                                                bool editando = veiculoEmEdicao != null;

                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            editando
                                                                ? 'Veículo atualizado com sucesso'
                                                                : 'Veículo cadastrado com sucesso',
                                                        ),
                                                    ),
                                                );
                    
                                                setState(() {
                                                     if (veiculoEmEdicao == null) {
                                                        veiculosCadastrados.add(
                                                            Veiculo(
                                                                marca: marca,
                                                                modelo: modelo,
                                                                placa: placa,
                                                                cor: cor,
                                                            ),
                                                        );
                                                    } else {
                                                        veiculoEmEdicao!.marca = marca;
                                                        veiculoEmEdicao!.modelo = modelo;
                                                        veiculoEmEdicao!.placa = placa;
                                                        veiculoEmEdicao!.cor = cor;
                                                    }

                                                    veiculoEmEdicao = null;
                                                    mostrarFormulario = false;
                                                });

                                                placaController.clear();
                                                marcaController.clear();
                                                modeloController.clear();
                                                corController.clear();

                                                }
                                            },
                                            
                                            child: const Text('Salvar Veículo'),
                                        ),
                                    ),
                                ],
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}