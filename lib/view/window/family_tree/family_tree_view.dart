import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:recipe_roots/domain/child_to_parent.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/domain/recipe.dart';
import 'package:recipe_roots/helper/the_person.dart';
import 'package:recipe_roots/service/family_service.dart';
import 'package:recipe_roots/view/widget/header_person_list.dart';
import 'package:recipe_roots/service/node_position_service.dart';
import 'package:recipe_roots/dao/recipe_roots_dao.dart';
import 'package:recipe_roots/view/navigation_view.dart';

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
  final Graph graph = Graph();
  final Future<List<ChildToParent>> familyTree =
      FamilyService().getFamilyTree(ThePersonSingleton().user!);
  SugiyamaConfiguration builder = SugiyamaConfiguration();

  List<Node> nodes = [];

  void addFamilyTree() {
    widget.setAddFamilyTree(null);
  }

  Future<void> loadNodePositions(List<Node> nodes) async {
    for (Node node in nodes) {
      try {
        Offset position = await NodePositionService().loadPosition(node);
        node.x = position.dx;
        node.y = position.dy;
      } catch (e) {
        //
      }
    }
  }

  void createEdges(List<Node> nodes, List<ChildToParent> data) {
    for (Node node in nodes) {
      try {
        for (ChildToParent childToParent in data) {
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
  }

  @override
  void dispose() {
    // Save node positions when we exit that screen
    saveNodePositions();
    super.dispose();
  }

  Future<void> saveNodePositions() async {
    for (Node node in nodes) {
      await NodePositionService().savePosition(node);
    }
  }

  Future<void> onNodeTap(Person person) async {
    print('Node tapped: ${person.id}');
    int id = person.id ?? 0;
    List<Recipe> recipesByPerson = await RecipeRootsDAO().getRecipesByPerson(id);

    // Check if the widget is still in the tree
    if (!mounted) return;

    // Access the NavigationViewBarState and update it
    navigationBarKey.currentState?.updateRecipeView(recipesByPerson);
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderAddWithSecondAction(
          addAction: addFamilyTree,
          secondButtonAction: widget.goToChildToParentList,
          secondIcon: Icons.list,
          title: "Family Tree",
        ),
        FutureBuilder(
          future: familyTree,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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

              for (Node node in nodes) {
                graph.addNode(node);
              }

              loadNodePositions(nodes);

              createEdges(nodes, snapshot.data ?? []);

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
                  onInteractionEnd: (details) async {
                    // Save nodes with a tap of the screen
                    for (Node node in nodes) {
                      await NodePositionService().savePosition(node);
                    }
                  },
                  child: GraphView(
                    graph: graph,
                    algorithm: FruchtermanReingoldAlgorithm(
                      attractionPercentage: 1,
                      attractionRate: 1,
                      repulsionPercentage: 0.1,
                      repulsionRate: 0.1,
                      iterations: 1,
                    ),
                    paint: Paint()
                      ..color = Theme.of(context).primaryColorDark
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      Person familyNode = node.key?.value;
                      return GestureDetector(
                        onTap: () => onNodeTap(familyNode),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${(familyNode.firstName.isNotEmpty) ? familyNode.firstName[0] : ""}${(familyNode.lastName.isNotEmpty) ? familyNode.lastName[0] : ""}",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
