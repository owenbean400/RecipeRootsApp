import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/view/window/recipe/widgets/person_drop_menu.dart';

class AuthorAdd extends StatefulWidget {
  final List<Person> people;
  const AuthorAdd({super.key, required this.people});

  @override
  AuthorAddState createState() => AuthorAddState();
}

class AuthorAddState extends State<AuthorAdd> {
  List<PersonButton> authors = [];

  void subtractAuthor() {
    setState(() {
      authors.removeAt(authors.length - 1);
    });
  }

  void addAuthor() {
    setState(() {
      authors.add(PersonButton(people: widget.people));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (authors.isEmpty) {
      authors.add(PersonButton(people: widget.people));
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
          width: constraints.maxWidth,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Text("Authors  "),
              InkWell(
                  onTap: () {
                    addAuthor();
                  },
                  child: Text(
                    "+ ",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  )),
              (authors.length > 1)
                  ? InkWell(
                      onTap: () {
                        subtractAuthor();
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
            ...authors,
          ]));
    });
  }
}
