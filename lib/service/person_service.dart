import 'package:recipe_roots/dao/recipe_roots_dao.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/helper/the_person.dart';

class PersonService {
  Future<bool> userSetup() async {
    Person? person = await RecipeRootsDAO().getUser();

    ThePersonSingleton userSingleton = ThePersonSingleton();

    if (person != null) {
      userSingleton.user = person;
      return true;
    }

    return false;
  }

  Future<void> setUser(Person user) async {
    return await RecipeRootsDAO().setUser(user);
  }

  Future<List<Person>> getAllPeople() async {
    return await RecipeRootsDAO().getAllPeople();
  }

  Future<List<FamilyRelation>> getAllFamilyRelation(Person user) async {
    List<FamilyRelation> familyRelations = [];
    List<Person> people = await RecipeRootsDAO().getAllPeople();

    for (Person person in people) {
      familyRelations.add(
          await RecipeRootsDAO().getFamilyRelation(user, person) ??
              FamilyRelation(person: person, familyRelation: ""));
    }

    return familyRelations;
  }

  Future<void> updateFamilyRelation(FamilyRelation familyRelation) async {
    await RecipeRootsDAO().updatePerson(familyRelation.person);

    if (familyRelation.familyRelation == "") {
      await RecipeRootsDAO().deleteFamilyRelation(familyRelation);
    } else {
      int updatedRecords =
          await RecipeRootsDAO().updateFamilyRelation(familyRelation);
      if (updatedRecords == 0) {
        int familyId = await RecipeRootsDAO()
            .addFamilyRelation(ThePersonSingleton().user!, familyRelation);
        familyRelation.id = familyId;
      }
    }
  }

  /// TODO: Get family by person
  FamilyRelation getFamilyRelationByPerson(Person person) {
    return FamilyRelation(person: person, familyRelation: "Family Relation");
  }

  Future<void> addFamilyRelation(
      Person user, FamilyRelation familyRelation) async {
    familyRelation.person.id =
        await RecipeRootsDAO().addPerson(familyRelation.person);

    if (familyRelation.familyRelation != "") {
      await RecipeRootsDAO().addFamilyRelation(user, familyRelation);
    }
  }

  void deleteFamilyRelationAndPersonFromID(
      FamilyRelation familyRelation) async {
    await RecipeRootsDAO().deletePerson(familyRelation.person);
  }
}
