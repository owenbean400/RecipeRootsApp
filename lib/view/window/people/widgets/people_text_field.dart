import 'package:flutter/material.dart';

class PeopleTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String labelText;
  final double borderRadius = 8;
  final Color? barColor;
  final bool? isDisabled;
  final bool? isMultipleLine;
  final double? height;

  const PeopleTextField(
      {super.key,
      required this.textFieldController,
      required this.labelText,
      this.isDisabled,
      this.isMultipleLine,
      this.barColor,
      this.height});

  @override
  Widget build(BuildContext context) {
    Color backgroundColorBar = barColor ?? Theme.of(context).hintColor;

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$labelText:"),
            SizedBox(
              height: height,
              child: TextField(
                  expands: height != null,
                  style: Theme.of(context).textTheme.bodyMedium,
                  readOnly: isDisabled ?? false,
                  controller: textFieldController,
                  cursorColor: Theme.of(context).primaryColor,
                  maxLines: (isMultipleLine ?? false) ? null : 1,
                  keyboardType: (isMultipleLine ?? false)
                      ? TextInputType.multiline
                      : TextInputType.text,
                  decoration: InputDecoration(
                    isCollapsed: height != null,
                    contentPadding: const EdgeInsets.all(8),
                    border: InputBorder.none,
                    fillColor: backgroundColorBar,
                    filled: true,
                    focusColor: Theme.of(context).primaryColorLight,
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(borderRadius)),
                      borderSide:
                          BorderSide(color: backgroundColorBar, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(borderRadius)),
                      borderSide: BorderSide(color: backgroundColorBar),
                    ),
                  )),
            )
          ],
        ));
  }
}
