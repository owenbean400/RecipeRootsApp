import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/view/window/default.dart';
import 'package:recipe_roots/view/window/people/people_add.dart';
import 'package:recipe_roots/view/window/people/people_view.dart';
import 'package:recipe_roots/view/window/recipe/recipe_view.dart';
import 'package:recipe_roots/view/window/recipe/recipes_view.dart';

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
      RecipeViews(
        recipeViewAction: (value) {
          _viewRecipeViews(value);
        },
      ),
      PeopleView(
        setPeopleNavAddFunction: _addPersonView,
        setEditPerson: (value) {
          _editPersonView(value);
        },
      )
    ];
  }

  List<Widget> _widgetOptions = <Widget>[
    const DefaultView(),
    const DefaultView(),
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

  void _editPersonView(int id) {
    _widgetOptions[2] =
        PeopleAdd(id: id, setPeopleNavViewFunction: _viewPersonView);
    setState(() {
      _selectedIndex = 2;
    });
  }

  void _viewPersonView() {
    _widgetOptions[2] = PeopleView(
        setPeopleNavAddFunction: _addPersonView,
        setEditPerson: (value) {
          _editPersonView(value);
        });
    setState(() {
      _selectedIndex = 2;
    });
  }

  void _viewRecipeViews(EntireRecipe recipe) {
    _widgetOptions[1] = RecipeView(
      recipe: recipe,
      goToRecipeView: _viewRecipesViews,
    );
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _viewRecipesViews() {
    _widgetOptions[1] = RecipeViews(
      recipeViewAction: (value) {
        _viewRecipeViews(value);
      },
    );
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
