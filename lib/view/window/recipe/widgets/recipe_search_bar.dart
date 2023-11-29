import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_roots/domain/selection_search_bar_form.dart';
import 'package:recipe_roots/view/window/recipe/widgets/advance_recipe_search_checkbox.dart';

class RecipeSearchBar extends StatefulWidget {
  final Function(String, bool, bool, bool, bool, bool) searchForRecipes;
  final Function addRecipe;

  const RecipeSearchBar(
      {Key? key, required this.searchForRecipes, required this.addRecipe})
      : super(key: key);

  @override
  RecipeSearchBarState createState() => RecipeSearchBarState();
}

class RecipeSearchBarState extends State<RecipeSearchBar> {
  bool showAdvanceMenu = false;

  @override
  Widget build(BuildContext context) {
    return (Container(
        color: Theme.of(context).primaryColor,
        height: (Platform.isIOS)
            ? ((showAdvanceMenu) ? 460 : 140)
            : ((showAdvanceMenu) ? 440 : 108),
        child: Column(children: [
          Padding(
              padding: (Platform.isIOS)
                  ? const EdgeInsets.fromLTRB(8, 58, 8, 8)
                  : const EdgeInsets.fromLTRB(8, 32, 8, 8),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Consumer<SelectionSearchBarForm>(
                    builder: ((context, selectionForm, child) {
                  return InkWell(
                    onTap: () {
                      widget.searchForRecipes(
                          selectionForm.searchController.text,
                          selectionForm.isSearchTitle,
                          selectionForm.isSearchDescription,
                          selectionForm.isSearchPeople,
                          selectionForm.isSearchFamilyRelation,
                          selectionForm.isSearchIngredients);
                    },
                    child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 64,
                          width: 64,
                          child: Icon(
                            Icons.search_rounded,
                            size: 32,
                          ),
                        )),
                  );
                })),
                Expanded(
                  child: Consumer<SelectionSearchBarForm>(
                      builder: ((context, selectionForm, child) {
                    return TextField(
                      controller: selectionForm.searchController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        focusColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    );
                  })),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      showAdvanceMenu = !showAdvanceMenu;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: Icon(
                          (showAdvanceMenu)
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
                          size: 32,
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    widget.addRecipe();
                  },
                  child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: Icon(Icons.library_add_outlined, size: 32),
                      )),
                )
              ])),
          (showAdvanceMenu) ? const AdvanceRecipeSearchCheckbox() : Container(),
        ])));
  }
}
