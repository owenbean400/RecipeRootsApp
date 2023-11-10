import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/recipe.dart';
import 'package:recipe_roots/service/recipe_service.dart';
import 'package:recipe_roots/view/window/recipe/widgets/recipe_search_bar.dart';
import 'package:recipe_roots/view/window/recipe/widgets/recipe_tile.dart';

class RecipeViews extends StatefulWidget {
  final Function goToRecipeAdd;
  final ValueSetter<EntireRecipe> recipeViewAction;
  const RecipeViews(
      {super.key, required this.recipeViewAction, required this.goToRecipeAdd});

  @override
  RecipeViewsState createState() => RecipeViewsState();
}

class RecipeViewsState extends State<RecipeViews> {
  Future<List<Recipe>> recipes =
      RecipeService().getRecipes("", true, false, false, false, false);

  goToRecipePage(int? recipeId) {
    if (recipeId != null) {
      EntireRecipe entireRecipe = RecipeService().getRecipe(recipeId);
      widget.recipeViewAction(entireRecipe);
    }
  }

  searchRecipe(
      String searchStr,
      bool isSearchTitle,
      bool isSearchDescription,
      bool isSearchPeople,
      bool isSearchFamilyRelation,
      bool isSearchIngredients) {
    setState(() {
      recipes = RecipeService().getRecipes(
          searchStr,
          isSearchTitle,
          isSearchDescription,
          isSearchPeople,
          isSearchFamilyRelation,
          isSearchIngredients);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Stack(
      children: [
        FutureBuilder<List<Recipe>>(
            future: recipes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<RecipeTile> recipeTitles = [];

                for (int i = 0; i < snapshot.data!.length; i++) {
                  recipeTitles.add(RecipeTile(
                      title: snapshot.data![i].title,
                      personName:
                          "${snapshot.data![i].person.firstName} ${snapshot.data![i].person.lastName}",
                      description: snapshot.data![i].desc,
                      familyRelation: snapshot.data![i].familyRelation,
                      onTapRecipe: (value) {
                        goToRecipePage(snapshot.data![i].id);
                      },
                      isBottomBorder: i != snapshot.data!.length - 1));
                }

                return SingleChildScrollView(
                    child: Padding(
                        padding: (Platform.isIOS)
                            ? const EdgeInsets.fromLTRB(0, 120, 0, 0)
                            : const EdgeInsets.fromLTRB(0, 84, 0, 0),
                        child: Column(
                          children: recipeTitles,
                        )));
              } else if (snapshot.hasError) {
                return const Text("Error with data");
              } else {
                return const Text("Waiting for search");
              }
            }),
        RecipeSearchBar(
          searchForRecipes: (searchStr, isSearchTitle, isSearchDescription,
              isSearchPeople, isSearchFamilyRelation, isSearchIngredients) {
            searchRecipe(searchStr, isSearchTitle, isSearchDescription,
                isSearchPeople, isSearchFamilyRelation, isSearchIngredients);
          },
          addRecipe: widget.goToRecipeAdd,
        ),
      ],
    ));
  }
}
