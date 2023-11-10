import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/widget/header_add.dart';
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
    return FutureBuilder<List<FamilyRelation>>(
        future: familyRelations,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FamilyRelationTile> familyRelationsList = [];

            for (int i = 0; i < snapshot.data!.length; i++) {
              familyRelationsList.add(FamilyRelationTile(
                  id: snapshot.data![i].id,
                  name: snapshot.data![i].person.firstName,
                  relationship: snapshot.data![i].familyRelation,
                  setEditView: widget.setEditPerson,
                  isBottomBorder: i != snapshot.data!.length - 1));
            }

            return Column(
              children: [
                HeaderAdd(addAction: goToAddFamiltRelation, title: "People"),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: familyRelationsList,
                )))
              ],
            );
          }

          return HeaderAdd(addAction: goToAddFamiltRelation, title: "People");
        });
  }
}
