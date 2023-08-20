import 'package:get/get.dart';
import 'dart:math';
import 'globals.dart';

class CreditoController extends GetxController {
  RxDouble salario = 0.0.obs;
  Rx<CreditoEnum> tipoInv = CreditoEnum.vehiculo.obs;
  RxDouble creditoValue = 0.0.obs;
  RxInt numCuotas = 0.obs;
  RxList<Cuota> cuotas = List<Cuota>.empty().obs;

  void genCuotas() {
    cuotas([]);
    double prestamoTotal = creditoValue.value;
    int numCuotas = this.numCuotas.value;
    double interesTot;
    switch (tipoInv.value) {
      case CreditoEnum.vehiculo:
        interesTot = 0.03;
        break;
      case CreditoEnum.vivienda:
        interesTot = 0.01;
        break;
      case CreditoEnum.libreInversion:
        interesTot = 0.035;
        break;
      default:
        interesTot = 0.03;
    }
    
    double valorCuota =
        (prestamoTotal * interesTot) / ( 1 -  pow(1 + interesTot, -numCuotas));
    print("valorCuota $valorCuota");
    print("prestot $prestamoTotal");
    for (var i = 0; i < numCuotas; i++) {
      
      double saldoInicial = i==0 ? prestamoTotal: cuotas[i-1].saldo;
      double intereses = saldoInicial*interesTot;
      double abono = valorCuota - intereses;
      double saldo = saldoInicial - abono;
      print("saldo $saldo");
      cuotas.add(Cuota(valor: valorCuota, interes: intereses, abono: abono, saldo: saldo));
    }
  }

  double getCuotasSum(){
    return -cuotas[0].valor * cuotas.length;
  }
}

class Cuota {
  Cuota({required this.valor, required this.interes, required this.abono, required this.saldo});
  double valor;
  double interes;
  double abono;
  double saldo;
}
