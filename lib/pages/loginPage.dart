import 'package:banca_creditos/controllers/creditoController.dart';
import 'package:banca_creditos/controllers/globals.dart';
import 'package:banca_creditos/controllers/userController.dart';
import 'package:banca_creditos/hiveTypeAdapters/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  UserController userController = Get.find();
  CreditoController creditoController = Get.find();
  bool checkCont = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
                padding: const EdgeInsets.fromLTRB(43, 37, 43, 59),
                child: RichText(
                  text: TextSpan(
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      children: const [
                        TextSpan(
                            text: "Inicia sesión o continua,",
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: " solo te tomará unos minutos.")
                      ]),
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
                                  "Email o Usuario",
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF808A93))),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFC8D0D9)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    controller: usernameController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.lock_outline),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    border: Border.all(
                                        color: const Color(0xFFC8D0D9)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    controller: passController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.lock_outline),
                                        hintText: "Contraseña"),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: checkCont,
                                  onChanged: (value) {
                                    setState(() {
                                      checkCont = !checkCont;
                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                const Text("Recordarme"),
                              ],
                            ),
                            InkWell(
                              child: Text(
                                "¿Olvide mi contraseña?",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                if (formKey.currentState!.validate()) {
                                  for (var i = 0; i < boxUsers.length; i++) {
                                    User tempUser = boxUsers.getAt(i);
                                    if(tempUser.email == usernameController.text && tempUser.password == passController.text){
                                      userController.nombre(tempUser.nombre);
                                      userController.id(tempUser.id);
                                      //if creditbox.userId == userId, set cont. else add box
                                      if (checkCont) {
                                        userPrefs.setBool('loggedIn', true);
                                        userPrefs.setInt("id", tempUser.id);
                                      }
                                      context.go("/home");
                                    }
                                  }
                                  
                                } else {
                                  //avisar al usuario que acepte los términos y condiciones
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 120),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text("Iniciar sesión",
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700))),
                            )),
                        Row(children: [
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 20.0),
                                child: const Divider(
                                  color: Color(0xFFA0A7AE),
                                  height: 36,
                                )),
                          ),
                          const Text(
                            "O",
                            style: TextStyle(color: Color(0xFFA0A7AE)),
                          ),
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 10.0),
                                child: const Divider(
                                  color: Color(0xFFA0A7AE),
                                  height: 36,
                                )),
                          ),
                        ]),
                        InkWell(
                          onTap: () {
                            //no-op
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 83),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFC8D0D9))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/GoogleLogo.png",
                                  height: 17,
                                  width: 17,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Ingresa con Google",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF1D1C2B),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //no-op
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 11, bottom: 36),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 83),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFC8D0D9))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/AppleLogo.png",
                                  height: 17,
                                  width: 17,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Ingresa con Apple",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF1D1C2B),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "¿No tienes una cuenta?  ",
                              style: TextStyle(color: Color(0xFF808A93)),
                            ),
                            InkWell(
                              onTap: () {
                                context.go("/signup");
                              },
                              child: Text(
                                " Regístrate",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
