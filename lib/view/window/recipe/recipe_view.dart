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
    return Stack(
      children: [
        SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 112, 8, 0),
                child: Text(
                    "${recipe.recipe.person.firstName} ${recipe.recipe.person.lastName}",
                    style: Theme.of(context).textTheme.bodyMedium)),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(recipe.recipe.familyRelation ?? "",
                    style: Theme.of(context).textTheme.bodyMedium)),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(recipe.recipe.desc,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return IngredientsView(
                  ingredients: recipe.ingredients,
                  fullWidth: constraints.maxWidth);
            }),
            CookingStepsView(cookingSteps: recipe.cookingSteps),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            )
          ],
        )),
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: 100,
            width: constraints.maxWidth,
            color: Theme.of(context).primaryColor,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 48, 8, 0),
                child: Text(recipe.recipe.title,
                    style: Theme.of(context).textTheme.bodyLarge)),
          );
        }),
      ],
    );
  }
}
