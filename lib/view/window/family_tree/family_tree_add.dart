import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/family_tree.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/widget/header_backspace.dart';
import 'package:recipe_roots/view/window/people/people_add.dart';
import 'package:recipe_roots/view/window/recipe/widgets/person_drop_menu.dart';

class FamilyTreeAdd extends StatefulWidget {
  final FamilyTree? familyTree;
  final Function goToViewFamilyTree;

  const FamilyTreeAdd(
      {super.key, this.familyTree, required this.goToViewFamilyTree});

  @override
  FamilyTreeAddState createState() => FamilyTreeAddState();
}

class FamilyTreeAddState extends State<FamilyTreeAdd> {
  final Future<List<Person>> people = PersonService().getAllPeople();

  void saveFamilyTree() {}

  @override
  Widget build(BuildContext context) {
    Person? parent1 = widget.familyTree?.parent1?.child;
    Person? parent2 = widget.familyTree?.parent2?.child;

    return FutureBuilder<List<Person>>(
        future: people,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderBackspace(
                    backSpaceAction: widget.goToViewFamilyTree,
                    title: "Family Tree",
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Person:",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          PersonButton(
                              people: snapshot.data!,
                              personChosen: widget.familyTree?.child),
                          Text(
                            "Parent 1:",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          PersonButton(
                              people: snapshot.data!, personChosen: parent1),
                          Text(
                            "Parent 2:",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          PersonButton(
                              people: snapshot.data!, personChosen: parent2),
                          ElevatedActionButton(
                              action: saveFamilyTree,
                              buttonText: "Save Family Tree")
                        ],
                      ))
                ]);
          }
          return HeaderBackspace(
              backSpaceAction: widget.goToViewFamilyTree, title: "Family Tree");
        });
  }
}
