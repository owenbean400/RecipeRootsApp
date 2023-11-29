import 'package:recipe_roots/dao/recipe_roots_dao.dart';
import 'package:recipe_roots/domain/child_to_parent.dart';
import 'package:recipe_roots/domain/person.dart';

class FamilyService {
  Future<List<ChildToParent>> getFamilyTree(Person user) async {
    Set<int> searchedPersonIds = {};
    List<ChildToParent> childToParentList = [];
    Map<int, Person> personMap = {};

    await getFamilyTreeRecursion(
        user, searchedPersonIds, childToParentList, personMap);

    return childToParentList;
  }

  Future<void> getFamilyTreeRecursion(Person user, Set<int> searchedPersonIds,
      List<ChildToParent> childToParentList, Map<int, Person> personMap) async {
    List<List<int>> children =
        await RecipeRootsDAO().getChildrenToParentFromChildPersonIDs(user.id!);
    List<List<int>> parent =
        await RecipeRootsDAO().getChildrenToParentFromParentPersonIDs(user.id!);

    searchedPersonIds.add(user.id!);

    for (List<int> childInfo in children) {
      Person child;
      Person parent;

      if (personMap.containsKey(childInfo[1])) {
        child = personMap[childInfo[1]]!;
      } else {
        child = await RecipeRootsDAO().getPersonFromId(childInfo[1]) ??
            Person(
                id: childInfo[1], firstName: "", middleName: "", lastName: "");
        personMap[childInfo[1]] = child;
      }

      if (personMap.containsKey(childInfo[2])) {
        parent = personMap[childInfo[2]]!;
      } else {
        parent = await RecipeRootsDAO().getPersonFromId(childInfo[2]) ??
            Person(
                id: childInfo[2], firstName: "", middleName: "", lastName: "");
        personMap[childInfo[2]] = parent;
      }

      ChildToParent childToParent =
          ChildToParent(id: childInfo[0], child: child, parent: parent);

      if (!childToParentList.contains(childToParent)) {
        childToParentList.add(childToParent);
      }

      if (!searchedPersonIds.contains(childInfo[2])) {
        await getFamilyTreeRecursion(
            parent, searchedPersonIds, childToParentList, personMap);
      }
      if (!searchedPersonIds.contains(childInfo[1])) {
        await getFamilyTreeRecursion(
            child, searchedPersonIds, childToParentList, personMap);
      }
    }

    for (List<int> parentInfo in parent) {
      Person child;
      Person parent;

      if (personMap.containsKey(parentInfo[1])) {
        child = personMap[parentInfo[1]]!;
      } else {
        child = await RecipeRootsDAO().getPersonFromId(parentInfo[1]) ??
            Person(
                id: parentInfo[1], firstName: "", middleName: "", lastName: "");
        personMap[parentInfo[1]] = child;
      }

      if (personMap.containsKey(parentInfo[2])) {
        parent = personMap[parentInfo[2]]!;
      } else {
        parent = await RecipeRootsDAO().getPersonFromId(parentInfo[2]) ??
            Person(
                id: parentInfo[2], firstName: "", middleName: "", lastName: "");
        personMap[parentInfo[2]] = parent;
      }

      ChildToParent childToParent =
          ChildToParent(id: parentInfo[0], child: child, parent: parent);

      if (!childToParentList.contains(childToParent)) {
        childToParentList.add(childToParent);
      }

      if (!searchedPersonIds.contains(parentInfo[1])) {
        getFamilyTreeRecursion(
            child, searchedPersonIds, childToParentList, personMap);
      }
      if (!searchedPersonIds.contains(parentInfo[2])) {
        getFamilyTreeRecursion(
            parent, searchedPersonIds, childToParentList, personMap);
      }
    }
  }

  Future<List<ChildToParent>> getAllChildToParent() async {
    List<ChildToParent> childToParentList = [];
    Map<int, Person> personMap = {};

    List<List<int>> allChildToParent =
        await RecipeRootsDAO().getAllChildToParent();

    for (List<int> childToParentConnection in allChildToParent) {
      Person child;
      Person parent;

      if (personMap.containsKey(childToParentConnection[1])) {
        child = personMap[childToParentConnection[1]]!;
      } else {
        child = await RecipeRootsDAO()
                .getPersonFromId(childToParentConnection[1]) ??
            Person(
                id: childToParentConnection[1],
                firstName: "",
                middleName: "",
                lastName: "");
        personMap[childToParentConnection[1]] = child;
      }

      if (personMap.containsKey(childToParentConnection[2])) {
        parent = personMap[childToParentConnection[2]]!;
      } else {
        parent = await RecipeRootsDAO()
                .getPersonFromId(childToParentConnection[2]) ??
            Person(
                id: childToParentConnection[2],
                firstName: "",
                middleName: "",
                lastName: "");
        personMap[childToParentConnection[2]] = parent;
      }

      ChildToParent childToParent = ChildToParent(
          id: childToParentConnection[0], child: child, parent: parent);

      childToParentList.add(childToParent);
    }

    return childToParentList;
  }

  Future<void> updateChildToParent(ChildToParent childToParent) async {
    if (childToParent.id == null) {
      await RecipeRootsDAO().addChildToParent(childToParent);
    } else {
      await RecipeRootsDAO().updateChildToPerson(childToParent);
    }
  }

  Future<void> deleteChildToParent(ChildToParent childToParent) async {
    await RecipeRootsDAO().deleteChildToParent(childToParent);
  }
}
