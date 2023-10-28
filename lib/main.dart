import 'package:flutter/material.dart';
import 'package:recipe_roots/view/windows/recipe/recipe_view.dart';

import 'view/windows/default.dart';

void main() {
  runApp(const MainApp());
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    DefaultView(),
    RecipeView(),
    DefaultView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Recipe Roots'),
          backgroundColor: Theme.of(context).primaryColor),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.family_restroom_outlined),
                label: "Family Tree",
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.food_bank_outlined),
                label: "Recipe",
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: "People",
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          backgroundColor: Theme.of(context).primaryColor,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 125, 215, 163),
            textTheme: const TextTheme(
                bodyLarge: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 32),
                bodyMedium: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                bodySmall: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 12))),
        home: const NavigationBar());
  }
}
