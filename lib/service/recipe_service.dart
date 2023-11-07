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
    List<Recipe> recipes = [];

    // TODO: Replace get recipes with database query
    Person person1 =
        Person(firstName: "Rosalie", middleName: "Grace", lastName: "Bean");
    recipes.add(Recipe(
        id: 0,
        title: "Sweet Apple Pie",
        person: person1,
        familyRelation: "grandmother",
        desc:
            "Sweet Apple pie made from grandmother. She would bake this every year for the beginning of fall."));

    Person person2 =
        Person(firstName: "Bruce", middleName: "", lastName: "Bean");
    recipes.add(Recipe(
        id: 1,
        title: "Bitter Apple Pie",
        person: person2,
        desc:
            "Apple pie that was made with salt and apples. It was a joke to replace grandmother apple pie and force us to eat something awful"));

    Person person3 =
        Person(firstName: "Erin", middleName: "", lastName: "Bean");
    recipes.add(Recipe(
        id: 2,
        title: "Gala Apple Pie",
        person: person3,
        familyRelation: "step mother",
        desc:
            "Apple pie made for Owen's 21 birthday. It is made just right for him."));

    Person person4 =
        Person(firstName: "Rosalie", middleName: "Grace", lastName: "Bean");
    recipes.add(Recipe(
        id: 3,
        title: "Sweet Apple Pie",
        person: person4,
        familyRelation: "grandmother",
        desc:
            "Sweet Apple pie made from grandmother. She would bake this every year for the beginning of fall."));

    Person person5 =
        Person(firstName: "Erin", middleName: "", lastName: "Bean");
    recipes.add(Recipe(
        id: 4,
        title: "Gala Apple Pie",
        person: person5,
        familyRelation: "step mother",
        desc:
            "Apple pie made for Owen's 21 birthday. It is made just right for him."));

    Person person6 =
        Person(firstName: "Rosalie", middleName: "Grace", lastName: "Bean");
    recipes.add(Recipe(
        id: 5,
        title: "Sweet Apple Pie",
        person: person6,
        familyRelation: "grandmother",
        desc:
            "Sweet Apple pie made from grandmother. She would bake this every year for the beginning of fall."));

    return recipes;
  }

  EntireRecipe getRecipe(int recipe_id) {
    List<CookingStep> cookingSteps = [];
    List<Ingredient> ingredients = [];

    Recipe recipe = Recipe(
        title: "Title",
        person: Person(firstName: "Erin", middleName: "", lastName: "Bean"),
        desc: "This is where the descript goes where it is goes.");

    // TODO: Replace get recipe to get recipe from database by recipe id.
    cookingSteps.add(CookingStep(id: 1, instruction: "Here is instruction 1"));
    cookingSteps.add(CookingStep(id: 2, instruction: "Here is instruction 2"));
    cookingSteps.add(CookingStep(id: 3, instruction: "Here is instruction 3"));
    cookingSteps.add(CookingStep(id: 4, instruction: "Here is instruction 4"));
    cookingSteps.add(CookingStep(id: 5, instruction: "Here is instruction 5"));
    cookingSteps.add(CookingStep(id: 6, instruction: "Here is instruction 6"));
    cookingSteps.add(CookingStep(id: 7, instruction: "Here is instruction 7"));
    cookingSteps.add(CookingStep(id: 8, instruction: "Here is instruction 8"));
    cookingSteps.add(CookingStep(id: 9, instruction: "Here is instruction 9"));
    cookingSteps
        .add(CookingStep(id: 10, instruction: "Here is instruction 10"));
    cookingSteps
        .add(CookingStep(id: 11, instruction: "Here is instruction 11"));
    cookingSteps
        .add(CookingStep(id: 12, instruction: "Here is instruction 12"));

    ingredients
        .add(Ingredient(amount: "4", unit: "Bags", ingredient: "Apples"));
    ingredients
        .add(Ingredient(amount: "3/4", unit: "Cups", ingredient: "Sugar"));
    ingredients
        .add(Ingredient(amount: "3/4", unit: "Cups", ingredient: "Sugar"));

    return EntireRecipe(
        recipe: recipe, cookingSteps: cookingSteps, ingredients: ingredients);
  }

  addRecipe(EntireRecipe entireRecipe) {}
}
