import 'package:recipe_roots/domain/person.dart';

class ThePersonSingleton {
  static final ThePersonSingleton _instance = ThePersonSingleton._internal();
  Person? user;

  factory ThePersonSingleton() {
    return _instance;
  }

  ThePersonSingleton._internal();
}
