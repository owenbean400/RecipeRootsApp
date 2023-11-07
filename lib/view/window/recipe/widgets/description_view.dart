import 'package:flutter/material.dart';

class DescriptionView extends StatefulWidget {
  final String description;

  const DescriptionView({Key? key, required this.description})
      : super(key: key);

  @override
  DescriptionViewState createState() => DescriptionViewState();
}

class DescriptionViewState extends State<DescriptionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [const Text("Description"), Text(widget.description)],
    );
  }
}
