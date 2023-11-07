import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/person.dart';

class PersonButton extends StatefulWidget {
  final List<Person> people;
  const PersonButton({super.key, required this.people});

  @override
  State<PersonButton> createState() => PersonButtonState();
}

class PersonButtonState extends State<PersonButton> {
  Person dropdownValue =
      Person(id: null, firstName: "", middleName: "", lastName: "");

  @override
  Widget build(BuildContext context) {
    if (dropdownValue.id == null) {
      dropdownValue = widget.people.first;
    }

    return DropdownButton<Person>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: TextStyle(color: Theme.of(context).primaryColorDark),
      dropdownColor: Theme.of(context).hintColor,
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: (Person? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.people.map<DropdownMenuItem<Person>>((Person value) {
        return DropdownMenuItem<Person>(
          value: value,
          child:
              Text("${value.firstName} ${value.middleName} ${value.lastName}"),
        );
      }).toList(),
    );
  }
}
