import 'package:banca_creditos/controllers/globals.dart';
import 'package:banca_creditos/pages/checkPage.dart';
import 'package:banca_creditos/pages/homePage.dart';
import 'package:banca_creditos/pages/loginPage.dart';
import 'package:banca_creditos/pages/onboardingPage.dart';
import 'package:banca_creditos/pages/signUpPage.dart';
import 'package:banca_creditos/pages/tablePage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: handleInitialLoc(),
  routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const OnboardingPage(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) => const SignUpPage(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/check',
    builder: (context, state) => const CheckPage(),
  ),
  GoRoute(
    path: '/table',
    builder: (context, state) => const TablePage(),
  ),
], navigatorKey: GlobalKey<NavigatorState>());

handleInitialLoc() {
  bool? loggedIn = userPrefs.getBool("loggedIn");
  return (loggedIn!= null && loggedIn) ? "/home":"/";
}
