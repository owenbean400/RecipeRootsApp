import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/ingredient.dart';
import 'package:recipe_roots/view/window/recipe/widgets/ingredient_card_view.dart';

class IngredientsView extends StatefulWidget {
  final List<Ingredient> ingredients;
  final double fullWidth;

  const IngredientsView(
      {Key? key, required this.ingredients, required this.fullWidth})
      : super(key: key);

  @override
  IngredientsViewState createState() => IngredientsViewState();
}

class IngredientsViewState extends State<IngredientsView> {
  @override
  Widget build(BuildContext context) {
    List<Row> ingredientsRow = [];

    for (int i = 0; i < widget.ingredients.length; i += 2) {
      if (i + 1 >= widget.ingredients.length) {
        ingredientsRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IngredentCardView(
              amount: widget.ingredients[i].amount,
              unit: widget.ingredients[i].unit,
              ingredient: widget.ingredients[i].ingredient,
              width: (widget.fullWidth - 32) / 2,
            ),
            IngredentCardView(
              amount: "",
              unit: "",
              ingredient: "",
              width: (widget.fullWidth - 32) / 2,
              isShow: false,
            )
          ],
        ));
      } else {
        ingredientsRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IngredentCardView(
              amount: widget.ingredients[i].amount,
              unit: widget.ingredients[i].unit,
              ingredient: widget.ingredients[i].ingredient,
              width: (widget.fullWidth - 32) / 2,
            ),
            IngredentCardView(
              amount: widget.ingredients[i + 1].amount,
              unit: widget.ingredients[i + 1].unit,
              ingredient: widget.ingredients[i + 1].ingredient,
              width: (widget.fullWidth - 32) / 2,
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
                child: Text("Ingredients",
                    style: Theme.of(context).textTheme.bodyMedium)),
            ...ingredientsRow
          ],
        ));
  }
}
