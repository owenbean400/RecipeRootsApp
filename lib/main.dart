import 'package:flutter/material.dart';
import 'package:recipe_roots/view/window/default.dart';
import 'package:recipe_roots/view/window/people/people_add.dart';
import 'package:recipe_roots/view/window/people/people_view.dart';
import 'package:recipe_roots/view/window/recipe/recipe_view.dart';

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

  NavigationBarState() {
    _widgetOptions = <Widget>[
      const DefaultView(),
      const RecipeView(),
      PeopleView(
        setPeopleNavAddFunction: _addPersonView,
      )
    ];
  }

  List<Widget> _widgetOptions = <Widget>[
    const DefaultView(),
    const RecipeView(),
    const DefaultView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addPersonView() {
    _widgetOptions[2] = PeopleAdd(
      setPeopleNavViewFunction: _viewPersonView,
    );
    setState(() {
      _selectedIndex = 2;
    });
  }

  void _viewPersonView() {
    _widgetOptions[2] = PeopleView(
      setPeopleNavAddFunction: _addPersonView,
    );
    setState(() {
      _selectedIndex = 2;
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
        home: const NavigationBar());
  }
}
