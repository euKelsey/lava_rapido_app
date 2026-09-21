import '../models/veiculo.dart';
import '../models/servico.dart';
import '../models/agendamento.dart';

final List<Veiculo> veiculosCadastrados = [
  Veiculo(
    id: 1,
    marca: 'Honda',
    modelo: 'Civic',
    placa: 'ABC1D23',
    cor: 'Preto',
  ),
  Veiculo(id: 2, marca: 'Fiat', modelo: 'Uno', placa: 'DEF4G56', cor: 'Branco'),
];

final List<Servico> servicosDisponiveis = [
  Servico(id: 1, nome: 'Lavagem simples', preco: 40.00),
  Servico(id: 2, nome: 'Lavagem completa', preco: 80.00),
  Servico(id: 3, nome: 'Higienização interna', preco: 120.00),
  Servico(id: 4, nome: 'Enceramento', preco: 100.00),
];

final List<Agendamento> agendamentos = [];
