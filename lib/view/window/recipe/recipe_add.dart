import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/widget/header_backspace.dart';
import 'package:recipe_roots/view/window/people/people_add.dart';
import 'package:recipe_roots/view/window/people/widgets/people_text_field.dart';
import 'package:recipe_roots/view/window/recipe/widgets/authors_add_view.dart';
import 'package:recipe_roots/view/window/recipe/widgets/cooking_steps_add.dart';

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

  saveAddRecipe() {
    widget.goToRecipeViews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
        future: people,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
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
                            PeopleTextField(
                              labelText: "Recipe Name",
                              textFieldController: titleController,
                            ),
                            PeopleTextField(
                                labelText: "Description",
                                textFieldController: descriptionController,
                                isMultipleLine: true),
                            AuthorAdd(
                              people: snapshot.data!,
                            ),
                            Text(
                              "Cooking Steps:",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const CookingStepsAdd(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedActionButton(
                                    action: saveAddRecipe,
                                    buttonText: "Save Recipe")
                              ],
                            )
                          ],
                        ))))
              ],
            );
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
