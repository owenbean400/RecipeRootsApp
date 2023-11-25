import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/entire_recipe_form.dart';
import 'package:recipe_roots/service/recipe_service.dart';

class SubmitRecipeFormButton extends StatelessWidget {
  final Function goToRecipeViews;

  const SubmitRecipeFormButton({super.key, required this.goToRecipeViews});

  saveRecipe(EntireRecipe recipe) {
    log("Saved!");
    if (recipe.recipe.id == null) {
      RecipeService().addRecipe(recipe).then((value) => goToRecipeViews());
    } else {
      RecipeService().editRecipe(recipe).then((value) => goToRecipeViews());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EntireRecipeForm>(builder: ((context, recipeForm, child) {
      return ElevatedButton(
        onPressed: () {
          log("Clicked!");
          saveRecipe(recipeForm.getRecipe());
        },
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Text(
              "Submit Recipe Changes",
              style: Theme.of(context).textTheme.bodyMedium,
            )),
      );
    }));
  }
}
