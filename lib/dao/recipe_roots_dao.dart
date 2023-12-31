import 'dart:ui';

import 'package:recipe_roots/domain/child_to_parent.dart';
import 'package:recipe_roots/domain/cooking_step.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/ingredient.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/domain/recipe.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

class RecipeRootsDAO {
  final String databaseName = "recipeRoots.db";

  Future<Database> getDatabase() async {
    Database database = await openDatabase(databaseName, version: 6,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE Recipe (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL CHECK(name <> ''), description TEXT, image TEXT)");
        await db.execute(
            "CREATE TABLE Cooking_Steps (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INT NOT NULL, step_order INT, instruction TEXT CHECK(instruction <> ''), FOREIGN KEY (recipe_id) REFERENCES Recipe(id) ON DELETE CASCADE, FOREIGN KEY (step_order) REFERENCES Cooking_Steps(id))");
        await db.execute(
            "CREATE TABLE Ingredient (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INT NOT NULL, amount TEXT, unit TEXT, ingredient TEXT CHECK(ingredient <> ''), prep_method TEXT, FOREIGN KEY (recipe_id) REFERENCES Recipe(id) ON DELETE CASCADE)");
        await db.execute(
            "CREATE TABLE Person (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name TEXT, middle_name TEXT, last_name TEXT, CHECK (first_name <> '' OR middle_name <> '' OR last_name <> ''))");
        await db.execute(
            "CREATE TABLE Family_Relation (id INTEGER PRIMARY KEY AUTOINCREMENT, from_person_id INTEGER, to_person_id INTEGER, relationship TEXT, FOREIGN KEY (from_person_id) REFERENCES Person (id) ON DELETE CASCADE, FOREIGN KEY (to_person_id) REFERENCES Person (id) ON DELETE CASCADE)");
        await db.execute(
            "CREATE TABLE Recipe_To_Person (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INTEGER, person_id INTEGER, FOREIGN KEY (recipe_id) REFERENCES Recipe (id) ON DELETE CASCADE, FOREIGN KEY (person_id) REFERENCES Person (id) ON DELETE CASCADE)");
        await db.execute(
            "CREATE TABLE Child_To_Parent (id INTEGER PRIMARY KEY AUTOINCREMENT, child_id INTEGER, parent_id INTEGER, FOREIGN KEY (child_id) REFERENCES Person(id) ON DELETE CASCADE, FOREIGN KEY (parent_id) REFERENCES Person(id) ON DELETE CASCADE)");
        await db.execute(
            "CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, person_id INTEGER, FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE)");
        await db.execute(
            "CREATE TABLE Position (id INTEGER PRIMARY KEY AUTOINCREMENT, person_id INTEGER, x REAL, y REAL, FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE)");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 5) {
          var tableExists = Sqflite.firstIntValue(await db.rawQuery(
              "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='Position'")) ?? 0;
          if (tableExists == 0) {
            await db.execute(
                "CREATE TABLE Position (id INTEGER PRIMARY KEY AUTOINCREMENT, person_id INTEGER, x REAL, y REAL, FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE)");
          }        
        }
        if (oldVersion < 6) {
          await db.execute(
              "CREATE TABLE Recipe_new (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL CHECK(name <> ''), description TEXT, image TEXT)");
          await db.execute(
              "INSERT INTO Recipe_new (id, name, description, image) SELECT id, name, description, image FROM Recipe WHERE name <> ''");
          await db.execute(
              "DROP TABLE Recipe");
          await db.execute(
              "ALTER TABLE Recipe_new RENAME TO Recipe");

          await db.execute(
              "CREATE TABLE Person_new (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name TEXT, middle_name TEXT, last_name TEXT, CHECK (first_name <> '' OR middle_name <> '' OR last_name <> ''))");
          await db.execute(
              "INSERT INTO Person_new (id, first_name, middle_name, last_name) SELECT id, first_name, middle_name, last_name FROM Person WHERE first_name <> '' OR middle_name <> '' OR last_name <> ''");
          await db.execute(
              "DROP TABLE Person");
          await db.execute(
              "ALTER TABLE Person_new RENAME TO Person");

          await db.execute(
              "CREATE TABLE Cooking_Steps_new (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INT NOT NULL, step_order INT, instruction TEXT CHECK(instruction <> ''), FOREIGN KEY (recipe_id) REFERENCES Recipe(id) ON DELETE CASCADE, FOREIGN KEY (step_order) REFERENCES Cooking_Steps(id))");
          await db.execute(
              "INSERT INTO Cooking_Steps_new (id, recipe_id, step_order, instruction) SELECT id, recipe_id, step_order, instruction FROM Cooking_Steps WHERE instruction <> ''");
          await db.execute(
              "DROP TABLE Cooking_Steps");
          await db.execute(
              "ALTER TABLE Cooking_Steps_new RENAME TO Cooking_Steps");

          await db.execute(
              "CREATE TABLE Ingredient_new (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INT NOT NULL, amount TEXT, unit TEXT, ingredient TEXT CHECK(ingredient <> ''), prep_method TEXT, FOREIGN KEY (recipe_id) REFERENCES Recipe(id) ON DELETE CASCADE)");
          await db.execute(
              "INSERT INTO Ingredient_new (id, recipe_id, amount, unit, ingredient, prep_method) SELECT id, recipe_id, amount, unit, ingredient, prep_method FROM Ingredient WHERE ingredient <> ''");
          await db.execute(
              "DROP TABLE Ingredient");
          await db.execute(
              "ALTER TABLE Ingredient_new RENAME TO Ingredient");         
        }
      },
    );

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

  Future<List<Recipe>> getRecipesByPerson(int personId) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> recipeMaps = await db.rawQuery(
      "SELECT DISTINCT Recipe.id, Recipe.name, Recipe.description FROM Recipe WHERE Recipe.id in (SELECT recipe_id FROM Recipe_To_Person WHERE person_id = ?)",
      [personId]);

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

  Future<Person?> getPersonFromId(int personId) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> sqlMaps = await db.rawQuery(
        "SELECT id, first_name, middle_name, last_name FROM Person WHERE Person.id = ?",
        [personId]);

    if (sqlMaps.length == 1) {
      return Person.fromSQL(sqlMaps[0]);
    }
    return null;
  }

  Future<List<List<int>>> getAllChildToParent() async {
    List<List<int>> allChildToParent = [];
    Database db = await getDatabase();

    List<Map<String, Object?>> sqlMaps = await db.rawQuery(
        "SELECT DISTINCT Child_To_Parent.id as id, Child.id as child_id, Parent.id as parent_id FROM Child_To_Parent, Person as Child, Person as Parent WHERE Child_To_Parent.child_id = Child.id AND Child_To_Parent.parent_id = Parent.id");

    for (Map<String, Object?> sqlMap in sqlMaps) {
      allChildToParent.add([
        sqlMap["id"] as int,
        sqlMap["child_id"] as int,
        sqlMap["parent_id"] as int
      ]);
    }

    return allChildToParent;
  }

  Future<List<List<int>>> getChildrenToParentFromChildPersonIDs(
      int personId) async {
    List<List<int>> childParentIds = [];
    Database db = await getDatabase();

    List<Map<String, Object?>> sqlMaps = await db.rawQuery(
        "SELECT Child_To_Parent.id as id, Child.id as child_id, Parent.id as parent_id FROM Child_To_Parent, Person as Child, Person as Parent WHERE Child_To_Parent.child_id = Child.id AND Child_To_Parent.parent_id = Parent.id AND Child.id = ?",
        [personId]);

    for (Map<String, Object?> sqlMap in sqlMaps) {
      childParentIds.add([
        sqlMap["id"] as int,
        sqlMap["child_id"] as int,
        sqlMap["parent_id"] as int
      ]);
    }

    return childParentIds;
  }

  Future<List<List<int>>> getChildrenToParentFromParentPersonIDs(
      int personId) async {
    List<List<int>> childParentIds = [];
    Database db = await getDatabase();

    List<Map<String, Object?>> sqlMaps = await db.rawQuery(
        "SELECT Child_To_Parent.id as id, Child.id as child_id, Parent.id as parent_id FROM Child_To_Parent, Person as Child, Person as Parent WHERE Child_To_Parent.child_id = Child.id AND Child_To_Parent.parent_id = Parent.id AND parent.id = ?",
        [personId]);

    for (Map<String, Object?> sqlMap in sqlMaps) {
      childParentIds.add([
        sqlMap["id"] as int,
        sqlMap["child_id"] as int,
        sqlMap["parent_id"] as int
      ]);
    }

    return childParentIds;
  }

  Future<int> addPerson(Person add) async {
    Database db = await getDatabase();
    return await db.rawInsert(
        "INSERT INTO Person(first_name, middle_name, last_name) VALUES(?, ?, ?)",
        [add.firstName, add.middleName, add.lastName]);
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

  Future<int> addRecipe(Recipe recipe, [DatabaseExecutor? txn]) async {
    DatabaseExecutor db = txn ?? await getDatabase();
    return await db.rawInsert(
        "INSERT INTO Recipe (name, description) VALUES (?, ?)",
        [recipe.title, recipe.desc]);
  }

  Future<void> addCookingSteps(
      List<CookingStep> cookingSteps, int recipeId, [DatabaseExecutor? txn]) async {
    final db = txn ?? await getDatabase();
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

  Future<void> addIngredients(Ingredient ingredient, int recipeId, [DatabaseExecutor? txn]) async {
    final db = txn ?? await getDatabase();

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

  Future<void> addPersonToRecipe(int recipeId, Person person, [DatabaseExecutor? txn]) async {
    final db = txn ?? await getDatabase();

    await db.rawInsert(
        "INSERT INTO Recipe_To_Person (recipe_id, person_id) VALUES (?, ?);",
        [recipeId, person.id]);
  }

  Future<void> addChildToParent(ChildToParent childToParent) async {
    Database db = await getDatabase();

    List<Map> result = await db.query(
        'Child_To_Parent',
        where: 'child_id = ? AND parent_id = ?',
        whereArgs: [childToParent.parent.id, childToParent.child.id]
    );
    if (result.isEmpty) {
      await db.rawInsert(
          "INSERT INTO Child_To_Parent (child_id, parent_id) VALUEs (?, ?)",
          [childToParent.child.id, childToParent.parent.id]);
    }
  }

  Future<int> updatePerson(Person person) async {
    Database db = await getDatabase();

    return await db.rawUpdate(
        "UPDATE Person SET first_name = ?, middle_name = ?, last_name = ? WHERE id = ?",
        [person.firstName, person.middleName, person.lastName, person.id]);
  }

  Future<int> setPosition(int id, double x, double y) async {
    Database db = await getDatabase();

    return await db.rawInsert(
        "INSERT INTO Position (person_id, x, y) VALUES (?, ?, ?)",
        [id, x, y]);
  }

  Future<Offset> getPosition(int id) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> sqlMaps = await db.rawQuery(
      "SELECT x, y FROM Position WHERE person_id = ?",
      [id]);

    double x = 0.0;
    double y = 0.0;

    if (sqlMaps.isEmpty) {
      Random random = Random();
      x = random.nextDouble() * 300;
      y = random.nextDouble() * 300;
      setPosition(id, x, y);
    } else {
      var sqlMap = sqlMaps.first;
      x = sqlMap["x"] as double;
      y = sqlMap["y"] as double;
    }

    return Offset(x, y);
  }

  Future<int> updatePosition(int id, double x, double y) async {
    Database db = await getDatabase();

    return await db.rawUpdate(
        "UPDATE Position SET x = ?, y = ? WHERE person_id = ?",
        [x, y, id]);
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

  Future<int> updateRecipe(Recipe recipe, [DatabaseExecutor? txn]) async {
    final db = txn ?? await getDatabase();

    return await db.rawUpdate(
        "UPDATE Recipe SET name = ?, description = ?, image = ? WHERE Recipe.id = ?",
        [recipe.title, recipe.desc, recipe.imagePlace, recipe.id]);
  }

  Future<int> updateChildToPerson(ChildToParent childToParent) async {
    Database db = await getDatabase();

    List<Map> result1 = await db.query(
        'Child_To_Parent',
        where: 'child_id = ? AND parent_id = ?',
        whereArgs: [childToParent.parent.id, childToParent.child.id]
    );
    List<Map> result2 = await db.query(
        'Child_To_Parent',
        where: 'child_id = ? AND parent_id = ?',
        whereArgs: [childToParent.child.id, childToParent.parent.id]
    );
    if (result1.isEmpty && result2.isEmpty) {
      return await db.rawUpdate(
          "UPDATE Child_To_Parent SET child_id = ?, parent_id = ? WHERE id = ?",
          [childToParent.child.id, childToParent.parent.id, childToParent.id]);
    } else {
      return -1;
    }
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

  Future<int> deleteRecipeIngredientsFromRecipeID(int recipeId, [DatabaseExecutor? txn]) async {
    final db = txn ?? await getDatabase();

    return await db
        .rawDelete("DELETE FROM Ingredient WHERE recipe_id = ?", [recipeId]);
  }

  Future<int> deleteRecipeCookingStepsFromRecipeID(int recipeId, [DatabaseExecutor? txn]) async {
    final db = txn ?? await getDatabase();

    return await db
        .rawDelete("DELETE FROM Cooking_Steps WHERE recipe_id = ?", [recipeId]);
  }

  Future<int> deletePersonFromRecipe(int recipeId, [DatabaseExecutor? txn]) async {
    final db = txn ?? await getDatabase();

    return await db.rawDelete(
        "DELETE FROM Recipe_To_Person WHERE recipe_id = ?", [recipeId]);
  }

  Future<int> deleteRecipe(Recipe recipe) async {
    Database db = await getDatabase();

    return await db
        .rawDelete("DELETE FROM Recipe WHERE id = ?", [recipe.id ?? -1]);
  }

  Future<int> deleteChildToParent(ChildToParent childToParent) async {
    Database db = await getDatabase();

    return await db.rawDelete(
        "DELETE FROM Child_To_Parent WHERE id = ?", [childToParent.id ?? -1]);
  }

  Future<void> performRecipeAdd(EntireRecipe entireRecipe) async {
    Database db = await getDatabase();
    await db.transaction((txn) async {
      int recipeId = await RecipeRootsDAO().addRecipe(entireRecipe.recipe, txn);

      await addCookingSteps(entireRecipe.cookingSteps, recipeId, txn);

      for (Ingredient ingredient in entireRecipe.ingredients) {
        await addIngredients(ingredient, recipeId, txn);
      }

      for (Person person in entireRecipe.authors) {
        await addPersonToRecipe(recipeId, person, txn);
      }
    });
  }

  Future<void> performRecipeEdit(EntireRecipe entireRecipe, int id) async {
    Database db = await getDatabase();
    await db.transaction((txn) async {
      await deleteRecipeCookingStepsFromRecipeID(id, txn);
      await deleteRecipeIngredientsFromRecipeID(id, txn);
      await deletePersonFromRecipe(id, txn);

      await addCookingSteps(entireRecipe.cookingSteps, id, txn);

      for (Ingredient ingredient in entireRecipe.ingredients) {
        await addIngredients(ingredient, id, txn);
      }

      for (Person person in entireRecipe.authors) {
        await addPersonToRecipe(id, person, txn);
      }
      
      await updateRecipe(entireRecipe.recipe, txn);
    });
  }
}
