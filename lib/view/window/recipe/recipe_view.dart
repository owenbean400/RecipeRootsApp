import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/service/recipe_service.dart';
import 'package:recipe_roots/view/widget/header_backspace.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_steps_view.dart';
import 'package:recipe_roots/view/window/recipe/widgets/ingredients_view.dart';

class RecipeView extends StatelessWidget {
  final EntireRecipe recipe;
  final Function goToRecipeViews;
  final ValueSetter<EntireRecipe> goEditRecipe;

  const RecipeView(
      {super.key,
      required this.recipe,
      required this.goToRecipeViews,
      required this.goEditRecipe});

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
                padding: EdgeInsets.fromLTRB(
                    8, MediaQuery.of(context).viewPadding.top + 64, 8, 0)),
            (recipe.authors.isNotEmpty)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: recipe.authors
                        .map((author) => Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Text(
                                  "${author.firstName} ${author.lastName} ${(author.familyRelation != null) ? "- ${author.familyRelation!.familyRelation}" : ""}",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ))
                        .toList(),
                  )
                : Container(),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text("", style: Theme.of(context).textTheme.bodyMedium)),
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
            (recipe.cookingSteps.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text(
                        (recipe.cookingSteps.length == 1)
                            ? "Cooking Step"
                            : "Cooking Steps",
                        style: Theme.of(context).textTheme.bodyMedium))
                : Container(),
            CookingStepsView(cookingSteps: recipe.cookingSteps),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        RecipeService()
                            .deleteRecipe(recipe)
                            .then((value) => goToRecipeViews());
                      },
                      child: Text("Delete",
                          style: Theme.of(context).textTheme.bodyMedium)),
                  TextButton(
                      onPressed: () {
                        goEditRecipe(recipe);
                      },
                      child: Text("Edit",
                          style: Theme.of(context).textTheme.bodyMedium))
                ],
              ),
            )
          ],
        )),
        HeaderBackspace(
            title: recipe.recipe.title, backSpaceAction: goToRecipeViews),
      ],
    );
  }
}
