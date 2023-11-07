import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_steps_view.dart';
import 'package:recipe_roots/view/window/recipe/widgets/ingredients_view.dart';

class RecipeView extends StatelessWidget {
  final EntireRecipe recipe;
  final Function goToRecipeView;

  const RecipeView(
      {super.key, required this.recipe, required this.goToRecipeView});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topLeft, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text(recipe.recipe.title,
                      style: Theme.of(context).textTheme.bodyLarge)),
              Text(recipe.recipe.desc,
                  style: Theme.of(context).textTheme.bodySmall),
              Text(
                  "${recipe.recipe.person.firstName} ${recipe.recipe.person.middleName} ${recipe.recipe.person.lastName}",
                  style: Theme.of(context).textTheme.bodyMedium),
              Text(recipe.recipe.familyRelation ?? "",
                  style: Theme.of(context).textTheme.bodyMedium),
              IngredientsView(ingredients: recipe.ingredients),
              CookingStepsView(cookingSteps: recipe.cookingSteps)
            ],
          ))),
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
            width: constraints.maxWidth,
            padding: EdgeInsets.fromLTRB(16, constraints.maxHeight - 64, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      goToRecipeView();
                    },
                    child: Text("Back",
                        style: Theme.of(context).textTheme.bodyMedium)),
                TextButton(
                    onPressed: () {
                      goToRecipeView();
                    },
                    child: Text("Delete",
                        style: Theme.of(context).textTheme.bodyMedium)),
                TextButton(
                    onPressed: () {
                      goToRecipeView();
                    },
                    child: Text("Edit",
                        style: Theme.of(context).textTheme.bodyMedium))
              ],
            ));
      })
    ]);
  }
}
