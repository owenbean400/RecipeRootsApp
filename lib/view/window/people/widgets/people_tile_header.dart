import 'package:flutter/material.dart';

class FamilyRelationTileHeader extends StatelessWidget {
  const FamilyRelationTileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: (BorderSide(color: Colors.grey)))),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Name", style: Theme.of(context).textTheme.bodyMedium),
        Text("Relationship", style: Theme.of(context).textTheme.bodyMedium)
      ]),
    );
  }
}
