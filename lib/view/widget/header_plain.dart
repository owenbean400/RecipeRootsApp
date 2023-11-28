import 'dart:io';

import 'package:flutter/material.dart';

class HeaderPlain extends StatelessWidget {
  final String title;

  const HeaderPlain({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: (Platform.isIOS)
              ? const EdgeInsets.fromLTRB(16, 56, 0, 16)
              : const EdgeInsets.fromLTRB(16, 16, 0, 16),
          width: constraints.maxWidth,
          color: Theme.of(context).primaryColor,
          child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        );
      },
    );
  }
}
