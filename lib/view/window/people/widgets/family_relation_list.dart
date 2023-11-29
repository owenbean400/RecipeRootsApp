import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/family_relation.dart';

class FamilyRelationTile extends StatelessWidget {
  final FamilyRelation familyRelation;
  final ValueSetter<FamilyRelation> setEditView;
  final bool? isBottomBorder;

  const FamilyRelationTile(
      {super.key,
      required this.setEditView,
      this.isBottomBorder,
      required this.familyRelation});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setEditView(familyRelation);
      },
      child: Container(
        decoration: BoxDecoration(
            border: (isBottomBorder ?? true)
                ? const Border(bottom: (BorderSide(color: Colors.grey)))
                : const Border()),
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(familyRelation.person.firstName,
              style: Theme.of(context).textTheme.bodyMedium),
          Text(familyRelation.familyRelation,
              style: Theme.of(context).textTheme.bodyMedium)
        ]),
      ),
    );
  }
}
