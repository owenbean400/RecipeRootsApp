import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/entire_recipe_form.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/view/window/recipe/widgets/person_drop_menu.dart';

class AuthorAdd extends StatefulWidget {
  final List<Person> people;
  const AuthorAdd({super.key, required this.people});

  @override
  AuthorAddState createState() => AuthorAddState();
}

class AuthorAddState extends State<AuthorAdd> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Consumer<EntireRecipeForm>(builder: ((context, recipeForm, child) {
        List<PersonButton> authorWidget = [];

        for (int i = 0; i < recipeForm.authors.length; i++) {
          authorWidget.add(PersonButton(
            people: widget.people,
            personChosen: recipeForm.authors[i],
            setPerson: (value) {
              recipeForm.personUpdate(value, i);
            },
          ));
        }

        return SizedBox(
            width: constraints.maxWidth,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Text("Authors  "),
                InkWell(
                    onTap: () {
                      recipeForm.personAdd(widget.people.first);
                    },
                    child: Text(
                      "+ ",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    )),
                (recipeForm.authors.length > 1)
                    ? InkWell(
                        onTap: () {
                          recipeForm.personRemoveEnd();
                        },
                        child: const Text(
                          "x",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ))
                    : Container(),
              ]),
              ...authorWidget,
            ]));
      }));
    });
  }
}
