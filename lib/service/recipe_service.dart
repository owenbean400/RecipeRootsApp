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
      await RecipeRootsDAO().addPersonToRecipe(recipeId, person);
    }
  }

  Future<void> editRecipe(EntireRecipe entireRecipe) async {
    if (entireRecipe.recipe.id != null) {
      int newTransfer = -2;
      int oldTransfer = entireRecipe.recipe.id!;

      try {
        await RecipeRootsDAO().updateCookingRecipeID(newTransfer, oldTransfer);
        await RecipeRootsDAO()
            .updateIngredientRecipeID(newTransfer, oldTransfer);
        await RecipeRootsDAO().updatePersonRecipeID(newTransfer, oldTransfer);

        await RecipeRootsDAO()
            .deleteRecipeCookingStepsFromRecipeID(oldTransfer);
        await RecipeRootsDAO().deleteRecipeIngredientsFromRecipeID(oldTransfer);
        await RecipeRootsDAO().deletePersonFromRecipe(oldTransfer);

        await RecipeRootsDAO()
            .addCookingSteps(entireRecipe.cookingSteps, oldTransfer);

        for (Ingredient ingredient in entireRecipe.ingredients) {
          await RecipeRootsDAO().addIngredients(ingredient, oldTransfer);
        }

        for (Person person in entireRecipe.authors) {
          await RecipeRootsDAO().addPersonToRecipe(oldTransfer, person);
        }

        await RecipeRootsDAO()
            .deleteRecipeCookingStepsFromRecipeID(newTransfer);
        await RecipeRootsDAO().deleteRecipeIngredientsFromRecipeID(newTransfer);
        await RecipeRootsDAO().deletePersonFromRecipe(newTransfer);

        await RecipeRootsDAO().updateRecipe(entireRecipe.recipe);
      } catch (e) {
        await RecipeRootsDAO().updateCookingRecipeID(oldTransfer, newTransfer);
        await RecipeRootsDAO()
            .updateIngredientRecipeID(oldTransfer, newTransfer);
        await RecipeRootsDAO().updatePersonRecipeID(oldTransfer, newTransfer);
      }
    } else {
      await addRecipe(entireRecipe);
    }
  }

  Future<void> deleteRecipe(EntireRecipe entireRecipe) async {
    await RecipeRootsDAO().deleteRecipe(entireRecipe.recipe);
  }
}
