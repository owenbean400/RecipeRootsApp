import 'package:flutter/material.dart';

class CookingStepView extends StatefulWidget {
  final int order;
  final String instruction;

  const CookingStepView(
      {Key? key, required this.instruction, required this.order})
      : super(key: key);

  @override
  CookingStepViewState createState() => CookingStepViewState();
}

class CookingStepViewState extends State<CookingStepView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Step ${widget.order}",
                style: Theme.of(context).textTheme.bodyMedium),
            Text(widget.instruction,
                style: Theme.of(context).textTheme.bodySmall)
          ],
        ));
  }
}
