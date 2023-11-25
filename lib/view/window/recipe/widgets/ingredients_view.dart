import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/ingredient.dart';
import 'package:recipe_roots/view/window/recipe/widgets/ingredient_card_view.dart';

class IngredientsView extends StatelessWidget {
  final List<Ingredient> ingredients;
  final double fullWidth;

  const IngredientsView(
      {super.key, required this.ingredients, required this.fullWidth});

  @override
  Widget build(BuildContext context) {
    List<Row> ingredientsRow = [];

    for (int i = 0; i < ingredients.length; i += 2) {
      if (i + 1 >= ingredients.length) {
        ingredientsRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IngredentCardView(
              amount: ingredients[i].amount,
              unit: ingredients[i].unit,
              ingredient: ingredients[i].ingredient,
              width: (fullWidth - 32) / 2,
            ),
            IngredentCardView(
              amount: "",
              unit: "",
              ingredient: "",
              width: (fullWidth - 32) / 2,
              isShow: false,
            )
          ],
        ));
      } else {
        ingredientsRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IngredentCardView(
              amount: ingredients[i].amount,
              unit: ingredients[i].unit,
              ingredient: ingredients[i].ingredient,
              width: (fullWidth - 32) / 2,
            ),
            IngredentCardView(
              amount: ingredients[i + 1].amount,
              unit: ingredients[i + 1].unit,
              ingredient: ingredients[i + 1].ingredient,
              width: (fullWidth - 32) / 2,
            )
          ],
        ));
      }
    }

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 2),
                child: Text(
                    (ingredients.isEmpty)
                        ? ""
                        : (ingredients.length == 1)
                            ? "Ingredient"
                            : "Ingredients",
                    style: Theme.of(context).textTheme.bodyMedium)),
            ...ingredientsRow
          ],
        ));
  }
}
