import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/ingredient.dart';

class IngredientsView extends StatefulWidget {
  final List<Ingredient> ingredients;

  const IngredientsView({Key? key, required this.ingredients})
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "${widget.ingredients[i].amount} ${widget.ingredients[i].unit}  ${widget.ingredients[i].ingredient}",
                style: Theme.of(context).textTheme.bodySmall),
            const Text("")
          ],
        ));
      } else {
        ingredientsRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "${widget.ingredients[i].amount} ${widget.ingredients[i].unit}  ${widget.ingredients[i].ingredient}",
                style: Theme.of(context).textTheme.bodySmall),
            Text(
                "${widget.ingredients[i + 1].amount} ${widget.ingredients[i + 1].unit}  ${widget.ingredients[i + 1].ingredient}",
                style: Theme.of(context).textTheme.bodySmall)
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
            Text("Ingredients", style: Theme.of(context).textTheme.bodyMedium),
            ...ingredientsRow
          ],
        ));
  }
}
