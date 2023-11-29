import 'package:recipe_roots/domain/person.dart';

class Recipe {
  int? id;
  String title;
  List<Person> people;
  String desc;
  String? imagePlace;

  Recipe(
      {required this.title,
      required this.people,
      required this.desc,
      this.imagePlace,
      this.id});

  factory Recipe.fromSQL(Map<String, Object?> sqlMap) {
    return Recipe(
        id: sqlMap["id"] as int,
        title: sqlMap["name"] as String,
        desc: sqlMap["description"] as String,
        people: []);
  }
}
