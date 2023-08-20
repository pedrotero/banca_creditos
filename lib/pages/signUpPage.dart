import 'package:banca_creditos/controllers/globals.dart';
import 'package:banca_creditos/controllers/userController.dart';
import 'package:banca_creditos/hiveTypeAdapters/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool checkCont = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/spinner-two.png",
                  height: 43,
                  width: 43,
                ),
                Text("Banca créditos",
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0C1022),
                    )))
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 23, 0, 26),
              child: Column(
                children: [
                  const Text(
                    "Regístrate",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0C1022),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: const Text(
                      "Solo te tomará unos minutos.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF91A1B2),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.fromLTRB(29, 0, 34, 0),
                child: IntrinsicWidth(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(bottom: 14),
                              child: Text(
                                "Nombre completo",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF808A93))),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: const Color(0xFFC8D0D9)),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(6))),
                              child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: nombreController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Ingrese un valor válido.';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.person_outline),
                                      hintText: "Escribe tu nombre"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(bottom: 14),
                              child: Text(
                                "Identificación",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF808A93))),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: const Color(0xFFC8D0D9)),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(6))),
                              child: SizedBox(
                                width: 327,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  controller: idController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Ingrese un valor válido.';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Escribe tu número de identificación"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(bottom: 14),
                              child: Text(
                                "Email",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF808A93))),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: const Color(0xFFC8D0D9)),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(6))),
                              child: SizedBox(
                                width: 327,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person_outline),
                                      border: InputBorder.none,
                                      hintText: "Uname@mail.com"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Ingrese un valor válido.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(bottom: 14),
                              child: Text(
                                "Contraseña",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF808A93))),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: const Color(0xFFC8D0D9)),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(6))),
                              child: SizedBox(
                                width: 327,
                                child: TextFormField(
                                  controller: passController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Escribe tu contraseña",
                                      prefixIcon: Icon(Icons.lock_outline)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Ingrese un valor válido.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 11, 0, 25),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                activeColor: const Color(0xFF5428F1),
                                value: checkCont,
                                onChanged: (value) {
                                  setState(() {
                                    checkCont = !checkCont;
                                  });
                                }),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                    text: "Acepto los ",
                                    children: [
                                      TextSpan(
                                          text: "Términos",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      const TextSpan(text: " y "),
                                      TextSpan(
                                          text: "Condiciones",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      const TextSpan(text: " y la "),
                                      TextSpan(
                                          text: "Política de privacidad ",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      const TextSpan(text: "de Banca de Créditos")
                                    ],
                                    style: const TextStyle(
                                        color: Color(0xFF0C1022))),
                                textAlign: TextAlign.left,
                                softWrap: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (formKey.currentState!.validate() && checkCont) {
                                for (var i = 0; i < boxUsers.length; i++) {
                                  var curUser = boxUsers.getAt(i);
                                  if (curUser.nombre == nombreController.text ||
                                      curUser.id ==
                                          int.parse(idController.text)) {
                                    return;
                                  }
                                }
                                setState(() {
                                  boxUsers.add(User(
                                      nombre: nombreController.text,
                                      id: int.parse(idController.text),
                                      email: emailController.text,
                                      password: passController.text));
                                });
                                userController.nombre(nombreController.text);
                                userController.id(int.parse(idController.text));
                                context.go("/check");
                              } else {
                                //avisar al usuario que acepte los términos y condiciones
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 125),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Continuar",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700))),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿Ya tienes una cuenta?  ",
                    style: TextStyle(color: Color(0xFF808A93)),
                  ),
                  InkWell(
                    onTap: () {
                      context.push("/login");
                    },
                    child: Text(
                      " Inicia Sesión",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
