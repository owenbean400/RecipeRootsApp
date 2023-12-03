import 'package:graphview/GraphView.dart';
import 'package:flutter/material.dart';
import 'package:recipe_roots/dao/recipe_roots_dao.dart';

class NodePositionService {
  Future<void> updatePosition(Node node) async {
    RecipeRootsDAO().updatePosition(node.key?.value.id, node.x, node.y);
  }

  Future<Offset> loadPosition(Node node) async {
    return await RecipeRootsDAO().getPosition(node.key?.value.id);
  }
}

