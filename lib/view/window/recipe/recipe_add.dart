import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe_form.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/widget/header_backspace.dart';
import 'package:recipe_roots/view/window/recipe/widgets/authors_add_view.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_steps_add.dart';
import 'package:recipe_roots/view/window/recipe/widgets/desc_text_field_form.dart';
import 'package:recipe_roots/view/window/recipe/widgets/submit_recipe_button.dart';
import 'package:recipe_roots/view/window/recipe/widgets/title_text_field_form.dart';

class RecipeAdd extends StatefulWidget {
  final Function goToRecipeViews;
  const RecipeAdd({super.key, required this.goToRecipeViews});

  @override
  RecipeAddState createState() => RecipeAddState();
}

class RecipeAddState extends State<RecipeAdd> {
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
                create: (context) => EntireRecipeForm(
                    titleRecipeController: TextEditingController(),
                    descRecipeController: TextEditingController(),
                    cookingSteps: [],
                    authors: []),
                child: Column(
                  children: [
                    HeaderBackspace(
                        backSpaceAction: cancelAddRecipe, title: "New Recipe"),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: SingleChildScrollView(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const RecipeTitleTextFieldForm(),
                                const RecipeDescTextFieldForm(),
                                AuthorAdd(
                                  people: snapshot.data!,
                                ),
                                Text(
                                  "Cooking Steps:",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const CookingStepsAdd(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SubmitRecipeFormButton(
                                        goToRecipeViews: widget.goToRecipeViews)
                                  ],
                                )
                              ],
                            ))))
                  ],
                ));
          } else if (snapshot.hasError) {
            return HeaderBackspace(
                backSpaceAction: cancelAddRecipe, title: "New Recipe");
          } else {
            return HeaderBackspace(
                backSpaceAction: cancelAddRecipe, title: "New Recipe");
          }
        });
  }
}
