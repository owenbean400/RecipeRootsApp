import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/window/people/widgets/family_relation_list.dart';

class PeopleView extends StatefulWidget {
  const PeopleView({super.key});

  @override
  PeopleViewState createState() => PeopleViewState();
}

class PeopleViewState extends State<PeopleView> {
  Future<List<FamilyRelation>> familyRelations = PersonService()
      .getAllFamilyRelation(Person(
          id: 1, firstName: "Owen", middleName: "Guaraldo", lastName: "Bean"));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder<List<FamilyRelation>>(
            future: familyRelations,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<FamilyRelationTile> familyRelationsList = [];

                for (FamilyRelation familyRelation in snapshot.data!) {
                  familyRelationsList.add(FamilyRelationTile(
                      name: familyRelation.person.firstName,
                      relationship: familyRelation.familyRelation));
                }

                return Column(
                  children: familyRelationsList,
                );
              } else if (snapshot.hasError) {
                return const Text("Error getting family relation");
              } else {
                return const Text("Waiting for family relation to load");
              }
            }));
  }
}
