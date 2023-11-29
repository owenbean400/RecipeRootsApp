import 'package:recipe_roots/domain/person.dart';

class FamilyRelation {
  int? id;
  Person person;
  final String familyRelation;

  FamilyRelation({this.id, required this.person, required this.familyRelation});

  factory FamilyRelation.fromSQL(
      Map<String, Object?> sqlMap, Person queriedPerson) {
    return FamilyRelation(
        id: sqlMap["id"] as int,
        person: queriedPerson,
        familyRelation: sqlMap["relationship"] as String);
  }
}
