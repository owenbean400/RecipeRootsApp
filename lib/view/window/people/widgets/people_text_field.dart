import 'package:flutter/material.dart';

class PeopleTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String labelText;
  final double borderRadius = 8;
  final bool? isDisabled;
  final bool? isMultipleLine;

  const PeopleTextField(
      {super.key,
      required this.textFieldController,
      required this.labelText,
      this.isDisabled,
      this.isMultipleLine});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$labelText:"),
            TextField(
                readOnly: isDisabled ?? false,
                controller: textFieldController,
                cursorColor: Theme.of(context).primaryColor,
                maxLines: (isMultipleLine ?? false) ? null : 1,
                keyboardType: (isMultipleLine ?? false)
                    ? TextInputType.multiline
                    : TextInputType.text,
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
