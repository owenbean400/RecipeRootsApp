import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe_form.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_step_add.dart';

class CookingStepsAdd extends StatelessWidget {
  const CookingStepsAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Consumer<EntireRecipeForm>(builder: ((context, recipeForm, child) {
        List<CookingStepAdd> cookingStepWidget = [];

        for (int i = 0; i < recipeForm.cookingSteps.length; i++) {
          cookingStepWidget.add(CookingStepAdd(
              textController: recipeForm.cookingSteps[i],
              step: i,
              isDelete: (value) {
                recipeForm.cookingStepRemove(value);
              }));
        }
        return SizedBox(
            width: constraints.maxWidth,
            child: Column(children: [
              ...cookingStepWidget,
              ElevatedButton(
                onPressed: () {
                  recipeForm.cookingStepAdd("");
                },
                style: Theme.of(context).elevatedButtonTheme.style,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(
                      "Add Another Cooking Step",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              )
            ]));
      }));
    });
  }
}
