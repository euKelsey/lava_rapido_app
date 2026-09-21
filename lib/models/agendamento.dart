import 'veiculo.dart';
import 'servico.dart';

class Agendamento {
  int? id;
  Veiculo veiculo;
  List<Servico> servicos;
  String data;
  String horario;
  String status;
  double valorTotal;
  bool pago;
  String? formaPagamento;

  Agendamento({
    this.id,
    required this.veiculo,
    required this.servicos,
    required this.data,
    required this.horario,
    required this.status,
    required this.valorTotal,
    required this.pago,
    this.formaPagamento,
  });
}
