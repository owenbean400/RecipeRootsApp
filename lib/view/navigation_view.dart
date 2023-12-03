import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/child_to_parent.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/view/window/default.dart';
import 'package:recipe_roots/view/window/family_tree/family_tree_add.dart';
import 'package:recipe_roots/view/window/family_tree/family_tree_view.dart';
import 'package:recipe_roots/view/window/family_tree/family_tree_view_list.dart';
import 'package:recipe_roots/view/window/people/people_add.dart';
import 'package:recipe_roots/view/window/people/people_view.dart';
import 'package:recipe_roots/view/window/recipe/recipe_edit.dart';
import 'package:recipe_roots/view/window/recipe/recipe_view.dart';
import 'package:recipe_roots/view/window/recipe/recipes_view.dart';
import 'package:recipe_roots/domain/recipe.dart';

GlobalKey<NavigationBarState> navigationBarKey = GlobalKey<NavigationBarState>();

class NavigationViewBar extends StatefulWidget {
  NavigationViewBar({Key? key}) : super(key: navigationBarKey);

  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationViewBar> {
  int _selectedIndex = 1;
  int _selectedChildParentIndex = 0;

  NavigationBarState() {
    _widgetOptions = <Widget>[
      FamilyTreeView(
        setAddFamilyTree: _addFamilyTree,
        goToChildToParentList: _viewFamilyTreeViews,
      ),
      RecipeViews(
        goToRecipeAdd: _addRecipeView,
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

  void _addRecipeView() {
    _widgetOptions[1] = RecipeEdit(goToRecipeViews: _viewRecipesViews);
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _addFamilyTree(ChildToParent? childToParent) {
    _widgetOptions[0] = ChildToParentAdd(
        childToParent: childToParent,
        goToViewFamilyTree: (_selectedChildParentIndex == 1)
            ? _viewFamilyTreeList
            : _viewFamilyTreeViews);
    setState(() {
      _selectedIndex = 0;
    });
  }

  void _editRecipeView(EntireRecipe recipe) {
    _widgetOptions[1] = RecipeEdit(
      goToRecipeViews: _viewRecipesViews,
      editRecipe: recipe,
    );
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _editPersonView(FamilyRelation familyRelation) {
    _widgetOptions[2] = PeopleAdd(
        familyRelation: familyRelation,
        setPeopleNavViewFunction: _viewPersonView);
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
      goToRecipeViews: _viewRecipesViews,
      goEditRecipe: _editRecipeView,
    );
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _viewRecipesViews() {
    _widgetOptions[1] = RecipeViews(
      goToRecipeAdd: _addRecipeView,
      recipeViewAction: (value) {
        _viewRecipeViews(value);
      },
    );
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _viewFamilyTreeViews() {
    _widgetOptions[0] = FamilyTreeView(
        setAddFamilyTree: _addFamilyTree,
        goToChildToParentList: _viewFamilyTreeList);
    setState(() {
      _selectedChildParentIndex = 0;
      _selectedIndex = 0;
    });
  }

  void _viewFamilyTreeList() {
    _widgetOptions[0] = FamilyTreeViewList(
        setAddFamilyTree: _addFamilyTree,
        setTreeGraphView: _viewFamilyTreeViews);
    setState(() {
      _selectedChildParentIndex = 1;
      _selectedIndex = 0;
    });
  }

  void updateRecipeView(List<Recipe> recipes) {
    _widgetOptions[1] = RecipeViews(
      goToRecipeAdd: _addRecipeView,
      recipeViewAction: (value) {
        _viewRecipeViews(value);
      },
      specificRecipes: recipes,
    );
    setState(() {
      _selectedIndex = 1; // Switch to RecipeViews tab
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
