import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe_form.dart';
import 'package:recipe_roots/view/window/people/widgets/people_text_field.dart';

class RecipeTitleTextFieldForm extends StatelessWidget {
  const RecipeTitleTextFieldForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EntireRecipeForm>(builder: ((context, recipeForm, child) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: PeopleTextField(
            textFieldController: recipeForm.titleRecipeController,
            labelText: "Recipe Name",
          ));
    }));
  }
}
