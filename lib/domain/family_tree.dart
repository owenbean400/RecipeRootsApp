import 'package:recipe_roots/domain/person.dart';

class FamilyTree {
  int? id;
  FamilyTree? parent1;
  FamilyTree? parent2;
  Person? child;

  FamilyTree({this.id, this.parent1, this.parent2, this.child});
}
