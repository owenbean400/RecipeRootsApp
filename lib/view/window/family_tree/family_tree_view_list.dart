import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/child_to_parent.dart';
import 'package:recipe_roots/service/family_service.dart';
import 'package:recipe_roots/view/widget/header_person_list.dart';
import 'package:recipe_roots/view/window/family_tree/widget/child_to_parent_tile.dart';
import 'package:recipe_roots/view/window/family_tree/widget/header_child_to_parent_tile.dart';

class FamilyTreeViewList extends StatefulWidget {
  final ValueSetter<ChildToParent?> setAddFamilyTree;
  final Function setTreeGraphView;

  const FamilyTreeViewList(
      {super.key,
      required this.setTreeGraphView,
      required this.setAddFamilyTree});

  @override
  FamilyTreeViewLevelState createState() => FamilyTreeViewLevelState();
}

class FamilyTreeViewLevelState extends State<FamilyTreeViewList> {
  final Future<List<ChildToParent>> childToParentList =
      FamilyService().getAllChildToParent();

  void addChildToParentRelationship() {
    widget.setAddFamilyTree(null);
  }

  void editChildToParentRelationship(ChildToParent childToParent) {
    widget.setAddFamilyTree(childToParent);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderAddWithSecondAction(
            addAction: addChildToParentRelationship,
            secondButtonAction: widget.setTreeGraphView,
            secondIcon: Icons.account_tree,
            title: "Child To Parent"),
        FutureBuilder(
          future: childToParentList,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Widget> childToParentTile = [];

              childToParentTile.add(const ChildToParentTileHeader());

              for (int i = 0; i < snapshot.data!.length; i++) {
                childToParentTile.add(ChildToParentTile(
                    childToParent: snapshot.data![i],
                    setEditView: editChildToParentRelationship,
                    isBottomBorder: i != snapshot.data!.length - 1));
              }

              return Expanded(
                  child: SingleChildScrollView(
                child: Column(children: childToParentTile),
              ));
            }

            return Container();
          }),
        )
      ],
    );
  }
}
