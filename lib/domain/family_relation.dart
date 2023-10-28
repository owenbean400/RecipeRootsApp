import 'package:recipe_roots/domain/person.dart';

class FamilyRelation {
  int? id;
  Person person;
  final String familyRelation;

  FamilyRelation({this.id, required this.person, required this.familyRelation});
}
