import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/child_to_parent.dart';
import 'package:recipe_roots/domain/child_to_parent_form.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/family_service.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/widget/header_backspace.dart';
import 'package:recipe_roots/view/window/recipe/widgets/person_drop_menu.dart';

class ChildToParentAdd extends StatefulWidget {
  final ChildToParent? childToParent;
  final Function goToViewFamilyTree;

  const ChildToParentAdd(
      {super.key, this.childToParent, required this.goToViewFamilyTree});

  @override
  ChildToParentAddState createState() => ChildToParentAddState();
}

class ChildToParentAddState extends State<ChildToParentAdd> {
  final Future<List<Person>> people = PersonService().getAllPeople();

  void update(ChildToParent updatedRecord) {
    FamilyService()
        .updateChildToParent(updatedRecord)
        .then((value) => {widget.goToViewFamilyTree()});
  }

  void delete(ChildToParent deletedRecord) {
    FamilyService()
        .deleteChildToParent(deletedRecord)
        .then((value) => {widget.goToViewFamilyTree()});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
        future: people,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
                create: (context) => (widget.childToParent != null)
                    ? ChildToParentForm(
                        childToParentId: widget.childToParent?.id,
                        child: widget.childToParent?.child,
                        parent: widget.childToParent?.parent)
                    : ChildToParentForm(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderBackspace(
                        backSpaceAction: widget.goToViewFamilyTree,
                        title: "Child/Parent",
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Child:",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Consumer<ChildToParentForm>(builder:
                                  ((context, childToParentForm, child) {
                                return PersonButton(
                                    people: snapshot.data!,
                                    setPerson: (value) {
                                      childToParentForm.updateChild(value);
                                    },
                                    personChosen: childToParentForm.child);
                              })),
                              Text(
                                "Parent:",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Consumer<ChildToParentForm>(builder:
                                  ((context, childToParentForm, child) {
                                return PersonButton(
                                    people: snapshot.data!,
                                    setPerson: (value) {
                                      childToParentForm.updateParent(value);
                                    },
                                    personChosen: childToParentForm.parent);
                              })),
                              Consumer<ChildToParentForm>(builder:
                                  ((context, childToParentForm, child) {
                                if (childToParentForm.child != null &&
                                    childToParentForm.parent != null) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      update(
                                          childToParentForm.getChildToParent());
                                    },
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Text(
                                          "Save child to parent",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        )),
                                  );
                                }

                                return Container();
                              })),
                              (widget.childToParent?.id != null)
                                  ? ElevatedButton(
                                      onPressed: () {
                                        delete(widget.childToParent!);
                                      },
                                      style: Theme.of(context)
                                          .elevatedButtonTheme
                                          .style,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 0),
                                          child: Text(
                                            "Delete Child To Parent",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          )),
                                    )
                                  : Container(),
                            ],
                          ))
                    ]));
          }
          return HeaderBackspace(
              backSpaceAction: widget.goToViewFamilyTree, title: "Family Tree");
        });
  }
}
