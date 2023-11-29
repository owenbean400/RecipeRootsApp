import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/selection_search_bar_form.dart';

class AdvanceRecipeSearchCheckbox extends StatelessWidget {
  const AdvanceRecipeSearchCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
        child: Padding(
      padding: const EdgeInsets.all(4),
      child: Consumer<SelectionSearchBarForm>(
          builder: ((context, selectionForm, child) {
        return Column(
          children: [
            CheckBoxTitle(
                text: "Search Title",
                checkboxClicked: selectionForm.setSearchTitle,
                checked: selectionForm.isSearchTitle),
            CheckBoxTitle(
                text: "Search Description",
                checkboxClicked: selectionForm.setSearchDescription,
                checked: selectionForm.isSearchDescription),
            CheckBoxTitle(
                text: "Search People",
                checkboxClicked: selectionForm.setSearchPeople,
                checked: selectionForm.isSearchPeople),
            CheckBoxTitle(
                text: "Search Family Relation",
                checkboxClicked: selectionForm.setSearchFamilyRelation,
                checked: selectionForm.isSearchFamilyRelation),
            CheckBoxTitle(
                text: "Search Ingredients",
                checkboxClicked: selectionForm.setSearchIngredients,
                checked: selectionForm.isSearchIngredients)
          ],
        );
      })),
    )));
  }
}

class CheckBoxTitle extends StatelessWidget {
  final Function checkboxClicked;
  final bool checked;
  final String text;

  const CheckBoxTitle(
      {required this.checked,
      Key? key,
      required this.text,
      required this.checkboxClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          checkboxClicked();
        },
        child: SizedBox(
          height: 64,
          child: Row(children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Checkbox(
                checkColor: Theme.of(context).primaryColor,
                activeColor: Theme.of(context).primaryColorLight,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Theme.of(context).primaryColorLight.withOpacity(0.1);
                  }
                  return Theme.of(context).primaryColorLight;
                }),
                value: checked,
                onChanged: (value) {
                  checkboxClicked();
                },
              ),
            ),
            Text(text, style: Theme.of(context).textTheme.headlineSmall)
          ]),
        ));
  }
}
