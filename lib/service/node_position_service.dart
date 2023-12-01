import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphview/GraphView.dart';
import 'package:flutter/material.dart';

class NodePositionService {
  Future<void> savePosition(Node node) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('node_${node.key?.value.id}_x', node.x);
    await prefs.setDouble('node_${node.key?.value.id}_y', node.y);
  }

  Future<Offset> loadPosition(Node node) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double x = prefs.getDouble('node_${node.key?.value.id}_x') ?? 0.0;
    double y = prefs.getDouble('node_${node.key?.value.id}_y') ?? 0.0;
    return Offset(x, y);
  }
}

