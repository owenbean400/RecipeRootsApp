import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/view/widget/header_plain.dart';
import 'package:recipe_roots/view/window/people/people_add.dart';
import 'package:recipe_roots/view/window/people/widgets/people_text_field.dart';

class UserAddView extends StatefulWidget {
  final ValueSetter<Person> addUser;

  const UserAddView({super.key, required this.addUser});

  @override
  UserAddViewState createState() => UserAddViewState();
}

class UserAddViewState extends State<UserAddView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  void addUser() {
    Person user = Person(
        firstName: _firstNameController.text,
        middleName: _middleNameController.text,
        lastName: _lastNameController.text);

    widget.addUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderPlain(title: "Yourself"),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
            child: Column(children: [
              PeopleTextField(
                  labelText: "First Name",
                  textFieldController: _firstNameController),
              PeopleTextField(
                  labelText: "Middle Name",
                  textFieldController: _middleNameController),
              PeopleTextField(
                  labelText: "Last Name",
                  textFieldController: _lastNameController),
              ElevatedActionButton(
                  action: addUser, buttonText: "Save your Information")
            ]),
          ),
        ))
      ],
    );
  }
}
