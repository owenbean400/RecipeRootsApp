import 'package:recipe_roots/domain/cooking_step.dart';
import 'package:recipe_roots/domain/ingredient.dart';
import 'package:recipe_roots/domain/recipe.dart';

class EntireRecipe {
  final Recipe recipe;
  final List<CookingStep> cookingSteps;
  final List<Ingredient> ingredients;

  EntireRecipe(
      {required this.recipe,
      required this.cookingSteps,
      required this.ingredients});
}
