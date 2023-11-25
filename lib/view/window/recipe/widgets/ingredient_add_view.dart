import 'package:flutter/material.dart';
import 'package:recipe_roots/view/window/people/people_add.dart';
import 'package:recipe_roots/view/window/people/widgets/people_text_field.dart';

class IngredientAdd extends StatelessWidget {
  final TextEditingController ingredientController;
  final TextEditingController amountController;
  final TextEditingController unitController;
  final TextEditingController prepController;
  final ValueSetter<int> deleteIngredient;
  final int index;

  const IngredientAdd(
      {super.key,
      required this.ingredientController,
      required this.amountController,
      required this.unitController,
      required this.prepController,
      required this.deleteIngredient,
      required this.index});

  void removeRecord() {
    deleteIngredient(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).hintColor),
      child: Column(children: [
        PeopleTextField(
          textFieldController: ingredientController,
          labelText: "Ingredient",
          barColor: Theme.of(context).primaryColorLight,
        ),
        PeopleTextField(
          textFieldController: amountController,
          labelText: "Amount",
          barColor: Theme.of(context).primaryColorLight,
        ),
        PeopleTextField(
          textFieldController: unitController,
          labelText: "Unit",
          barColor: Theme.of(context).primaryColorLight,
        ),
        PeopleTextField(
          textFieldController: prepController,
          labelText: "Prep",
          barColor: Theme.of(context).primaryColorLight,
        ),
        ElevatedActionButton(
          buttonText: "Remove Ingredient",
          action: removeRecord,
        ),
        Text("${index + 1}")
      ]),
    );
  }
}
