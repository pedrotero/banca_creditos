import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ Image.asset("assets/images/Ellipse1.png"),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment(0, 0),
                  children: [
                    SvgPicture.asset("assets/images/MaskGroup5.svg"),
                    const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    )
                  ],
                ),
                Text(
                  "Registro exitoso",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700)),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 8, 20, 25),
                  child: Text(
                    "Hemos guardado tus credenciales de forma exitosa, Presiona continuar para seguir adelante.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Color(0xFF91A1B2),
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                InkWell(
                    onTap: () {
                      context.go("/home");
                    },
                    child: Container(
                      alignment: const Alignment(0, 0),
                      padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 125),
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
        ],
      ),
    );
  }
}
