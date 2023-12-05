import 'package:flutter/material.dart';

class HeaderPlain extends StatelessWidget {
  final String title;

  const HeaderPlain({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: EdgeInsets.fromLTRB(
              16, MediaQuery.of(context).viewPadding.top + 16, 0, 16),
          width: constraints.maxWidth,
          color: Theme.of(context).primaryColor,
          child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        );
      },
    );
  }
}
