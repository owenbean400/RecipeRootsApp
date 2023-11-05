import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';

class PersonService {
  Person getPerson(id) {
    // TODO: Replace with database query
    return Person(firstName: "Owen", middleName: "Guaraldo", lastName: "Bean");
  }

  /// Gets the family relation of the to person
  FamilyRelation getFamilyRelation(Person person) {
    // TODO: Replace with database query
    return FamilyRelation(person: person, familyRelation: "Family Relation");
  }

  /// Gets all of the family relation of the from person
  Future<List<FamilyRelation>> getAllFamilyRelation(Person person) async {
    List<FamilyRelation> familyRelations = [];

    // TODO: Replace with database query
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
        .add(FamilyRelation(person: person1, familyRelation: "Sister"));
    familyRelations.add(FamilyRelation(person: person2, familyRelation: "Mom"));
    familyRelations.add(FamilyRelation(person: person3, familyRelation: "Dad"));
    familyRelations.add(FamilyRelation(person: person4, familyRelation: "Dad"));
    familyRelations.add(FamilyRelation(person: person5, familyRelation: "Dad"));
    familyRelations.add(FamilyRelation(person: person6, familyRelation: "Dad"));
    familyRelations.add(FamilyRelation(person: person7, familyRelation: "Dad"));
    familyRelations.add(FamilyRelation(person: person8, familyRelation: "Dad"));
    familyRelations.add(FamilyRelation(person: person9, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(person: person10, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(person: person11, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(person: person12, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(person: person13, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(person: person14, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(person: person15, familyRelation: "Dad"));
    familyRelations
        .add(FamilyRelation(person: person16, familyRelation: "Dad"));

    return familyRelations;
  }
}
