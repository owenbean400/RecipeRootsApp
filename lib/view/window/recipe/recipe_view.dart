import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/recipe.dart';
import 'package:recipe_roots/service/recipe_service.dart';
import 'package:recipe_roots/view/window/recipe/widgets/recipe_search_bar.dart';
import 'package:recipe_roots/view/window/recipe/widgets/recipe_tile.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({super.key});

  @override
  RecipeViewState createState() => RecipeViewState();
}

class RecipeViewState extends State<RecipeView> {
  Future<List<Recipe>> recipes =
      RecipeService().getRecipes("", true, false, false, false, false);

  goToRecipePage(int? recipeId) {}

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
    return (Column(
      children: [
        RecipeSearchBar(
          searchForRecipes: (searchStr, isSearchTitle, isSearchDescription,
              isSearchPeople, isSearchFamilyRelation, isSearchIngredients) {
            searchRecipe(searchStr, isSearchTitle, isSearchDescription,
                isSearchPeople, isSearchFamilyRelation, isSearchIngredients);
          },
        ),
        FutureBuilder<List<Recipe>>(
            future: recipes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<RecipeTile> recipeTitles = [];

                for (var element in snapshot.data!) {
                  recipeTitles.add(RecipeTile(
                    title: element.title,
                    personName:
                        "${element.person.firstName} ${element.person.lastName}",
                    description: element.desc,
                    familyRelation: element.familyRelation,
                    onTapRecipe: (value) {
                      goToRecipePage(value);
                    },
                  ));
                }
                return Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: recipeTitles,
                )));
              } else if (snapshot.hasError) {
                return const Text("Error with data");
              } else {
                return const Text("Waiting for search");
              }
            })
      ],
    ));
  }
}
