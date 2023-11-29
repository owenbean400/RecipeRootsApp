import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/cooking_step.dart';
import 'package:recipe_roots/helper/map_index.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_step_view.dart';

class CookingStepsView extends StatelessWidget {
  final List<CookingStep> cookingSteps;
  final double borderRadius = 2;

  const CookingStepsView({required this.cookingSteps, super.key});

  @override
  Widget build(BuildContext context) {
    return (cookingSteps.isNotEmpty)
        ? (cookingSteps.length == 1)
            ? Builder(
                builder: (BuildContext context) {
                  return Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 36),
                      decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(borderRadius),
                              bottomRight: Radius.circular(borderRadius))),
                      child: CookingStepView(
                          instruction: cookingSteps.first.instruction,
                          order: 0));
                },
              )
            : CarouselSlider(
                items: mapIndexed(cookingSteps, (index, item) {
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
              )
        : Container();
  }
}
