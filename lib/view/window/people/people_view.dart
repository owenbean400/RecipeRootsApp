import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/helper/the_person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/widget/header_add.dart';
import 'package:recipe_roots/view/window/people/widgets/family_relation_list.dart';
import 'package:recipe_roots/view/window/people/widgets/people_tile_header.dart';

class PeopleView extends StatefulWidget {
  final Function setPeopleNavAddFunction;
  final ValueSetter<FamilyRelation> setEditPerson;

  const PeopleView(
      {super.key,
      required this.setPeopleNavAddFunction,
      required this.setEditPerson});

  @override
  PeopleViewState createState() => PeopleViewState();
}

class PeopleViewState extends State<PeopleView> {
  Future<List<FamilyRelation>> familyRelations =
      PersonService().getAllFamilyRelation(ThePersonSingleton().user!);

  goToAddFamiltRelation() async {
    widget.setPeopleNavAddFunction();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FamilyRelation>>(
        future: familyRelations,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> familyRelationsList = [];

            familyRelationsList.add(const FamilyRelationTileHeader());

            for (int i = 0; i < snapshot.data!.length; i++) {
              familyRelationsList.add(FamilyRelationTile(
                  familyRelation: snapshot.data![i],
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
