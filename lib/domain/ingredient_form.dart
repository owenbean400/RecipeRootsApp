import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/ingredient.dart';

class IngredientForm {
  final TextEditingController ingredientTextController;
  final TextEditingController amountTextController;
  final TextEditingController unitTextController;
  final TextEditingController prepMethodTextController;

  IngredientForm(
      {required this.ingredientTextController,
      required this.amountTextController,
      required this.unitTextController,
      required this.prepMethodTextController});

  Ingredient getIngredient() {
    return Ingredient(
        amount: amountTextController.text,
        unit: unitTextController.text,
        ingredient: ingredientTextController.text,
        prepMethod: prepMethodTextController.text);
  }
}
