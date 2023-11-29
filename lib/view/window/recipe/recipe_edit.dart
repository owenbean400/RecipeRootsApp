import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe.dart';
import 'package:recipe_roots/domain/entire_recipe_form.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/widget/header_backspace.dart';
import 'package:recipe_roots/view/window/recipe/widgets/authors_add_view.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_steps_add.dart';
import 'package:recipe_roots/view/window/recipe/widgets/desc_text_field_form.dart';
import 'package:recipe_roots/view/window/recipe/widgets/ingredients_add_view.dart';
import 'package:recipe_roots/view/window/recipe/widgets/submit_recipe_button.dart';
import 'package:recipe_roots/view/window/recipe/widgets/title_text_field_form.dart';

class RecipeEdit extends StatefulWidget {
  final Function goToRecipeViews;
  final EntireRecipe? editRecipe;
  const RecipeEdit({super.key, required this.goToRecipeViews, this.editRecipe});

  @override
  RecipeEditState createState() => RecipeEditState();
}

class RecipeEditState extends State<RecipeEdit> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Future<List<Person>> people = PersonService().getAllPeople();

  cancelAddRecipe() {
    widget.goToRecipeViews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
        future: people,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
                create: (context) => (widget.editRecipe == null)
                    ? EntireRecipeForm(
                        titleRecipeController: TextEditingController(),
                        descRecipeController: TextEditingController(),
                        cookingSteps: [],
                        authors: [],
                        ingredientForms: [])
                    : EntireRecipeForm.fromEntireRecipe(widget.editRecipe!),
                child: Column(
                  children: [
                    HeaderBackspace(
                        backSpaceAction: cancelAddRecipe,
                        title: (widget.editRecipe == null)
                            ? "New Recipe"
                            : "Edit ${widget.editRecipe!.recipe.title}"),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SingleChildScrollView(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const RecipeTitleTextFieldForm(),
                                    const RecipeDescTextFieldForm(),
                                    AuthorAdd(
                                      people: snapshot.data!,
                                    ),
                                    const IngredientsAdd(),
                                    const CookingStepsAdd(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 24),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SubmitRecipeFormButton(
                                              goToRecipeViews:
                                                  widget.goToRecipeViews)
                                        ],
                                      ),
                                    )
                                  ],
                                ))))
                  ],
                ));
          } else if (snapshot.hasError) {
            return HeaderBackspace(backSpaceAction: cancelAddRecipe, title: "");
          } else {
            return HeaderBackspace(backSpaceAction: cancelAddRecipe, title: "");
          }
        });
  }
}
