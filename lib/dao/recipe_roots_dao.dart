import 'package:recipe_roots/domain/cooking_step.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/ingredient.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/domain/recipe.dart';
import 'package:sqflite/sqflite.dart';

class RecipeRootsDAO {
  final String databaseName = "recipeRoots.db";

  Future<Database> getDatabase() async {
    Database database = await openDatabase(databaseName, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Recipe (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, description TEXT, image TEXT)");
      await db.execute(
          "CREATE TABLE Cooking_Steps (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INT NOT NULL, step_order INT, instruction TEXT, FOREIGN KEY (recipe_id) REFERENCES Recipe(id) ON DELETE CASCADE, FOREIGN KEY (step_order) REFERENCES Cooking_Steps(id))");
      await db.execute(
          "CREATE TABLE Ingredient (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INT NOT NULL, amount TEXT, unit TEXT, ingredient TEXT, prep_method TEXT, FOREIGN KEY (recipe_id) REFERENCES Recipe(id) ON DELETE CASCADE)");
      await db.execute(
          "CREATE TABLE Person (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name TEXT, middle_name TEXT, last_name TEXT)");
      await db.execute(
          "CREATE TABLE Family_Relation (id INTEGER PRIMARY KEY AUTOINCREMENT, from_person_id INTEGER, to_person_id INTEGER, relationship TEXT, FOREIGN KEY (from_person_id) REFERENCES Person (id) ON DELETE CASCADE, FOREIGN KEY (to_person_id) REFERENCES Person (id) ON DELETE CASCADE)");
      await db.execute(
          "CREATE TABLE Recipe_To_Person (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INTEGER, person_id INTEGER, FOREIGN KEY (recipe_id) REFERENCES Recipe (id) ON DELETE CASCADE, FOREIGN KEY (person_id) REFERENCES Person (id) ON DELETE CASCADE)");
      await db.execute(
          "CREATE TABLE Family_Tree (id INTEGER PRIMARY KEY AUTOINCREMENT, lparent_id INTEGER, rparent_id INTEGER, person_id INTEGER, FOREIGN KEY (lparent_id) REFERENCES Person(id) ON DELETE SET NULL, FOREIGN KEY (rparent_id) REFERENCES Person(id) ON DELETE SET NULL, FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE)");
      await db.execute(
          "CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, person_id INTEGER, FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE)");
    });

