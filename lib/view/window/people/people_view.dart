import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/window/people/widgets/family_relation_list.dart';

class PeopleView extends StatefulWidget {
  final Function setPeopleNavAddFunction;
  final ValueSetter<int> setEditPerson;

  const PeopleView(
      {super.key,
      required this.setPeopleNavAddFunction,
      required this.setEditPerson});

  @override
  PeopleViewState createState() => PeopleViewState();
}

class PeopleViewState extends State<PeopleView> {
  Future<List<FamilyRelation>> familyRelations = PersonService()
      .getAllFamilyRelation(Person(
          id: 1, firstName: "Owen", middleName: "Guaraldo", lastName: "Bean"));

  goToAddFamiltRelation() async {
    widget.setPeopleNavAddFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: (Platform.isIOS)
            ? const EdgeInsets.fromLTRB(0, 40, 0, 0)
            : const EdgeInsets.all(0),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
                child: FutureBuilder<List<FamilyRelation>>(
                    future: familyRelations,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<FamilyRelationTile> familyRelationsList = [];

                        for (FamilyRelation familyRelation in snapshot.data!) {
                          familyRelationsList.add(FamilyRelationTile(
                              id: familyRelation.id,
                              name: familyRelation.person.firstName,
                              relationship: familyRelation.familyRelation,
                              setEditView: widget.setEditPerson));
                        }

                        return Column(
                          children: familyRelationsList,
                        );
                      } else if (snapshot.hasError) {
                        return const Text("Error getting family relation");
                      } else {
                        return const Text(
                            "Waiting for family relation to load");
                      }
                    })),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(constraints.maxWidth - 84,
                      constraints.maxHeight - 64, 0, 0),
                  child: TextButton(
                      onPressed: () {
                        goToAddFamiltRelation();
                      },
                      child: Text("+",
                          style: Theme.of(context).textTheme.bodyMedium)));
            }),
          ],
        ));
  }
}
