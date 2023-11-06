import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/window/people/widgets/people_text_field.dart';

class PeopleAdd extends StatefulWidget {
  final Function setPeopleNavViewFunction;

  const PeopleAdd({super.key, required this.setPeopleNavViewFunction});

  @override
  PeopleAddState createState() => PeopleAddState();
}

class PeopleAddState extends State<PeopleAdd> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _familyRelationController =
      TextEditingController();

  addNewPerson() {
    FamilyRelation familyRelation = FamilyRelation(
        person: Person(
            firstName: _firstNameController.text,
            middleName: _middleNameController.text,
            lastName: _lastNameController.text),
        familyRelation: _familyRelationController.text);

    PersonService().addFamilyRelation(familyRelation);
    widget.setPeopleNavViewFunction();
  }

  cancelNewPerson() {
    widget.setPeopleNavViewFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PeopleTextField(
                  textFieldController: _firstNameController,
                  labelText: "First Name"),
              PeopleTextField(
                  textFieldController: _middleNameController,
                  labelText: "Middle Name"),
              PeopleTextField(
                  textFieldController: _lastNameController,
                  labelText: "Last Name"),
              PeopleTextField(
                  textFieldController: _familyRelationController,
                  labelText: "Family Relation"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addNewPerson();
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text(
                          "Add Person",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addNewPerson();
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text(
                          "Cancel",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
