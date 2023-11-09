import 'package:recipe_roots/domain/family_tree.dart';
import 'package:recipe_roots/domain/person.dart';

class FamilyService {
  Future<List<FamilyTree>> getFamilyTree() async {
    // TODO: Replace hard code with actually database query
    Person owen =
        Person(firstName: "Owen", middleName: "Guaraldo", lastName: "Bean");
    Person david =
        Person(firstName: "David", middleName: "Lee", lastName: "Bean");
    Person ray = Person(firstName: "Raymond", middleName: "", lastName: "Bean");
    Person julia = Person(firstName: "Julia", middleName: "", lastName: "Bean");
    Person sarah =
        Person(firstName: "Sarah", middleName: "", lastName: "Beiling");
    Person kristine =
        Person(firstName: "Kristine", middleName: "", lastName: "Guaraldo");
    Person rosalie =
        Person(firstName: "Rosalie", middleName: "", lastName: "Bean");
    Person bruce = Person(firstName: "Bruce", middleName: "", lastName: "Bean");
    Person elalane =
        Person(firstName: "Elaina", middleName: "", lastName: "Bean");

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
}
