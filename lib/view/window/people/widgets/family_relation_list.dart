import 'package:flutter/material.dart';

class FamilyRelationTile extends StatelessWidget {
  final String name;
  final String relationship;

  const FamilyRelationTile(
      {super.key, required this.name, required this.relationship});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: (BorderSide(color: Colors.grey)))),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(name, style: Theme.of(context).textTheme.bodyMedium),
        Text(relationship, style: Theme.of(context).textTheme.bodyMedium)
      ]),
    );
  }
}
