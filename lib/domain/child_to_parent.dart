import 'package:recipe_roots/domain/person.dart';

class ChildToParent {
  int? id;

  Person child;
  Person parent;

  ChildToParent({this.id, required this.child, required this.parent});

  @override
  bool operator ==(Object other) =>
      other is ChildToParent &&
      other.runtimeType == runtimeType &&
      other.id == id;

  @override
  int get hashCode => id.hashCode;
}
