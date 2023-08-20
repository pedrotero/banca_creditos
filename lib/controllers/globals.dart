import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum CreditoEnum {
  vehiculo,
  vivienda,
  libreInversion
}

late Box boxUsers;
late SharedPreferences userPrefs;

late var filePermissionStatus;

