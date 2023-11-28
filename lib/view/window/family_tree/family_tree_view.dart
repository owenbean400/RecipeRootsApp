import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:recipe_roots/domain/child_to_parent.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/helper/the_person.dart';
import 'package:recipe_roots/service/family_service.dart';
import 'package:recipe_roots/view/widget/header_person_list.dart';

class FamilyTreeView extends StatefulWidget {
  final ValueSetter<ChildToParent?> setAddFamilyTree;
  final Function goToChildToParentList;

  const FamilyTreeView(
      {super.key,
      required this.setAddFamilyTree,
      required this.goToChildToParentList});

  @override
  FamilyTreeViewState createState() => FamilyTreeViewState();
}

class FamilyTreeViewState extends State<FamilyTreeView> {
  final Future<List<ChildToParent>> familyTree =
      FamilyService().getFamilyTree(ThePersonSingleton().user!);
  SugiyamaConfiguration builder = SugiyamaConfiguration();

  void addFamilyTree() {
    widget.setAddFamilyTree(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HeaderAddWithSecondAction(
          addAction: addFamilyTree,
          secondButtonAction: widget.goToChildToParentList,
          secondIcon: Icons.list,
          title: "Family Tree"),
      FutureBuilder(
          future: familyTree,
          builder: (context, snapshot) {
            final Graph graph = Graph()..isTree = true;

            if (snapshot.hasData) {
              List<Node> nodes = [];
              Map<int, Person> ids = {};

              for (ChildToParent childToParentNode in snapshot.data ?? []) {
                if (!ids.containsKey(childToParentNode.child.id)) {
                  ids[childToParentNode.child.id!] = childToParentNode.child;
                  nodes.add(Node.Id(childToParentNode.child));
                }

                if (!ids.containsKey(childToParentNode.parent.id)) {
                  ids[childToParentNode.parent.id!] = childToParentNode.parent;
                  nodes.add(Node.Id(childToParentNode.parent));
                }
              }

              // Sometimes an edge added before node, so it does not show
              for (Node node in nodes) {
                graph.addNode(node);
              }

              for (Node node in nodes) {
                try {
                  for (ChildToParent childToParent in snapshot.data ?? []) {
                    if (node.key!.value.id == childToParent.child.id) {
                      Node possibleParentNode = nodes.firstWhere((element) =>
                          element.key!.value.id == childToParent.parent.id);

                      graph.addEdge(node, possibleParentNode);
                    }
                  }
                } catch (e) {
                  //
                }
              }

              builder.orientation = 1;
              builder.levelSeparation = 32;
              builder.nodeSeparation = 32;
              builder.coordinateAssignment = CoordinateAssignment.Average;
              builder.bendPointShape = CurvedBendPointShape(curveLength: 5);

              return Expanded(
                  child: InteractiveViewer(
                      constrained: false,
                      boundaryMargin: const EdgeInsets.all(64),
                      minScale: 0.1,
                      maxScale: 100.6,
                      child: GraphView(
                          graph: graph,
                          algorithm: FruchtermanReingoldAlgorithm(
                              attractionPercentage: 1,
                              attractionRate: 1,
                              repulsionPercentage: 0.1,
                              repulsionRate: 0.1,
                              iterations: 1),
                          paint: Paint()
                            ..color = Theme.of(context).primaryColorDark
                            ..strokeWidth = 1
                            ..style = PaintingStyle.stroke,
                          builder: (Node node) {
                            Person familyNode = node.key?.value;
                            return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                    "${familyNode.firstName[0]}${familyNode.lastName[0]}"));
                          })));
            }
            return Container();
          })
    ]);
  }
}
