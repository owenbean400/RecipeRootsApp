import 'package:flutter/material.dart';

class CookingStepView extends StatefulWidget {
  final String instruction;
  final int order;

  const CookingStepView(
      {Key? key, required this.instruction, required this.order})
      : super(key: key);

  @override
  CookingStepViewState createState() => CookingStepViewState();
}

class CookingStepViewState extends State<CookingStepView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              color: Theme.of(context).highlightColor,
              width: constraints.maxWidth,
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
              child: Text("Step ${widget.order + 1}",
                  style: Theme.of(context).textTheme.bodyLarge));
        }),
        Padding(
            padding: const EdgeInsets.all(8),
            child: Text(widget.instruction,
                style: Theme.of(context).textTheme.bodySmall))
      ],
    );
  }
}
