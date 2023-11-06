import 'package:flutter/material.dart';

class PeopleTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String labelText;
  final double borderRadius = 8;

  const PeopleTextField(
      {super.key, required this.textFieldController, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$labelText:"),
            TextField(
                controller: textFieldController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Theme.of(context).hintColor,
                  filled: true,
                  focusColor: Theme.of(context).primaryColorLight,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    borderSide: BorderSide(
                        color: Theme.of(context).hintColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    borderSide: BorderSide(color: Theme.of(context).hintColor),
                  ),
                )),
          ],
        ));
  }
}
