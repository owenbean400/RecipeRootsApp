import 'package:flutter/material.dart';

class HeaderBackspace extends StatelessWidget {
  final Function backSpaceAction;
  final String title;

  const HeaderBackspace(
      {super.key, required this.backSpaceAction, required this.title});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: EdgeInsets.fromLTRB(
              16, MediaQuery.of(context).viewPadding.top + 16, 0, 16),
          width: constraints.maxWidth,
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: InkWell(
                  onTap: () {
                    backSpaceAction();
                  },
                  child: const Icon(Icons.arrow_back_ios_new_sharp),
                ),
              ),
              Expanded(
                  child: Text(title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge)),
            ],
          ),
        );
      },
    );
  }
}
