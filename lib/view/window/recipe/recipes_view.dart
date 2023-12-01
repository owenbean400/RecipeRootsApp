import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/recipe.dart';
import 'package:recipe_roots/domain/selection_search_bar_form.dart';
import 'package:recipe_roots/helper/the_person.dart';
import 'package:recipe_roots/service/recipe_service.dart';
import 'package:recipe_roots/view/window/recipe/widgets/recipe_search_bar.dart';
import 'package:recipe_roots/view/window/recipe/widgets/recipe_tile.dart';

class RecipeViews extends StatefulWidget {
  final Function goToRecipeAdd;
  final ValueSetter<EntireRecipe> recipeViewAction;
  final List<Recipe>? specificRecipes;

  const RecipeViews({
    Key? key,
    required this.recipeViewAction,
    required this.goToRecipeAdd,
    this.specificRecipes,
  }) : super(key: key);

  @override
  RecipeViewsState createState() => RecipeViewsState();
}

class RecipeViewsState extends State<RecipeViews> {
  Future<List<Recipe>>? recipes;

  @override
  void initState() {
    super.initState();

    recipes = widget.specificRecipes != null 
              ? Future.value(widget.specificRecipes)
              : RecipeService().getRecipes(
                  "", true, false, false, false, false, ThePersonSingleton().user!);
  }

  goToRecipePage(Recipe recipeId) {
    if (recipeId.id != null) {
      RecipeService()
          .getRecipe(recipeId, ThePersonSingleton().user!)
          .then((entireRecipe) => widget.recipeViewAction(entireRecipe));
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
          isSearchIngredients,
          ThePersonSingleton().user!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SelectionSearchBarForm(),
        child: Stack(
          children: [
            FutureBuilder<List<Recipe>>(
                future: recipes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<RecipeTile> recipeTitles = [];

                    for (int i = 0; i < snapshot.data!.length; i++) {
                      recipeTitles.add(RecipeTile(
                          title: snapshot.data![i].title,
                          personName: (snapshot.data![i].people.isNotEmpty)
                              ? "${snapshot.data![i].people.first.firstName} ${snapshot.data![i].people.first.lastName}"
                              : "",
                          description: snapshot.data![i].desc,
                          familyRelation: (snapshot.data![i].people.isNotEmpty)
                              ? snapshot.data![i].people.first.familyRelation
                                  ?.familyRelation
                              : null,
                          onTapRecipe: (value) {
                            goToRecipePage(snapshot.data![i]);
                          },
                          isBottomBorder: i != snapshot.data!.length - 1));
                    }

                    return SingleChildScrollView(
                        child: Padding(
                            padding: (Platform.isIOS)
                                ? const EdgeInsets.fromLTRB(0, 140, 0, 0)
                                : const EdgeInsets.fromLTRB(0, 100, 0, 0),
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
                searchRecipe(
                    searchStr,
                    isSearchTitle,
                    isSearchDescription,
                    isSearchPeople,
                    isSearchFamilyRelation,
                    isSearchIngredients);
              },
              addRecipe: widget.goToRecipeAdd,
            ),
          ],
        ));
  }
}
