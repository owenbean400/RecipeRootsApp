import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/family_relation.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/helper/the_person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/widget/header_backspace.dart';
import 'package:recipe_roots/view/window/people/widgets/people_field.dart';
import 'package:recipe_roots/view/window/people/widgets/people_text_field.dart';

class PeopleAdd extends StatefulWidget {
  final Function setPeopleNavViewFunction;
  final FamilyRelation? familyRelation;

  const PeopleAdd(
      {super.key, required this.setPeopleNavViewFunction, this.familyRelation});

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

    PersonService()
        .addFamilyRelation(ThePersonSingleton().user!, familyRelation)
        .then((value) => {widget.setPeopleNavViewFunction()});
  }

  updatePerson() {
    FamilyRelation familyRelation = FamilyRelation(
        id: widget.familyRelation!.id,
        person: Person(
            id: widget.familyRelation!.person.id,
            firstName: _firstNameController.text,
            middleName: _middleNameController.text,
            lastName: _lastNameController.text),
        familyRelation: _familyRelationController.text);

    PersonService()
        .updateFamilyRelation(familyRelation)
        .then((value) => {widget.setPeopleNavViewFunction()});
  }

  deletePerson() {
    PersonService().deleteFamilyRelationAndPersonFromID(widget.familyRelation!);
    widget.setPeopleNavViewFunction();
  }

  loadInFamilyRelation() {
    _firstNameController.text = widget.familyRelation?.person.firstName ?? "";
    _middleNameController.text = widget.familyRelation?.person.middleName ?? "";
    _lastNameController.text = widget.familyRelation?.person.lastName ?? "";
    _familyRelationController.text =
        widget.familyRelation?.familyRelation ?? "";
  }

  List<PeopleText> loadInFamilyRelationText() {
    List<PeopleText> familyInformation = [];

    familyInformation.add(PeopleText(
        labelText: "First Name",
        text: widget.familyRelation?.person.firstName ?? ""));
    familyInformation.add(PeopleText(
        labelText: "Middle Name",
        text: widget.familyRelation?.person.middleName ?? ""));
    familyInformation.add(PeopleText(
        labelText: "Last Name",
        text: widget.familyRelation?.person.lastName ?? ""));
    familyInformation.add(PeopleText(
        labelText: "Family Relation",
        text: widget.familyRelation?.familyRelation ?? ""));

    return familyInformation;
  }

  cancelPerson() {
    widget.setPeopleNavViewFunction();
  }

  @override
  Widget build(BuildContext context) {
    List<ElevatedActionButton> buttonActions = [];
    List<Widget> familyInformation = [];

    if (widget.familyRelation == null) {
      buttonActions.add(
          ElevatedActionButton(action: addNewPerson, buttonText: "Add Person"));

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

      // Can't delete yourself
      if (ThePersonSingleton().user!.id != widget.familyRelation!.person.id) {
        buttonActions.add(
            ElevatedActionButton(action: deletePerson, buttonText: "Delete"));
      }

      familyInformation = loadInFamilyRelationText();
    } else {
      buttonActions.add(
          ElevatedActionButton(action: updatePerson, buttonText: "Update"));

      loadInFamilyRelation();

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

    return Column(children: [
      HeaderBackspace(
          backSpaceAction: cancelPerson,
          title: (widget.familyRelation == null)
              ? "Add Person"
              : (!editingMode)
                  ? "View Person"
                  : "Edit Person"),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
              )))
    ]);
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
