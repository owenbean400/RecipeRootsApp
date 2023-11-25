import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe_form.dart';
import 'package:recipe_roots/view/window/recipe/widgets/ingredient_add_view.dart';

class IngredientsAdd extends StatefulWidget {
  const IngredientsAdd({super.key});

  @override
  IngredientsAddState createState() => IngredientsAddState();
}

class IngredientsAddState extends State<IngredientsAdd> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Consumer<EntireRecipeForm>(builder: ((context, recipeForm, child) {
        List<IngredientAdd> ingredientWidgets = [];

        for (int i = 0; i < recipeForm.ingredientForms.length; i++) {
          ingredientWidgets.add(IngredientAdd(
            ingredientController:
                recipeForm.ingredientForms[i].ingredientTextController,
            amountController:
                recipeForm.ingredientForms[i].amountTextController,
            unitController: recipeForm.ingredientForms[i].unitTextController,
            prepController:
                recipeForm.ingredientForms[i].prepMethodTextController,
            deleteIngredient: (value) {
              recipeForm.ingredientRemove(value);
            },
            index: i,
          ));
        }

        return Container(
            width: constraints.maxWidth,
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text("Ingredients",
                        style: Theme.of(context).textTheme.bodyLarge)),
                InkWell(
                    onTap: () {
                      recipeForm.ingredientAdd("", "", "", "");
                    },
                    child: Text(
                      "+",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    )),
              ]),
              (ingredientWidgets.isEmpty)
                  ? Container()
                  : (ingredientWidgets.length == 1)
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(39, 0, 39, 0),
                          height: 500,
                          child: ingredientWidgets.first)
                      : CarouselSlider(
                          items: ingredientWidgets,
                          options: CarouselOptions(height: 500.0))
            ]));
      }));
    });
  }
}
