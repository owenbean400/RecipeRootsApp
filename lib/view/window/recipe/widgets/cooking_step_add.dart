import 'package:flutter/material.dart';
import 'package:recipe_roots/view/window/people/people_add.dart';
import 'package:recipe_roots/view/window/people/widgets/people_text_field.dart';

class CookingStepAdd extends StatelessWidget {
  final TextEditingController textController;
  final int step;
  final ValueSetter<int> isDelete;
  final double borderRadius = 8;

  const CookingStepAdd(
      {super.key,
      required this.textController,
      required this.step,
      required this.isDelete});

  void removeRecord() {
    isDelete(step);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).hintColor),
      child: Column(children: [
        PeopleTextField(
            textFieldController: textController,
            labelText: "Instruction",
            barColor: Theme.of(context).primaryColorLight,
            isMultipleLine: true,
            height: 180),
        ElevatedActionButton(
          buttonText: "Remove Cooking Step",
          action: removeRecord,
        ),
        Text("${step + 1}")
      ]),
    );
  }
}