    return database;
  }

  List<Recipe> _sqlMapListToRecipes(List<Map<String, Object?>> recipeMaps) {
    List<Recipe> recipes = [];

    for (Map<String, Object?> recipeMap in recipeMaps) {
      recipes.add(Recipe.fromSQL(recipeMap));
    }

    return recipes;
  }

  Future<List<Recipe>> getRecipesAll() async {
    Database db = await getDatabase();

    List<Map<String, Object?>> recipeMaps = await db.rawQuery(
        "SELECT DISTINCT Recipe.id, Recipe.name, Recipe.description FROM Recipe");

    return _sqlMapListToRecipes(recipeMaps);
  }

  Future<List<Recipe>> getRecipesBySearchTitle(String title) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> recipeMaps = await db.rawQuery(
        "SELECT DISTINCT Recipe.id, Recipe.name, Recipe.description FROM Recipe WHERE Recipe.name LIKE '%' || ? || '%'",
        [title]);

    return _sqlMapListToRecipes(recipeMaps);
  }

  Future<List<Recipe>> getRecipesBySearchDescription(String description) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> recipeMaps = await db.rawQuery(
        "SELECT DISTINCT Recipe.id, Recipe.name, Recipe.description FROM Recipe WHERE Recipe.description LIKE '%' || ? || '%'",
        [description]);

    return _sqlMapListToRecipes(recipeMaps);
  }

  Future<List<Recipe>> getRecipesBySearchPeopleOneName(String name) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> recipeMaps = await db.rawQuery(
        "SELECT DISTINCT Recipe.id, Recipe.name, Recipe.description FROM Recipe WHERE Recipe.id IN (SELECT recipe_id AS id FROM Recipe_To_Person, Person WHERE ((Person.first_name LIKE '%' || ? || '%') OR (middle_name LIKE '%' || ? || '%') OR (last_name LIKE '%' || ? || '%')) AND Person.id = Recipe_To_Person.person_id)",
        [name, name, name]);

    return _sqlMapListToRecipes(recipeMaps);
  }

  Future<List<Recipe>> getRecipesBySearchPeopleTwoName(
      String firstName, String lastName) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> recipeMaps = await db.rawQuery(
        "SELECT DISTINCT Recipe.id, Recipe.name, Recipe.description FROM Recipe WHERE Recipe.id in (SELECT recipe_id AS id FROM Recipe_To_Person, Person WHERE Person.first_name LIKE '%' || ? || '%' AND last_name LIKE '%' || ? || '%' AND Person.id = Recipe_To_Person.person_id)",
        [firstName, lastName]);

    return _sqlMapListToRecipes(recipeMaps);
  }

  Future<List<Recipe>> getRecipesBySearchPeopleThreeName(
      String firstName, String lastName, String middleName) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> recipeMaps = await db.rawQuery(
        "SELECT DISTINCT Recipe.id, Recipe.name, Recipe.description FROM Recipe WHERE Recipe.id in (SELECT recipe_id FROM Recipe_To_Person, Person WHERE Person.first_name LIKE '%' || ? || '%' AND middle_name LIKE '%' || ? || '%' AND last_name LIKE '%' || ? || '%' AND Person.id = Recipe_To_Person.person_id)",
        [firstName, lastName, middleName]);

    return _sqlMapListToRecipes(recipeMaps);
  }

  Future<List<Recipe>> getRecipesBySearchFamilyRelation(
      String familyRelation) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> recipeMaps = await db.rawQuery(
        "SELECT DISTINCT Recipe.id, Recipe.name, Recipe.description FROM Recipe, Recipe_To_Person, Family_Relation, Person WHERE Family_Relation.from_person_id = 1 AND Family_Relation.relationship = ? AND Family_Relation.to_person_id = Recipe_To_Person.person_id AND Recipe.id = Recipe_To_Person.recipe_id",
        [familyRelation]);

    return _sqlMapListToRecipes(recipeMaps);
  }

  Future<List<Recipe>> getRecipesBySearchIngredient(String ingredient) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> recipeMaps = await db.rawQuery(
        "SELECT DISTINCT r.id, r.name, r.description FROM Recipe as r LEFT JOIN Ingredient as i ON r.id = i.recipe_id WHERE i.ingredient LIKE '%' || ? || '%'",
        [ingredient]);

    return _sqlMapListToRecipes(recipeMaps);
  }

  Future<List<Person>> getAuthorOfRecipe(int recipeId) async {
    Database db = await getDatabase();
    List<Person> authors = [];

    List<Map<String, Object?>> sqlMaps = await db.rawQuery(
        "SELECT Person.id, Person.first_name, Person.middle_name, Person.last_name FROM Recipe, Person, Recipe_To_Person WHERE Recipe.id = ? AND Recipe.id = Recipe_To_Person.recipe_id AND Recipe_To_Person.person_id = Person.id",
        [recipeId]);

    for (Map<String, Object?> sqlMap in sqlMaps) {
      authors.add(Person.fromSQL(sqlMap));
    }

    return authors;
  }

  Future<Person?> getUser() async {
    Database db = await getDatabase();

    List<Map<String, Object?>> userMap = await db.rawQuery(
        "SELECT person_id as id, first_name, middle_name, last_name FROM User, Person WHERE User.person_id = Person.id");

    if (userMap.isEmpty) {
      return null;
    } else {
      return Person.fromSQL(userMap[0]);
    }
  }

  Future<FamilyRelation?> getFamilyRelation(
      Person fromPerson, Person toPerson) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> familyRelationFound = await db.rawQuery(
        "SELECT id, relationship FROM Family_Relation WHERE from_person_id = ? and to_person_id = ?",
        [fromPerson.id, toPerson.id]);

    if (familyRelationFound.isEmpty) {
      return null;
    } else {
      return FamilyRelation.fromSQL(familyRelationFound[0], toPerson);
    }
  }

  Future<List<Person>> getAllPeople() async {
    List<Person> people = [];

    Database db = await getDatabase();

    List<Map<String, Object?>> peopleFound = await db
        .rawQuery("SELECT id, first_name, middle_name, last_name FROM Person");

    for (Map<String, Object?> mapPeople in peopleFound) {
      people.add(Person.fromSQL(mapPeople));
    }

    return people;
  }

  Future<List<Ingredient>> getIngredientFromRecipe(int recipeId) async {
    List<Ingredient> ingredients = [];
    Database db = await getDatabase();

    List<Map<String, Object?>> sqlMaps = await db.rawQuery(
        "SELECT id, amount, unit, ingredient, prep_method FROM Ingredient WHERE recipe_id = ?",
        [recipeId]);

    for (Map<String, Object?> sqlMap in sqlMaps) {
      ingredients.add(Ingredient.fromSQL(sqlMap));
    }

    return ingredients;
  }

  Future<List<CookingStep>> getCookingSteps(int recipeId) async {
    List<CookingStep> cookingSteps = [];
    Database db = await getDatabase();

    List<Map<String, Object?>> sqlMaps = await db.rawQuery(
        "SELECT * FROM Cooking_Steps WHERE recipe_id = ? AND step_order = 'NULL'",
        [recipeId]);

    while (sqlMaps.length == 1) {
      cookingSteps.add(CookingStep.fromSQL(sqlMaps[0]));

      sqlMaps = await db.rawQuery(
          "SELECT * FROM Cooking_Steps WHERE recipe_id = ? AND step_order = ?",
          [recipeId, cookingSteps[cookingSteps.length - 1].id]);
    }

    return cookingSteps;
  }

  Future<int> addPerson(Person add) async {
    Database db = await getDatabase();

    int id = await db.rawInsert(
        "INSERT INTO Person(first_name, middle_name, last_name) VALUES(?, ?, ?)",
        [add.firstName, add.middleName, add.lastName]);

    return id;
  }

  Future<int> addFamilyRelation(
      Person fromPerson, FamilyRelation familyRelation) async {
    Database db = await getDatabase();

    return await db.rawInsert(
        "INSERT INTO Family_Relation (from_person_id, to_person_id, relationship) VALUES (?, ?, ?)",
        [
          fromPerson.id,
          familyRelation.person.id,
          familyRelation.familyRelation
        ]);
  }

  Future<int> addRecipe(Recipe recipe) async {
    Database db = await getDatabase();

    return await db.rawInsert(
        "INSERT INTO Recipe (name, description) VALUES (?, ?)",
        [recipe.title, recipe.desc]);
  }

  Future<void> addCookingSteps(
      List<CookingStep> cookingSteps, int recipeId) async {
    Database db = await getDatabase();
    int priorId = -1;

    for (CookingStep cookingStep in cookingSteps) {
      priorId = await db.rawInsert(
          "INSERT INTO Cooking_Steps (recipe_id, step_order, instruction) VALUES (?, ?, ?)",
          [
            recipeId,
            (priorId == -1) ? "NULL" : priorId,
            cookingStep.instruction
          ]);
    }
  }

  Future<void> addIngredients(Ingredient ingredient, int recipeId) async {
    Database db = await getDatabase();

    await db.rawInsert(
        "INSERT INTO Ingredient (recipe_id, amount, unit, ingredient, prep_method) VALUES (?, ?, ?, ?, ?)",
        [
          recipeId,
          ingredient.amount,
          ingredient.unit,
          ingredient.ingredient,
          ingredient.prepMethod ?? ""
        ]);
  }

  Future<void> addPersonToRecipe(int recipeId, Person person) async {
    Database db = await getDatabase();

    await db.rawInsert(
        "INSERT INTO Recipe_To_Person (recipe_id, person_id) VALUES (?, ?);",
        [recipeId, person.id]);
  }

  Future<int> updatePerson(Person person) async {
    Database db = await getDatabase();

    return await db.rawUpdate(
        "UPDATE Person SET first_name = ?, middle_name = ?, last_name = ? WHERE id = ?",
        [person.firstName, person.middleName, person.lastName, person.id]);
  }

  Future<void> setUser(Person person) async {
    Database db = await getDatabase();

    int id = await addPerson(person);

    person.id = id;

    await db.rawInsert("INSERT INTO User (person_id) VALUES (?)", [person.id]);
  }

  Future<int> updateFamilyRelation(FamilyRelation familyRelation) async {
    Database db = await getDatabase();

    return await db.rawUpdate(
        "UPDATE Family_Relation SET to_person_id = ?, relationship = ? WHERE Family_Relation.id = ?",
        [
          familyRelation.person.id,
          familyRelation.familyRelation,
          familyRelation.id
        ]);
  }

  Future<int> updateIngredientRecipeID(int newRecipeId, int oldRecipeId) async {
    Database db = await getDatabase();

    return await db.rawUpdate(
        "UPDATE Ingredient SET recipe_id = ? WHERE Ingredient.recipe_id = ?",
        [newRecipeId, oldRecipeId]);
  }

  Future<int> updateCookingRecipeID(int newRecipeId, int oldRecipeId) async {
    Database db = await getDatabase();

    return await db.rawUpdate(
        "UPDATE Cooking_Steps SET recipe_id = ? WHERE Cooking_Steps.recipe_id = ?",
        [newRecipeId, oldRecipeId]);
  }

  Future<int> updatePersonRecipeID(int newRecipeId, int oldRecipeId) async {
    Database db = await getDatabase();

    return await db.rawUpdate(
        "UPDATE Recipe_To_Person SET recipe_id = ? WHERE Recipe_To_Person.recipe_id = ?",
        [newRecipeId, oldRecipeId]);
  }

  Future<int> updateRecipe(Recipe recipe) async {
    Database db = await getDatabase();

    return await db.rawUpdate(
        "UPDATE Recipe SET name = ?, description = ?, image = ?, WHERE Recipe.id = ?",
        [recipe.title, recipe.desc, recipe.imagePlace, recipe.id]);
  }

  Future<int> deletePerson(Person person) async {
    Database db = await getDatabase();

    return await db.rawDelete("DELETE FROM Person WHERE id = ?", [person.id]);
  }

  Future<int> deleteFamilyRelation(FamilyRelation familyRelation) async {
    Database db = await getDatabase();

    return await db.rawDelete(
        "DELETE FROM Family_Relation WHERE id = ?", [familyRelation.id]);
  }

  Future<int> deleteRecipeIngredientsFromRecipeID(int recipeId) async {
    Database db = await getDatabase();

    return await db
        .rawDelete("DELETE FROM Ingredient WHERE recipe_id = ?", [recipeId]);
  }

  Future<int> deleteRecipeCookingStepsFromRecipeID(int recipeId) async {
    Database db = await getDatabase();

    return await db
        .rawDelete("DELETE FROM Cooking_Steps WHERE recipe_id = ?", [recipeId]);
  }

  Future<int> deletePersonFromRecipe(int recipeId) async {
    Database db = await getDatabase();

    return await db.rawDelete(
        "DELETE FROM Recipe_To_Person WHERE recipe_id = ?", [recipeId]);
  }

  Future<int> deleteRecipe(Recipe recipe) async {
    Database db = await getDatabase();

    return await db
        .rawDelete("DELETE FROM Recipe WHERE id = ?", [recipe.id ?? -1]);
  }
}
