import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/entire_recipe_form.dart';
import 'package:recipe_roots/service/recipe_service.dart';
import 'package:recipe_roots/view/widget/snackbar_error.dart';

class SubmitRecipeFormButton extends StatelessWidget {
  final Function goToRecipeViews;

  const SubmitRecipeFormButton({super.key, required this.goToRecipeViews});

  saveRecipe(EntireRecipe recipe, BuildContext context) {
    if (recipe.recipe.id == null) {
      RecipeService()
          .addRecipe(recipe)
          .then((value) => goToRecipeViews())
          .catchError((e) => {
                ScaffoldMessenger.of(context)
                    .showSnackBar(getErrorSnackbar(e.toString(), context))
              });
    } else {
      RecipeService()
          .editRecipe(recipe)
          .then((value) => goToRecipeViews())
          .catchError((e) => {
                ScaffoldMessenger.of(context)
                    .showSnackBar(getErrorSnackbar(e.toString(), context))
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EntireRecipeForm>(builder: ((context, recipeForm, child) {
      return ElevatedButton(
        onPressed: () {
          saveRecipe(recipeForm.getRecipe(), context);
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
