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

  // #11 Query for recipe base on title
  Future<List<Recipe>> getRecipesByTitle(String title) async {
    return [];
  }

  // #38 Query for recipe by description
  Future<List<Recipe>> getRecipesByDescription(String description) async {
    return [];
  }

  // #17 Query for recipe by person
  Future<List<Recipe>> getRecipesByPerson(String name) async {
    return [];
  }

  // TODO: #12 Query for recipes based on family relation
  Future<List<Recipe>> getRecipesByFamilyRelation(String familyRelation) async {
    return [];
  }

  // TODO: #14 Query for recipes based on ingredients
  Future<List<Recipe>> getRecipesByIngredients(String ingredient) async {
    return [];
  }

  // TODO: #39, Query for everything.
  EntireRecipe getRecipe(int recipe_id) {
    List<CookingStep> cookingSteps = [];
    List<Ingredient> ingredients = [];

    Recipe recipe = Recipe(
        title: "Apple Pie",
        person: Person(firstName: "Erin", middleName: "", lastName: "Bean"),
        familyRelation: "Step Mother",
        desc:
            "My stepmother's Apple Pie is a true masterpiece that exudes warmth, comfort, and a delightful aroma. The crust is perfectly flaky, golden-brown, and encases a luscious filling bursting with sweet and tangy flavors.");

    // TODO: Replace get recipe to get recipe from database by recipe id.
    cookingSteps.add(CookingStep(
        id: 1,
        instruction:
            "Start by preparing this flaky pie crust recipe which makes 2 (9'') pie crusts, one for the bottom and one for the top of the pie. The pie dough will need to chill for at least 1 hour before rolling out. Or use a store-bought pie crust and follow package directions."));
    cookingSteps.add(CookingStep(
        id: 2,
        instruction:
            "Place oven rack in the center position and Preheat the oven to 400°F (204°C)."));
    cookingSteps.add(CookingStep(
        id: 3,
        instruction:
            "In a large bowl, combine the sliced apples, granulated sugar, light brown sugar, flour, cinnamon, nutmeg, and lemon juice and lemon zest; toss to coat evenly."));
    cookingSteps.add(CookingStep(
        id: 4,
        instruction:
            "Remove the pie crust dough from the fridge and let rest at room temperature for 5-10 minutes. On a lightly floured surface, roll one disc into a 12'' circle that is ⅛'' thick. Carefully lay the crust into the bottom of a deep dish pie plate."));
    cookingSteps.add(CookingStep(
        id: 5,
        instruction:
            "Spoon the apple filling over the bottom crust and discard juices at the bottom of the bowl. Roll out the second disc of pie crust until it is ⅛'' thick and lay it over the apple filling."));
    cookingSteps.add(CookingStep(
        id: 6,
        instruction:
            "Use a sharp knife to trim the dough along the outside edge of the pie plate. Lift the edges where the two pie crust meet, gently press to seal and fold them under. Rotate the pie plate and repeat this process until edges are neatly tucked under themselves. Cut 4 slits in the top of the dough to allow steam to vent. Place the pie on a baking sheet."));
    cookingSteps.add(CookingStep(
        id: 7,
        instruction:
            "Brush the surface of the pie crust with the egg wash and sprinkle with sanding sugar. Cover the edges with a pie shield or a strip of foil to keep them from over browning during the first 25 minutes."));
    cookingSteps.add(CookingStep(
        id: 8,
        instruction:
            "Bake at 400°F (204°C) for 25 minutes. Carefully remove the pie shield, turn the oven down to 375° and continue to bake for an additional 30-35 minutes or until the top is golden brown and the juices are bubbly. Cool at room temperature for at least 3 hours."));

    ingredients
        .add(Ingredient(amount: "2 (9'')", unit: "", ingredient: "Pie Crusts"));
    ingredients.add(Ingredient(
        amount: "7", unit: "", ingredient: "large Granny Smith apples"));
    ingredients.add(
        Ingredient(amount: "1/2", unit: "Cup", ingredient: "granulated sugar"));
    ingredients.add(Ingredient(
        amount: "1/2", unit: "Cup", ingredient: "light brown sugar"));
    ingredients.add(Ingredient(
        amount: "2", unit: "tablespoons", ingredient: "all-purpose flour"));
    ingredients.add(Ingredient(
        amount: "1", unit: "teaspoon", ingredient: "ground cinnamon"));
    ingredients.add(Ingredient(
        amount: "1/8", unit: "teaspoon", ingredient: "ground nutmeg"));
    ingredients.add(
        Ingredient(amount: "1", unit: "tablespoon", ingredient: "lemon juice"));
    ingredients.add(Ingredient(amount: "1", unit: "", ingredient: "large egg"));
    ingredients.add(Ingredient(
        amount: "2", unit: "tablespoons", ingredient: "sanding sugar"));

    return EntireRecipe(
        recipe: recipe, cookingSteps: cookingSteps, ingredients: ingredients);
  }

  // TODO: Mooshed in #2, Add Recipe
  addRecipe(EntireRecipe entireRecipe) {}
}
