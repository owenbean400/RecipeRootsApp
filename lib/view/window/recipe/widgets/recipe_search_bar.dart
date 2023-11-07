import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_roots/view/window/recipe/widgets/advance_recipe_search_checkbox.dart';

class RecipeSearchBar extends StatefulWidget {
  final Function(String, bool, bool, bool, bool, bool) searchForRecipes;
  const RecipeSearchBar({Key? key, required this.searchForRecipes})
      : super(key: key);

  @override
  RecipeSearchBarState createState() => RecipeSearchBarState();
}

class RecipeSearchBarState extends State<RecipeSearchBar> {
  late TextEditingController _searchController;
  bool showAdvanceMenu = false;

  bool isSearchTitle = true;
  bool isSearchDescription = false;
  bool isSearchPeople = false;
  bool isSearchFamilyRelation = false;
  bool isSearchIngredients = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void searchForRecipes() {
    widget.searchForRecipes(
        _searchController.text,
        isSearchTitle,
        isSearchDescription,
        isSearchPeople,
        isSearchFamilyRelation,
        isSearchIngredients);
  }

  void setSearchTitle(bool isChecked) {
    setState(() {
      isSearchTitle = isChecked;
    });
  }

  void setSearchDescription(bool isChecked) {
    setState(() {
      isSearchDescription = isChecked;
    });
  }

  void setSearchPeople(bool isChecked) {
    setState(() {
      isSearchPeople = isChecked;
    });
  }

  void setSearchFamilyRelation(bool isChecked) {
    setState(() {
      isSearchFamilyRelation = isChecked;
    });
  }

  void setSearchIngredients(bool isChecked) {
    setState(() {
      isSearchIngredients = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        color: Theme.of(context).primaryColor,
        height: (Platform.isIOS)
            ? ((showAdvanceMenu) ? 460 : 120)
            : ((showAdvanceMenu) ? 440 : 84),
        child: Column(children: [
          Padding(
              padding: (Platform.isIOS)
                  ? const EdgeInsets.fromLTRB(8, 44, 8, 8)
                  : const EdgeInsets.all(8),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                InkWell(
                  onTap: () {
                    searchForRecipes();
                  },
                  child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child: SizedBox(
                        height: 64,
                        width: 64,
                        child: Icon(
                          Icons.search_rounded,
                          size: 32,
                        ),
                      )),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
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
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      showAdvanceMenu = !showAdvanceMenu;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: SizedBox(
                        height: 64,
                        width: 64,
                        child: Icon(
                          (showAdvanceMenu)
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
                          size: 32,
                        ),
                      )),
                )
              ])),
          (showAdvanceMenu)
              ? AdvanceRecipeSearchCheckbox(
                  startSearchDescriptionChecked: isSearchDescription,
                  startSearchTitleChecked: isSearchTitle,
                  startSearchFamilyRelationChecked: isSearchFamilyRelation,
                  startSearchIngredientsChecked: isSearchIngredients,
                  startSearchPeopleChecked: isSearchPeople,
                  setSearchTitleChecked: (value) {
                    setSearchTitle(value);
                  },
                  setSearchDescriptionChecked: (value) {
                    setSearchDescription(value);
                  },
                  setSearchPeopleChecked: (value) {
                    setSearchPeople(value);
                  },
                  setSearchFamilyRelationChecked: (value) {
                    setSearchFamilyRelation(value);
                  },
                  setSearchIngredientsChecked: (value) {
                    setSearchIngredients(value);
                  })
              : Container(),
        ])));
  }
}
