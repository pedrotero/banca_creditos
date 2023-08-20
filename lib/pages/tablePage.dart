import 'package:banca_creditos/controllers/creditoController.dart';
import 'package:banca_creditos/controllers/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TablePage extends StatefulWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  CreditoController creditController = Get.find();
  var formatter = NumberFormat('#,###.0#');
  int cuotaCount = 0;
  XcelWorkBook xcel = XcelWorkBook();
  @override
  void initState() {
    super.initState();
    openSimModal(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    xcel.workbook.dispose();
  }

  void openSimModal(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          builder: (context) {
            return Stack(
              alignment: const Alignment(0, 1),
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(29, 23, 29, 0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(18))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cuota máxima de préstamo ",
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                ),
                                Obx(() => Text(
                                      "\$ ${formatter.format(creditController.cuotas[0].valor * creditController.numCuotas.value)}",
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w700)),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "*Este valor suele cambiar con respecto\na tu salario",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: Container(
                                width: 43,
                                height: 43,
                                decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: Colors.white,
                                    shadows: [BoxShadow()]),
                                child: const Icon(
                                  Icons.close,
                                  size: 24,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 75, 18, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Resultado de tu\nsimulador de crédito",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: Text(
                "Te presentamos en tu tabla de amortización el resultado del movimiento de tu crédito.",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Tabla de créditos",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Obx(() {
              cuotaCount = 0;
              return DataTable(
                  columnSpacing: 10,
                  columns: [
                    DataColumn(
                        label: Text(
                      "No. Cuota",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w700)),
                    )),
                    DataColumn(
                        label: Text(
                      "Valor de la cuota",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w700)),
                    )),
                    DataColumn(
                        label: Text(
                      "Interés",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w700)),
                    )),
                    DataColumn(
                        label: Text(
                      "Abono a capital",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w700)),
                    ))
                  ],
                  rows: creditController.cuotas.map((cuotaObj) {
                    cuotaCount++;
                    double interes = 0;
                    switch (creditController.tipoInv.value) {
                      case CreditoEnum.vehiculo:
                        interes = 0.03;
                        break;
                      case CreditoEnum.vivienda:
                        interes = 0.01;
                        break;
                      case CreditoEnum.libreInversion:
                        interes = 0.035;
                        break;
                      default:
                        interes = 0.03;
                    }
                    return DataRow(cells: [
                      DataCell(Text("$cuotaCount")),
                      DataCell(Text(formatter.format(cuotaObj.valor))),
                      DataCell(Text("${formatter.format((interes * 100))}%")),
                      DataCell(Text(
                        "+${formatter.format(cuotaObj.abono)}",
                        style: TextStyle(color: Colors.green),
                      )),
                    ]);
                  }).toList());
            }),
            InkWell(
                onTap: () async {
                    xcel.sheet.getRangeByIndex(1, 1).setText("No. Cuota");
                    xcel.sheet.getRangeByIndex(1, 2).setText("Valor Cuota");
                    xcel.sheet.getRangeByIndex(1, 3).setText("Interés");
                    xcel.sheet.getRangeByIndex(1, 4).setText("Abono a Capital");
                    for (var i = 0; i < creditController.cuotas.length; i++) {
                      Cuota iCuota = creditController.cuotas[i];
                      xcel.sheet
                          .getRangeByIndex(i + 2, 1)
                          .setText((i + 1).toString());
                      xcel.sheet
                          .getRangeByIndex(i + 2, 2)
                          .setText(formatter.format(iCuota.valor));
                      xcel.sheet
                          .getRangeByIndex(i + 2, 3)
                          .setText(formatter.format(iCuota.interes*100));
                      xcel.sheet
                          .getRangeByIndex(i + 2, 4)
                          .setText(formatter.format(iCuota.abono));
                    }

                    final List<int> bytes = xcel.workbook.saveAsStream();
                    DateTime now = DateTime.now();
                    xcel.saveFileToDest("","tabla_amortizacion $now.xlsx",bytes);

                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Descargar Tabla",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700))),
                )),
          ],
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if (value == 1) {
              //context.go("/historial");
            }
          },
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: const Color(0xFFC7C7C7),
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
                label: "Historial de créditos",
                icon: Icon(
                  Icons.wallet_sharp,
                ))
          ]),
    );
  }
}
