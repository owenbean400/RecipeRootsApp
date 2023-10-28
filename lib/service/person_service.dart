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
  List<FamilyRelation> getAllFamilyRelation(Person person) {
    List<FamilyRelation> familyRelations = [];

    // TODO: Replace with database query
    Person person1 =
        Person(firstName: "Olivea", middleName: "Grace", lastName: "Bean");
    Person person2 =
        Person(firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person person3 =
        Person(firstName: "David", middleName: "Lee", lastName: "Bean");

    familyRelations
        .add(FamilyRelation(person: person1, familyRelation: "Sister"));
    familyRelations.add(FamilyRelation(person: person2, familyRelation: "Mom"));
    familyRelations.add(FamilyRelation(person: person3, familyRelation: "Dad"));

    return familyRelations;
  }
}
