import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/child_to_parent.dart';
import 'package:recipe_roots/domain/person.dart';

class ChildToParentForm extends ChangeNotifier {
  int? childToParentId;
  Person? child;
  Person? parent;

  ChildToParentForm({this.childToParentId, this.child, this.parent});

  updateChild(Person person) {
    child = person;
    notifyListeners();
  }

  updateParent(Person person) {
    parent = person;
    notifyListeners();
  }

  ChildToParent getChildToParent() {
    if (child != null && parent != null) {
      return ChildToParent(id: childToParentId, child: child!, parent: parent!);
    }

    throw Error();
  }
}
