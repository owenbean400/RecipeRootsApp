import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/recipe.dart';
import 'package:recipe_roots/helper/the_person.dart';
import 'package:recipe_roots/service/recipe_service.dart';

class SelectionSearchBarForm extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isSearchTitle = true;
  bool isSearchDescription = false;
  bool isSearchPeople = false;
  bool isSearchFamilyRelation = false;
  bool isSearchIngredients = false;

  SelectionSearchBarForm();

  void setSearchTitle() {
    isSearchTitle = true;
    isSearchDescription = false;
    isSearchPeople = false;
    isSearchFamilyRelation = false;
    isSearchIngredients = false;
    notifyListeners();
  }

  void setSearchDescription() {
    isSearchTitle = false;
    isSearchDescription = true;
    isSearchPeople = false;
    isSearchFamilyRelation = false;
    isSearchIngredients = false;
    notifyListeners();
  }

  void setSearchPeople() {
    isSearchTitle = false;
    isSearchDescription = false;
    isSearchPeople = true;
    isSearchFamilyRelation = false;
    isSearchIngredients = false;
    notifyListeners();
  }

  void setSearchFamilyRelation() {
    isSearchTitle = false;
    isSearchDescription = false;
    isSearchPeople = false;
    isSearchFamilyRelation = true;
    isSearchIngredients = false;
    notifyListeners();
  }

  void setSearchIngredients() {
    isSearchTitle = false;
    isSearchDescription = false;
    isSearchPeople = false;
    isSearchFamilyRelation = false;
    isSearchIngredients = true;
    notifyListeners();
  }

  Future<List<Recipe>> getRecipes() {
    return RecipeService().getRecipes(
        searchController.text,
        isSearchTitle,
        isSearchDescription,
        isSearchPeople,
        isSearchFamilyRelation,
        isSearchIngredients,
        ThePersonSingleton().user!);
  }
}
