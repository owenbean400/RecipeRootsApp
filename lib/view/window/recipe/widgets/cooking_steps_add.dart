import 'package:flutter/material.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_step_add.dart';

class CookingStepsAdd extends StatefulWidget {
  const CookingStepsAdd({super.key});

  @override
  CookingStepsAddState createState() => CookingStepsAddState();
}

class CookingStepsAddState extends State<CookingStepsAdd> {
  List<TextEditingController> textControllers = [TextEditingController()];

  void deleteSection(int index) {
    setState(() {
      textControllers.removeAt(index);
    });
  }

  void addStep() {
    setState(() {
      textControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CookingStepAdd> cookingStepWidget = [];

    for (int i = 0; i < textControllers.length; i++) {
      cookingStepWidget.add(CookingStepAdd(
          textController: textControllers[i],
          step: i,
          isDelete: (value) {
            deleteSection(value);
          }));
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
          width: constraints.maxWidth,
          child: Column(children: [
            ...cookingStepWidget,
            ElevatedButton(
              onPressed: () {
                addStep();
              },
              style: Theme.of(context).elevatedButtonTheme.style,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    "Add Another Cooking Step",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            )
          ]));
    });
  }
}
