import 'package:flutter/material.dart';

class IngredentCardView extends StatelessWidget {
  final String amount;
  final String unit;
  final String ingredient;
  final double width;
  final bool? isShow;

  const IngredentCardView(
      {super.key,
      required this.amount,
      required this.unit,
      required this.ingredient,
      required this.width,
      this.isShow});

  @override
  Widget build(BuildContext context) {
    return (isShow ?? true)
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Container(
                padding: const EdgeInsets.all(8),
                height: 64,
                width: width,
                color: Theme.of(context).hintColor,
                child: Text("$amount $unit $ingredient",
                    maxLines: 2, overflow: TextOverflow.fade)))
        : Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Container(width: width));
  }
}
