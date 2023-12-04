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
      bool searchIngredients,
      Person user) async {
    List<Recipe> recipes = [];

    if (search == "") {
      recipes = await RecipeRootsDAO().getRecipesAll();
    } else if (searchTitle) {
      recipes = await RecipeRootsDAO().getRecipesBySearchTitle(search);
    } else if (searchDescription) {
      recipes = await RecipeRootsDAO().getRecipesBySearchDescription(search);
    } else if (searchPeople) {
      List<String> names = search.split(" ");

      if (names.length == 1) {
        recipes =
            await RecipeRootsDAO().getRecipesBySearchPeopleOneName(names[0]);
      } else if (names.length == 2) {
        recipes = await RecipeRootsDAO()
            .getRecipesBySearchPeopleTwoName(names[0], names[1]);
      } else {
        recipes = await RecipeRootsDAO()
            .getRecipesBySearchPeopleThreeName(names[0], names[1], names[2]);
      }
    } else if (searchFamilyRelation) {
      recipes = await RecipeRootsDAO().getRecipesBySearchFamilyRelation(search);
    } else if (searchIngredients) {
      recipes = await RecipeRootsDAO().getRecipesBySearchIngredient(search);
    }

    for (Recipe recipe in recipes) {
      if (recipe.id != null) {
        recipe.people = await RecipeRootsDAO().getAuthorOfRecipe(recipe.id!);

        for (Person person in recipe.people) {
          person.familyRelation =
              await RecipeRootsDAO().getFamilyRelation(user, person);
        }
      }
    }

    return recipes;
  }

  Future<EntireRecipe> getRecipe(Recipe recipe, Person user) async {
    List<Ingredient> ingredients =
        await RecipeRootsDAO().getIngredientFromRecipe(recipe.id!);
    List<CookingStep> cookingSteps =
        await RecipeRootsDAO().getCookingSteps(recipe.id!);
    List<Person> authors = await RecipeRootsDAO().getAuthorOfRecipe(recipe.id!);

    for (Person person in authors) {
      person.familyRelation =
          await RecipeRootsDAO().getFamilyRelation(user, person);
    }

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
      int id = entireRecipe.recipe.id!;
      
      await RecipeRootsDAO().performRecipeEdit(entireRecipe, id);
    } else {
      await addRecipe(entireRecipe);
    }
  }

  Future<void> deleteRecipe(EntireRecipe entireRecipe) async {
    await RecipeRootsDAO().deleteRecipe(entireRecipe.recipe);
  }
}
