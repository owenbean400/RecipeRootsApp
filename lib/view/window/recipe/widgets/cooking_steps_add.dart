import 'package:carousel_slider/carousel_slider.dart';
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
        List<CookingStepAdd> cookingStepsWidget = [];

        for (int i = 0; i < recipeForm.cookingSteps.length; i++) {
          cookingStepsWidget.add(CookingStepAdd(
              textController: recipeForm.cookingSteps[i],
              step: i,
              isDelete: (value) {
                recipeForm.cookingStepRemove(value);
              }));
        }
        return SizedBox(
            width: constraints.maxWidth,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text("Cooking Steps",
                        style: Theme.of(context).textTheme.bodyLarge)),
                InkWell(
                    onTap: () {
                      recipeForm.cookingStepAdd("");
                    },
                    child: Text(
                      "+ ",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    )),
              ]),
              (cookingStepsWidget.isEmpty)
                  ? Container()
                  : (cookingStepsWidget.length == 1)
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(39, 0, 39, 0),
                          height: 360,
                          child: cookingStepsWidget.first)
                      : CarouselSlider(
                          items: cookingStepsWidget,
                          options: CarouselOptions(height: 360.0))
            ]));
      }));
    });
  }
}
