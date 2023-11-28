import 'dart:io';

import 'package:flutter/material.dart';

class HeaderAddWithSecondAction extends StatelessWidget {
  final Function addAction;
  final Function secondButtonAction;
  final IconData secondIcon;
  final String title;

  const HeaderAddWithSecondAction(
      {super.key,
      required this.addAction,
      required this.title,
      required this.secondButtonAction,
      required this.secondIcon});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: (Platform.isIOS)
              ? const EdgeInsets.fromLTRB(16, 48, 0, 16)
              : const EdgeInsets.fromLTRB(16, 16, 0, 16),
          width: constraints.maxWidth,
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 8, 0),
                    child: InkWell(
                        onTap: () {
                          secondButtonAction();
                        },
                        child: Icon(secondIcon, size: 32)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: InkWell(
                      onTap: () {
                        addAction();
                      },
                      child: Text(
                        "+",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
