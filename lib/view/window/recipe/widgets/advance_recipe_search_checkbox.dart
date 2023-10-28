import 'package:flutter/material.dart';

class AdvanceRecipeSearchCheckbox extends StatefulWidget {
  final bool startSearchTitleChecked;
  final bool startSearchDescriptionChecked;
  final bool startSearchPeopleChecked;
  final bool startSearchFamilyRelationChecked;
  final bool startSearchIngredientsChecked;

  const AdvanceRecipeSearchCheckbox(
      {required this.startSearchDescriptionChecked,
      required this.startSearchFamilyRelationChecked,
      required this.startSearchIngredientsChecked,
      required this.startSearchPeopleChecked,
      required this.startSearchTitleChecked,
      Key? key})
      : super(key: key);

  @override
  AdvanceRecipeSearchCheckboxState createState() =>
      AdvanceRecipeSearchCheckboxState();
}

class AdvanceRecipeSearchCheckboxState
    extends State<AdvanceRecipeSearchCheckbox> {
  decoyFunction(bool? t) {}

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
        child: Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          CheckBoxTitle(
              text: "Search Title",
              checkBoxChange: decoyFunction,
              isAlreadyChecked: widget.startSearchTitleChecked),
          CheckBoxTitle(
              text: "Search Description",
              checkBoxChange: decoyFunction,
              isAlreadyChecked: widget.startSearchDescriptionChecked),
          CheckBoxTitle(
              text: "Search People",
              checkBoxChange: decoyFunction,
              isAlreadyChecked: widget.startSearchPeopleChecked),
          CheckBoxTitle(
              text: "Search Family Relation",
              checkBoxChange: decoyFunction,
              isAlreadyChecked: widget.startSearchFamilyRelationChecked),
          CheckBoxTitle(
              text: "Search Ingredients",
              checkBoxChange: decoyFunction,
              isAlreadyChecked: widget.startSearchIngredientsChecked)
        ],
      ),
    )));
  }
}

class CheckBoxTitle extends StatefulWidget {
  final String text;
  final ValueSetter<bool> checkBoxChange;
  final bool isAlreadyChecked;

  const CheckBoxTitle(
      {required this.isAlreadyChecked,
      required this.text,
      required this.checkBoxChange,
      Key? key})
      : super(key: key);

  @override
  CheckBoxTitleState createState() => CheckBoxTitleState();
}

class CheckBoxTitleState extends State<CheckBoxTitle> {
  bool? isChecked;

  @override
  void initState() {
    setState(() {
      isChecked = widget.isAlreadyChecked;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      height: 64,
      child: Row(children: [
        SizedBox(
          width: 64,
          height: 64,
          child: Checkbox(
            checkColor: Theme.of(context).primaryColor,
            activeColor: Colors.black,
            fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.black.withOpacity(.32);
              }
              return Colors.black;
            }),
            value: isChecked,
            onChanged: (value) {
              widget.checkBoxChange(value ?? false);
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
        Text(widget.text, style: Theme.of(context).textTheme.headlineSmall)
      ]),
    ));
  }
}
