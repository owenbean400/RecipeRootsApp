import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/cooking_step.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/ingredient_form.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/domain/recipe.dart';

class EntireRecipeForm extends ChangeNotifier {
  final int? recipeId;
  final TextEditingController titleRecipeController;
  final TextEditingController descRecipeController;
  final List<TextEditingController> cookingSteps;
  final List<Person> authors;
  final List<IngredientForm> ingredientForms;

  EntireRecipeForm(
      {this.recipeId,
      required this.titleRecipeController,
      required this.descRecipeController,
      required this.cookingSteps,
      required this.authors,
      required this.ingredientForms});

  factory EntireRecipeForm.fromEntireRecipe(EntireRecipe recipe) {
    TextEditingController titleRecipeController = TextEditingController();
    TextEditingController descRecipeController = TextEditingController();

    titleRecipeController.text = recipe.recipe.title;
    descRecipeController.text = recipe.recipe.desc;

    List<TextEditingController> cookingStepsControllers =
        recipe.cookingSteps.map(((cookingStep) {
      TextEditingController cookingStepController = TextEditingController();
      cookingStepController.text = cookingStep.instruction;

      return cookingStepController;
    })).toList();

    List<IngredientForm> ingredientForms =
        recipe.ingredients.map(((ingredient) {
      TextEditingController ingredientTextController = TextEditingController();
      TextEditingController amountTextController = TextEditingController();
      TextEditingController unitTextController = TextEditingController();
      TextEditingController prepMethodTextController = TextEditingController();

      ingredientTextController.text = ingredient.ingredient;
      amountTextController.text = ingredient.amount;
      unitTextController.text = ingredient.unit;
      prepMethodTextController.text = ingredient.prepMethod ?? "";

      IngredientForm ingredientForm = IngredientForm(
          ingredientTextController: ingredientTextController,
          amountTextController: amountTextController,
          unitTextController: unitTextController,
          prepMethodTextController: prepMethodTextController);

      return ingredientForm;
    })).toList();

    return EntireRecipeForm(
        recipeId: recipe.recipe.id,
        titleRecipeController: titleRecipeController,
        descRecipeController: descRecipeController,
        cookingSteps: cookingStepsControllers,
        authors: recipe.authors,
        ingredientForms: ingredientForms);
  }

  personUpdate(Person person, int index) {
    if (index >= 0 && index < authors.length) {
      authors[index] = person;
      notifyListeners();
    }
  }

  personRemoveEnd() {
    if (authors.isNotEmpty) {
      authors.removeAt(authors.length - 1);
      notifyListeners();
    }
  }

  personAdd(Person person) {
    authors.add(person);
    notifyListeners();
  }

  cookingStepAdd(String instruction) {
    TextEditingController cookingStepTextEditingController =
        TextEditingController();
    cookingStepTextEditingController.text = instruction;

    cookingSteps.add(cookingStepTextEditingController);
    notifyListeners();
  }

  cookingStepRemove(int step) {
    if (step >= 0 && step < cookingSteps.length) {
      cookingSteps.removeAt(step);
      notifyListeners();
    }
  }

  ingredientAdd(String ingredient, String amount, String unit, String prep) {
    TextEditingController ingredientTextController = TextEditingController();
    TextEditingController amountTextController = TextEditingController();
    TextEditingController unitTextController = TextEditingController();
    TextEditingController prepMethodTextController = TextEditingController();

    ingredientTextController.text = ingredient;
    amountTextController.text = amount;
    unitTextController.text = unit;
    prepMethodTextController.text = prep;

    ingredientForms.add(IngredientForm(
        ingredientTextController: ingredientTextController,
        amountTextController: amountTextController,
        unitTextController: unitTextController,
        prepMethodTextController: prepMethodTextController));
    notifyListeners();
  }

  ingredientRemove(int index) {
    if (index >= 0 && index < ingredientForms.length) {
      ingredientForms.removeAt(index);
    }
    notifyListeners();
  }

  EntireRecipe getRecipe() {
    return EntireRecipe(
        recipe: Recipe(
            id: recipeId,
            title: titleRecipeController.text,
            people: authors,
            desc: descRecipeController.text),
        cookingSteps:
            cookingSteps.map((e) => CookingStep(instruction: e.text)).toList(),
        ingredients: ingredientForms
            .map((ingredient) => ingredient.getIngredient())
            .toList(),
        authors: authors);
  }
}
