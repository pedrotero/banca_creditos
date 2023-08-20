import 'package:banca_creditos/controllers/creditoController.dart';
import 'package:banca_creditos/controllers/globals.dart';
import 'package:banca_creditos/controllers/userController.dart';
import 'package:banca_creditos/hiveTypeAdapters/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/routes.dart';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  boxUsers = await Hive.openBox<User>("userBox");
  userPrefs = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  final ThemeMode _themeMode = ThemeMode.system;
  UserController userCont = Get.put(UserController());
  CreditoController credCont = Get.put(CreditoController());

  @override
  void initState() {
    super.initState();
    bool? loggedIn = userPrefs.getBool("loggedIn");
    if (loggedIn != null && loggedIn) {
      for (var i = 0; i < boxUsers.length; i++) {
        int id = userPrefs.getInt("id")!;
        User tempUser = boxUsers.getAt(i);
        if (id==tempUser.id) {
          userCont.id(id);
          userCont.nombre(tempUser.nombre);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TrackerApp',
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: const Color(0xFF5428F1)),
      themeMode: _themeMode,
      routerConfig: router,
    );
  }
}
