import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/cooking_step.dart';
import 'package:recipe_roots/helper/map_index.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_step_view.dart';

class CookingStepsView extends StatefulWidget {
  final List<CookingStep> cookingSteps;

  const CookingStepsView({Key? key, required this.cookingSteps})
      : super(key: key);

  @override
  CookingStepsViewState createState() => CookingStepsViewState();
}

class CookingStepsViewState extends State<CookingStepsView> {
  final double borderRadius = 2;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: mapIndexed(widget.cookingSteps, (index, item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius))),
                child: CookingStepView(
                    instruction: item.instruction, order: index));
          },
        );
      }).toList(),
      options: CarouselOptions(height: 400.0),
    );
  }
}
