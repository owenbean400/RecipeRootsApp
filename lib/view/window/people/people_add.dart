import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/window/people/widgets/people_field.dart';
import 'package:recipe_roots/view/window/people/widgets/people_text_field.dart';

class PeopleAdd extends StatefulWidget {
  final Function setPeopleNavViewFunction;
  final int? id;

  const PeopleAdd({super.key, required this.setPeopleNavViewFunction, this.id});

  @override
  PeopleAddState createState() => PeopleAddState();
}

class PeopleAddState extends State<PeopleAdd> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _familyRelationController =
      TextEditingController();
  bool editingMode = false;

  editPersonMode() {
    setState(() {
      editingMode = true;
    });
  }

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

  updatePerson() {
    FamilyRelation familyRelation = FamilyRelation(
        id: widget.id,
        person: Person(
            firstName: _firstNameController.text,
            middleName: _middleNameController.text,
            lastName: _lastNameController.text),
        familyRelation: _familyRelationController.text);

    PersonService().updateFamilyRelation(familyRelation);
    widget.setPeopleNavViewFunction();
  }

  deletePerson() {
    PersonService().deleteFamilyRelationAndPersonFromID(widget.id!);
    widget.setPeopleNavViewFunction();
  }

  loadInFamilyRelation(int id) {
    FamilyRelation familyRelation = PersonService().getFamilyRelationByID(id);

    _firstNameController.text = familyRelation.person.firstName;
    _middleNameController.text = familyRelation.person.middleName;
    _lastNameController.text = familyRelation.person.lastName;
    _familyRelationController.text = familyRelation.familyRelation;
  }

  List<PeopleText> loadInFamilyRelationText(int id) {
    FamilyRelation familyRelation = PersonService().getFamilyRelationByID(id);
    List<PeopleText> familyInformation = [];

    familyInformation.add(PeopleText(
        labelText: "First Name", text: familyRelation.person.firstName));
    familyInformation.add(PeopleText(
        labelText: "Middle Name", text: familyRelation.person.middleName));
    familyInformation.add(PeopleText(
        labelText: "Last Name", text: familyRelation.person.lastName));
    familyInformation.add(PeopleText(
        labelText: "Family Relation", text: familyRelation.familyRelation));

    return familyInformation;
  }

  cancelNewPerson() {
    widget.setPeopleNavViewFunction();
  }

  @override
  Widget build(BuildContext context) {
    List<ElevatedActionButton> buttonActions = [];
    List<Widget> familyInformation = [];

    if (widget.id == null) {
      buttonActions.add(
          ElevatedActionButton(action: addNewPerson, buttonText: "Add Person"));
      buttonActions.add(
          ElevatedActionButton(action: cancelNewPerson, buttonText: "Cancel"));

      familyInformation.add(PeopleTextField(
          textFieldController: _firstNameController, labelText: "First Name"));
      familyInformation.add(PeopleTextField(
          textFieldController: _middleNameController,
          labelText: "Middle Name"));
      familyInformation.add(PeopleTextField(
          textFieldController: _lastNameController, labelText: "Last Name"));
      familyInformation.add(PeopleTextField(
          textFieldController: _familyRelationController,
          labelText: "Family Relation"));
    } else if (!editingMode) {
      buttonActions.add(ElevatedActionButton(
          action: editPersonMode, buttonText: "Edit Person"));
      buttonActions.add(
          ElevatedActionButton(action: deletePerson, buttonText: "Delete"));
      buttonActions.add(
          ElevatedActionButton(action: cancelNewPerson, buttonText: "Cancel"));

      familyInformation = loadInFamilyRelationText(widget.id!);
    } else {
      buttonActions.add(
          ElevatedActionButton(action: addNewPerson, buttonText: "Update"));
      buttonActions.add(
          ElevatedActionButton(action: cancelNewPerson, buttonText: "Cancel"));

      loadInFamilyRelation(widget.id!);

      familyInformation.add(PeopleTextField(
          textFieldController: _firstNameController, labelText: "First Name"));
      familyInformation.add(PeopleTextField(
          textFieldController: _middleNameController,
          labelText: "Middle Name"));
      familyInformation.add(PeopleTextField(
          textFieldController: _lastNameController, labelText: "Last Name"));
      familyInformation.add(PeopleTextField(
          textFieldController: _familyRelationController,
          labelText: "Family Relation"));
    }

    return Container(
        padding: (Platform.isIOS)
            ? const EdgeInsets.fromLTRB(16, 40, 16, 16)
            : const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...familyInformation,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: buttonActions,
              )
            ],
          ),
        ));
  }
}

class ElevatedActionButton extends StatelessWidget {
  final Function action;
  final String buttonText;

  const ElevatedActionButton(
      {super.key, required this.action, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        action();
      },
      style: Theme.of(context).elevatedButtonTheme.style,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.bodyMedium,
          )),
    );
  }
}
