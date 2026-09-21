import '../models/veiculo.dart';
import '../models/servico.dart';
import '../models/agendamento.dart';

final List<Veiculo> veiculosCadastrados = [
  Veiculo(
    marca: 'Honda',
    modelo: 'Civic',
    placa: 'ABC1D23',
    cor: 'Preto',
  ),
  Veiculo(
    marca: 'Fiat',
    modelo: 'Uno',
    placa: 'DEF4G56',
    cor: 'Branco',
  ),
];

final List<Servico> servicosDisponiveis = [
  Servico(
    nome: 'Lavagem simples',
    preco: 40.00,
  ),
  Servico(
    nome: 'Lavagem completa',
    preco: 80.00,
  ),
  Servico(
    nome: 'Higienização interna',
    preco: 120.00,
  ),
  Servico(
    nome: 'Enceramento',
    preco: 100.00,
  ),
];

final List<Agendamento> agendamentos = [];