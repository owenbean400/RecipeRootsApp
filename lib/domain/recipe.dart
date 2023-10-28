import 'package:recipe_roots/domain/person.dart';

class Recipe {
  final String title;
  final Person person;
  final String? familyRelation;
  final String desc;
  final String? imagePlace;

  Recipe(
      {required this.title,
      required this.person,
      required this.desc,
      this.familyRelation,
      this.imagePlace});
}
