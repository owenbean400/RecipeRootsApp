import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/cooking_step.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_step_view.dart';

class CookingStepsView extends StatefulWidget {
  final List<CookingStep> cookingSteps;

  const CookingStepsView({Key? key, required this.cookingSteps})
      : super(key: key);

  @override
  CookingStepsViewState createState() => CookingStepsViewState();
}

class CookingStepsViewState extends State<CookingStepsView> {
  @override
  Widget build(BuildContext context) {
    List<CookingStepView> cookingStepsView = [];

    for (int i = 0; i < widget.cookingSteps.length; i++) {
      cookingStepsView.add(CookingStepView(
          instruction: widget.cookingSteps[i].instruction, order: i + 1));
    }

    return Column(
      children: cookingStepsView,
    );
  }
}
