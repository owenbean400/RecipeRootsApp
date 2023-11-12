import 'dart:developer';

import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';

class PersonService {
  // TODO: #5 Person query
  Person getPerson(id) {
    return Person(firstName: "Owen", middleName: "Guaraldo", lastName: "Bean");
  }

  // TODO: #16 Query for a person
  FamilyRelation getFamilyRelationByID(int id) {
    Person person1 = Person(
        id: id, firstName: "Olivea", middleName: "Grace", lastName: "Bean");

    return FamilyRelation(person: person1, familyRelation: "Sister");
  }

  // TODO: #27, Edit family relation and person
  void updateFamilyRelation(FamilyRelation familyRelation) {
    log(familyRelation.person.firstName);
    log(familyRelation.person.middleName);
    log(familyRelation.person.lastName);
    log(familyRelation.familyRelation);
  }

  /// Gets the family relation of the to person
  FamilyRelation getFamilyRelationByPerson(Person person) {
    // TODO: Replace with database query
    return FamilyRelation(person: person, familyRelation: "Family Relation");
  }

  // TODO: #7 and #5, insert a person and family relation
  void addFamilyRelation(FamilyRelation familyRelation) {
    log(familyRelation.person.firstName);
    log(familyRelation.person.middleName);
    log(familyRelation.person.lastName);
    log(familyRelation.familyRelation);
  }

  // TODO: #36, delete person
  void deleteFamilyRelationAndPersonFromID(int id) {
    log("Deleted!");
  }

  Future<List<Person>> getAllPeople() async {
    Person owen = Person(
        id: 1, firstName: "Owen", middleName: "Guaraldo", lastName: "Bean");
    Person david =
        Person(id: 2, firstName: "David", middleName: "Lee", lastName: "Bean");
    Person ray =
        Person(id: 3, firstName: "Raymond", middleName: "", lastName: "Bean");
    Person julia =
        Person(id: 4, firstName: "Julia", middleName: "", lastName: "Bean");
    Person sarah =
        Person(id: 5, firstName: "Sarah", middleName: "", lastName: "Beiling");
    Person kristine = Person(
        id: 6, firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person rosalie =
        Person(id: 7, firstName: "Rosalie", middleName: "", lastName: "Bean");
    Person bruce =
        Person(id: 8, firstName: "Bruce", middleName: "", lastName: "Bean");
    Person elalane =
        Person(id: 9, firstName: "Elaina", middleName: "", lastName: "Bean");

    return [owen, david, ray, julia, sarah, kristine, rosalie, bruce, elalane];
  }

  // TODO: #28, Query all family relations
  Future<List<FamilyRelation>> getAllFamilyRelation(Person person) async {
    List<FamilyRelation> familyRelations = [];

    Person person1 =
        Person(firstName: "Olivea", middleName: "Grace", lastName: "Bean");
    Person person2 =
        Person(firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person person3 =
        Person(firstName: "David", middleName: "Lee", lastName: "Bean");
    Person person4 =
        Person(firstName: "Olivea", middleName: "Grace", lastName: "Bean");
    Person person5 =
        Person(firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person person6 =
        Person(firstName: "David", middleName: "Lee", lastName: "Bean");
    Person person7 =
        Person(firstName: "Olivea", middleName: "Grace", lastName: "Bean");
    Person person8 =
        Person(firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person person9 =
        Person(firstName: "David", middleName: "Lee", lastName: "Bean");
    Person person10 =
        Person(firstName: "Olivea", middleName: "Grace", lastName: "Bean");
    Person person11 =
        Person(firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person person12 =
        Person(firstName: "David", middleName: "Lee", lastName: "Bean");
    Person person13 =
        Person(firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person person14 =
        Person(firstName: "David", middleName: "Lee", lastName: "Bean");
    Person person15 =
        Person(firstName: "Olivea", middleName: "Grace", lastName: "Bean");
    Person person16 =
        Person(firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person person17 =
        Person(firstName: "David", middleName: "Lee", lastName: "Bean");

    familyRelations
        .add(FamilyRelation(id: 1, person: person1, familyRelation: "Sister"));
    familyRelations
        .add(FamilyRelation(id: 2, person: person2, familyRelation: "Mom"));
    familyRelations
        .add(FamilyRelation(id: 3, person: person3, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 4, person: person4, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 5, person: person5, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 6, person: person6, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 7, person: person7, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 8, person: person8, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 9, person: person9, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 10, person: person10, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 11, person: person11, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 12, person: person12, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 13, person: person13, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 14, person: person14, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 15, person: person15, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(id: 16, person: person16, familyRelation: "Dad"));

    return familyRelations;
  }
}
