import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  User(
      {required this.nombre,
      required this.id,
      required this.email,
      required this.password});

  @HiveField(0)
  String nombre;

  @HiveField(1)
  int id;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;
}
