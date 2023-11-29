import 'package:flutter/material.dart';
import 'package:recipe_roots/view/setup_user.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 125, 215, 163),
            hintColor: const Color.fromARGB(255, 225, 225, 225),
            primaryColorLight: Colors.white,
            primaryColorDark: Colors.black,
            textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Color.fromARGB(255, 125, 215, 163)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 125, 215, 163))),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 125, 215, 163))),
            textTheme: const TextTheme(
                bodyLarge: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 32),
                bodyMedium: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                bodySmall: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                headlineMedium: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))),
        home: const SetupUserView());
  }
}
