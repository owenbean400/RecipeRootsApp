import 'package:flutter/material.dart';

class PeopleText extends StatelessWidget {
  final String text;
  final String labelText;
  final double borderRadius = 8;

  const PeopleText({super.key, required this.text, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("$labelText:"),
            Text(text, style: Theme.of(context).textTheme.bodyLarge)
          ],
        ));
  }
}
