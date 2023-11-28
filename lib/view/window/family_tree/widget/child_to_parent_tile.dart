import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/child_to_parent.dart';

class ChildToParentTile extends StatelessWidget {
  final ChildToParent childToParent;
  final ValueSetter<ChildToParent> setEditView;
  final bool? isBottomBorder;

  const ChildToParentTile(
      {super.key,
      required this.setEditView,
      required this.childToParent,
      this.isBottomBorder});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setEditView(childToParent);
      },
      child: Container(
        decoration: BoxDecoration(
            border: (isBottomBorder ?? true)
                ? const Border(bottom: (BorderSide(color: Colors.grey)))
                : const Border()),
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
              "${childToParent.child.firstName} ${childToParent.child.lastName}",
              style: Theme.of(context).textTheme.bodyMedium),
          Text(
              "${childToParent.parent.firstName} ${childToParent.parent.lastName}",
              style: Theme.of(context).textTheme.bodyMedium)
        ]),
      ),
    );
  }
}
