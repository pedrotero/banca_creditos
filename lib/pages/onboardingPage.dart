import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<double> bars = [0, 0];
  final stopwatch = Stopwatch();
  Timer? timer;
  List<String> images = [
    'assets/images/img_onboarding_0.png',
    'assets/images/img_onboarding_1.png'
  ];
  List<String> onbTexts = [
    'Accede a créditos\n con un solo toque y sin complicaciones.',
    'Toma el control de tus finanzas con confianza y accede a ellas sin restricciones.'
  ];
  int activePage = 0;
  String onboardingText =
      'Accede a créditos\n con un solo toque y sin complicaciones.';
  void handleSlide(int index, CarouselPageChangedReason reason) {
    setState(() {
      stopwatch.reset();
      if (onboardingText == onbTexts[0]) {
        onboardingText = onbTexts[1];
        bars[0]=1;
        bars[1]=0;
      }else{
        onboardingText = onbTexts[0];
        bars = [0,0]; 
      }
    });
  }

  void onTimerTick(Timer timer) {
    setState(() {
      if (bars[0]<1) {
        bars[0]=stopwatch.elapsedMilliseconds/7000;
      }else if(bars[1]<1){
        bars[1]=stopwatch.elapsedMilliseconds/7000;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 60), onTimerTick);
    stopwatch.start();
  }

  @override
  void dispose() {
    timer?.cancel();
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Container(
          color: Colors.black,
        ),
        CarouselSlider(
          items: images
              .map((e) => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(e), fit: BoxFit.fill)),
                  ))
              .toList(),
          options: CarouselOptions(
              pauseAutoPlayOnManualNavigate: true,
              onPageChanged: handleSlide,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 7),
              viewportFraction: 1,
              height: double.infinity),
        ),
        IgnorePointer(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(0, -1),
                    end: Alignment(0, 1),
                    colors: [Color(0x00000000), Color(0xF00E111D)])),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: LinearProgressIndicator(
                    value: bars[0],
                    color: Colors.white,
                    backgroundColor: Color.fromARGB(75, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              Expanded(
                child: LinearProgressIndicator(
                    value: bars[1],
                    color: Colors.white,
                    backgroundColor: Color.fromARGB(75, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ],
          ),
        ),
        IntrinsicWidth(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Text(onboardingText,
                      key: ValueKey<String>(onboardingText),
                      style: const TextStyle(
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: Offset(-1.5, -1.5),
                              color: Colors.black),
                          Shadow(
                              // bottomRight
                              offset: Offset(1.5, -1.5),
                              color: Colors.black),
                          Shadow(
                              // topRight
                              offset: Offset(1.5, 1.5),
                              color: Colors.black),
                          Shadow(
                              // topLeft
                              offset: Offset(-1.5, 1.5),
                              color: Colors.black),
                        ],
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  context.push("/login");
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Text(
                    "Ingresar",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.push("/signup");
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: const BoxDecoration(
                      color: Color(0xFF5428F1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Text(
                    "Registrarme",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
