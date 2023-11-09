import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:recipe_roots/domain/family_tree.dart';
import 'package:recipe_roots/service/family_service.dart';

class FamilyTreeView extends StatefulWidget {
  const FamilyTreeView({super.key});

  @override
  FamilyTreeViewState createState() => FamilyTreeViewState();
}

class FamilyTreeViewState extends State<FamilyTreeView> {
  final Future<List<FamilyTree>> familyTree = FamilyService().getFamilyTree();
  SugiyamaConfiguration builder = SugiyamaConfiguration();

  void isAddFamilyTree() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: familyTree,
        builder: (context, snapshot) {
          final Graph graph = Graph()..isTree = true;

          if (snapshot.hasData) {
            List<Node> nodes = [];

            for (FamilyTree familyTree in snapshot.data ?? []) {
              nodes.add(Node.Id(familyTree));
            }

            for (Node node in nodes) {
              FamilyTree familyNode = node.key!.value;

              if (familyNode.parent1 != null) {
                Node nodeParent1 = nodes.firstWhere((element) =>
                    element.key!.value.id == familyNode.parent1?.id);
                graph.addEdge(node, nodeParent1);
              }

              if (familyNode.parent2 != null) {
                Node nodeParent2 = nodes.firstWhere((element) =>
                    element.key!.value.id == familyNode.parent2?.id);
                graph.addEdge(node, nodeParent2);
              }
              graph.addNode(node);
            }

            builder.orientation = 1;
            builder.levelSeparation = 32;
            builder.nodeSeparation = 32;
            builder.coordinateAssignment = CoordinateAssignment.Average;
            builder.bendPointShape = CurvedBendPointShape(curveLength: 5);

            return Column(children: [
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(16, 48, 0, 16),
                    width: constraints.maxWidth,
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Family Tree",
                            style: Theme.of(context).textTheme.bodyLarge),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: InkWell(
                            onTap: () {
                              isAddFamilyTree();
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
                    ),
                  );
                },
              ),
              Expanded(
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
                            FamilyTree? familyNode = node.key?.value;
                            return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                    "${familyNode?.child?.firstName[0] ?? "?"}${familyNode?.child?.lastName[0] ?? "?"}"));
                          })))
            ]);
          }

          return Container();
        });
  }
}
