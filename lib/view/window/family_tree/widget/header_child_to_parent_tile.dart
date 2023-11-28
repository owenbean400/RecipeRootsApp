import 'package:flutter/material.dart';

class ChildToParentTileHeader extends StatelessWidget {
  const ChildToParentTileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: (BorderSide(color: Colors.grey)))),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Child", style: Theme.of(context).textTheme.bodyMedium),
        Text("Parent", style: Theme.of(context).textTheme.bodyMedium)
      ]),
    );
  }
}
