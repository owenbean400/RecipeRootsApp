import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe_form.dart';
import 'package:recipe_roots/view/window/people/widgets/people_text_field.dart';

class RecipeDescTextFieldForm extends StatelessWidget {
  const RecipeDescTextFieldForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EntireRecipeForm>(builder: ((context, recipeForm, child) {
      return PeopleTextField(
        textFieldController: recipeForm.descRecipeController,
        isMultipleLine: true,
        labelText: "Description",
      );
    }));
  }
}
