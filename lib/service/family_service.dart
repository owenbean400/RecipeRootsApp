import 'package:recipe_roots/domain/family_tree.dart';
import 'package:recipe_roots/domain/person.dart';

class FamilyService {
  // TODO: #30 Get Family Tree of all
  Future<List<FamilyTree>> getFamilyTree() async {
    Person owen = Person(
        id: 1, firstName: "Owen", middleName: "Guaraldo", lastName: "Bean");
    Person david =
        Person(id: 2, firstName: "David", middleName: "Lee", lastName: "Bean");
    Person ray =
        Person(id: 3, firstName: "Raymond", middleName: "", lastName: "Bean");
    Person julia =
        Person(id: 4, firstName: "Julia", middleName: "", lastName: "Bean");
    Person sarah =
        Person(id: 5, firstName: "Sarah", middleName: "", lastName: "Beiling");
    Person kristine = Person(
        id: 6, firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person rosalie =
        Person(id: 7, firstName: "Rosalie", middleName: "", lastName: "Bean");
    Person bruce =
        Person(id: 8, firstName: "Bruce", middleName: "", lastName: "Bean");
    Person elalane =
        Person(id: 9, firstName: "Elaina", middleName: "", lastName: "Bean");

    FamilyTree owenT = FamilyTree(id: 1, child: owen);
    FamilyTree sarahT = FamilyTree(id: 8, child: sarah);
    FamilyTree davidT = FamilyTree(id: 2, child: david);
    FamilyTree kristineT = FamilyTree(id: 3, child: kristine);
    FamilyTree juliaT = FamilyTree(id: 9, child: julia);
    FamilyTree rayT = FamilyTree(id: 7, child: ray);
    FamilyTree rosalieT = FamilyTree(id: 4, child: rosalie);
    FamilyTree bruceT = FamilyTree(id: 5, child: bruce);
    FamilyTree elalaneT = FamilyTree(id: 6, child: elalane);
    owenT.parent1 = davidT;
    owenT.parent2 = kristineT;
    davidT.parent1 = bruceT;
    davidT.parent2 = rosalieT;
    rayT.parent1 = bruceT;
    rayT.parent2 = rosalieT;
    juliaT.parent1 = bruceT;
    juliaT.parent2 = rosalieT;
    sarahT.parent1 = juliaT;
    rosalieT.parent1 = elalaneT;

    return [
      owenT,
      davidT,
      kristineT,
      rayT,
      juliaT,
      sarahT,
      rosalieT,
      bruceT,
      elalaneT
    ];
  }

  // TODO: #37 Query family tree
  void updateFamilyTree(FamilyTree familyTree) async {}
}
