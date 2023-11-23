import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/cooking_step.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/domain/recipe.dart';

class EntireRecipeForm extends ChangeNotifier {
  final int? recipeId;
  final TextEditingController titleRecipeController;
  final TextEditingController descRecipeController;
  final List<TextEditingController> cookingSteps;
  final List<Person> authors;

  EntireRecipeForm({
    this.recipeId,
    required this.titleRecipeController,
    required this.descRecipeController,
    required this.cookingSteps,
    required this.authors,
  });

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

  EntireRecipe getRecipe() {
    return EntireRecipe(
        recipe: Recipe(
            title: titleRecipeController.text,
            people: authors,
            desc: descRecipeController.text),
        cookingSteps:
            cookingSteps.map((e) => CookingStep(instruction: e.text)).toList(),
        ingredients: [],
        authors: authors);
  }
}
