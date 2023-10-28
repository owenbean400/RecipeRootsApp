import 'package:flutter/material.dart';
import 'package:recipe_roots/view/window/recipe/widgets/advance_recipe_search_checkbox.dart';

class RecipeSearchBar extends StatefulWidget {
  const RecipeSearchBar({Key? key}) : super(key: key);

  @override
  RecipeSearchBarState createState() => RecipeSearchBarState();
}

class RecipeSearchBarState extends State<RecipeSearchBar> {
  late TextEditingController _searchController;
  bool showAdvanceMenu = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        color: Theme.of(context).primaryColor,
        height: (showAdvanceMenu) ? 440 : 84,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                InkWell(
                  onTap: () {},
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
              ? const AdvanceRecipeSearchCheckbox(
                  startSearchDescriptionChecked: false,
                  startSearchTitleChecked: false,
                  startSearchFamilyRelationChecked: false,
                  startSearchIngredientsChecked: false,
                  startSearchPeopleChecked: false)
              : Container(),
        ])));
  }
}
