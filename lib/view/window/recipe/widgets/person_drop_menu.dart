import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/person.dart';

class PersonButton extends StatefulWidget {
  final List<Person> people;
  final Person? personChosen;
  final ValueSetter<Person>? setPerson;
  const PersonButton(
      {super.key, required this.people, this.personChosen, this.setPerson});

  @override
  State<PersonButton> createState() => PersonButtonState();
}

class PersonButtonState extends State<PersonButton> {
  Person? dropdownValue;

  @override
  Widget build(BuildContext context) {
    if (widget.personChosen != null) {
      dropdownValue = widget.people
          .firstWhere((element) => element.id == widget.personChosen!.id);
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
        if (widget.setPerson != null) {
          widget.setPerson!(value!);
        } else {
          setState(() {
            dropdownValue = value!;
          });
        }
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
