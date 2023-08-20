import 'package:banca_creditos/controllers/creditoController.dart';
import 'package:banca_creditos/controllers/globals.dart';
import 'package:banca_creditos/controllers/userController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formatter = NumberFormat('0,000,000.0#');
  UserController userController = Get.find();
  CreditoController creditController = Get.find();
  TextEditingController salarioCont = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CreditoEnum? dropCont;
  String cuotaMaxima = "";
  TextEditingController prestCont = TextEditingController();
  String salHintText = "\$ 10000000";
  TextEditingController cuotasCont = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(24, 50, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text('Hola ${userController.nombre} 👋',
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500)))),
                      InkWell(
                        onTap: () {
                          userPrefs.setBool("loggedIn", false);
                          context.go("/login");
                        },
                        child: const Icon(
                          Icons.exit_to_app,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Simulador de crédito",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 14),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ingresa los datos para tu crédito según lo que necesites.",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                    ),
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 14),
                            child:
                                Text("¿Qué tipo de créditos deseas realizar?"),
                          ),
                          DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFFC8D0D9), width: 1),
                                      borderRadius: BorderRadius.circular(6))),
                              value: dropCont,
                              hint: const Text(
                                "Selecciona el tipo de créditos",
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xFFC8D0D9)),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Elija un tipo de crédito.';
                                }
                                return null;
                              },
                              items: const [
                                DropdownMenuItem(
                                  value: CreditoEnum.vehiculo,
                                  child: Text(
                                    "Crédito de vehículo",
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0xFF000000)),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: CreditoEnum.vivienda,
                                  child: Text(
                                    "Crédito de vivienda",
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0xFF000000)),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: CreditoEnum.libreInversion,
                                  child: Text(
                                    "Crédito de libre inversión",
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0xFF000000)),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  dropCont = value;
                                  creditController.tipoInv(value);
                                  print("value $value, cont $dropCont");
                                });
                              }),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text("¿Cuántos es tu salario base?"),
                          ),
                          TextFormField(
                            controller: salarioCont,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingrese un valor válido.';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                int? salario = int.tryParse(salarioCont.text);
                                if (salario != null) {
                                  prestCont.text =
                                      (salario * 7 ~/ 0.15).toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                salHintText = "";
                              });
                            },
                            decoration: InputDecoration(
                                hintText: salHintText,
                                prefix: const Text("\$"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              "Digíta tu salario para calcular el préstamo que necesitas",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF525B64)),
                            ),
                          ),
                          Container(
                            decoration:
                                const BoxDecoration(color: Color(0xFFE0E0E0)),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese un valor válido.';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              controller: prestCont,
                              decoration: InputDecoration(
                                  hintText: " 0",
                                  prefix: const Text("\$"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              "¿A cuántos meses?",
                            ),
                          ),
                          TextFormField(
                            controller: cuotasCont,
                            validator: (value) {
                              int? valInt = int.tryParse(value!);
                              if (valInt == null) {
                                return 'Ingrese un valor válido.';
                              } else if (valInt < 12 || valInt > 84) {
                                return 'Elija un plazo entre 12 y 84 meses';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "84",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              "Elije un plazo desde 12 hasta 84 meses",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF525B64)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (formKey.currentState!.validate()) {
                                      int? prestInt =
                                          int.tryParse(prestCont.text);
                                      int? cuotasInt =
                                          int.tryParse(cuotasCont.text);
                                      if (prestInt != null &&
                                          cuotasInt != null) {
                                        creditController
                                            .creditoValue(prestInt.toDouble());
                                        creditController.numCuotas(cuotasInt);
                                        creditController.genCuotas();
                                        cuotaMaxima = formatter.format(
                                            creditController.getCuotasSum());
                                        context.push("/table");
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 120),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text("Simular",
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700))),
                                )),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
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
