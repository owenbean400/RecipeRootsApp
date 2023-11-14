import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:sqflite/sqflite.dart';

class RecipeRootsDAO {
  final String databaseName = "recipeRoots.db";

  Future<Database> getDatabase() async {
    Database database = await openDatabase(databaseName, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Recipe (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, description TEXT, image TEXT)");
      await db.execute(
          "CREATE TABLE Cooking_Steps (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INT NOT NULL, step_order INT, instruction TEXT, FOREIGN KEY (recipe_id) REFERENCES Recipe(id), FOREIGN KEY (step_order) REFERENCES Cooking_Steps(id))");
      await db.execute(
          "CREATE TABLE Ingredient (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INT NOT NULL, amount TEXT, unit TEXT, ingredient TEXT, prep_method TEXT, FOREIGN KEY (recipe_id) REFERENCES Recipe(id))");
      await db.execute(
          "CREATE TABLE Person (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name TEXT, middle_name TEXT, last_name TEXT)");
      await db.execute(
          "CREATE TABLE Family_Relation (id INTEGER PRIMARY KEY AUTOINCREMENT, from_person_id INTEGER, to_person_id INTEGER, relationship TEXT, FOREIGN KEY (from_person_id) REFERENCES Person (id) ON DELETE CASCADE, FOREIGN KEY (to_person_id) REFERENCES Person (id) ON DELETE CASCADE)");
      await db.execute(
          "CREATE TABLE Recipe_To_Person (id INTEGER PRIMARY KEY AUTOINCREMENT, recipe_id INTEGER, person_id INTEGER, FOREIGN KEY (recipe_id) REFERENCES Recipe (id), FOREIGN KEY (person_id) REFERENCES Person (id) ON DELETE CASCADE)");
      await db.execute(
          "CREATE TABLE FAMILY_TREE (id INTEGER PRIMARY KEY AUTOINCREMENT, lparent_id INTEGER, rparent_id INTEGER, person_id INTEGER, FOREIGN KEY (lparent_id) REFERENCES Person(id) ON DELETE SET NULL, FOREIGN KEY (rparent_id) REFERENCES Person(id) ON DELETE SET NULL, FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE)");
      await db.execute(
          "CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, person_id INTEGER, FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE)");
    });

    return database;
  }

  Future<void> setUser(Person person) async {
    Database db = await getDatabase();

    int id = await addPerson(person);

    person.id = id;

    await db.rawInsert("INSERT INTO User (person_id) VALUES (?)", [person.id]);
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

  Future<int> updatePerson(Person person) async {
    Database db = await getDatabase();

    return await db.rawUpdate(
        "UPDATE Person SET first_name = ?, middle_name = ?, last_name = ? WHERE id = ?",
        [person.firstName, person.middleName, person.lastName, person.id]);
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

  Future<int> deletePerson(Person person) async {
    Database db = await getDatabase();

    return await db.rawDelete("DELETE FROM Person WHERE id = ?", [person.id]);
  }

  Future<int> deleteFamilyRelation(FamilyRelation familyRelation) async {
    Database db = await getDatabase();

    return await db.rawDelete(
        "DELETE FROM Family_Relation WHERE id = ?", [familyRelation.id]);
  }
}
