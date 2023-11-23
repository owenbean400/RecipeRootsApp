import 'package:recipe_roots/dao/recipe_roots_dao.dart';
import 'package:recipe_roots/domain/cooking_step.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/ingredient.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/domain/recipe.dart';

class RecipeService {
  Future<List<Recipe>> getRecipes(
      String search,
      bool searchTitle,
      bool searchDescription,
      bool searchPeople,
      bool searchFamilyRelation,
      bool searchIngredients) async {
    if (search == "") {
      return await RecipeRootsDAO().getRecipesAll();
    } else if (searchTitle) {
      return await RecipeRootsDAO().getRecipesBySearchTitle(search);
    } else if (searchDescription) {
      return await RecipeRootsDAO().getRecipesBySearchDescription(search);
    } else if (searchPeople) {
      List<String> names = search.split("");

      if (names.length == 1) {
        return await RecipeRootsDAO().getRecipesBySearchPeopleOneName(names[0]);
      } else if (names.length == 2) {
        return await RecipeRootsDAO()
            .getRecipesBySearchPeopleTwoName(names[0], names[1]);
      } else {
        return await RecipeRootsDAO()
            .getRecipesBySearchPeopleThreeName(names[0], names[1], names[2]);
      }
    } else if (searchFamilyRelation) {
      return await RecipeRootsDAO().getRecipesBySearchFamilyRelation(search);
    } else if (searchIngredients) {
      return await RecipeRootsDAO().getRecipesBySearchIngredient(search);
    }

    return [];
  }

  Future<EntireRecipe> getRecipe(Recipe recipe) async {
    List<Ingredient> ingredients =
        await RecipeRootsDAO().getIngredientFromRecipe(recipe.id!);
    List<CookingStep> cookingSteps =
        await RecipeRootsDAO().getCookingSteps(recipe.id!);
    List<Person> authors = await RecipeRootsDAO().getAuthorOfRecipe(recipe.id!);

    return EntireRecipe(
        recipe: recipe,
        cookingSteps: cookingSteps,
        ingredients: ingredients,
        authors: authors);
  }

  Future<void> addRecipe(EntireRecipe entireRecipe) async {
    int recipeId = await RecipeRootsDAO().addRecipe(entireRecipe.recipe);

    await RecipeRootsDAO().addCookingSteps(entireRecipe.cookingSteps, recipeId);

    for (Ingredient ingredient in entireRecipe.ingredients) {
      await RecipeRootsDAO().addIngredients(ingredient, recipeId);
    }

    for (Person person in entireRecipe.authors) {
      await RecipeRootsDAO().updatePersonToRecipe(recipeId, person);
    }
  }
}
