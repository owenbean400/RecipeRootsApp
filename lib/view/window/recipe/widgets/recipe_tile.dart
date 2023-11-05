import 'package:flutter/material.dart';

class RecipeTile extends StatelessWidget {
  final int? id;
  final String title;
  final String personName;
  final String? familyRelation;
  final String description;
  final ValueSetter<int?> onTapRecipe;

  const RecipeTile(
      {super.key,
      required this.title,
      required this.personName,
      this.familyRelation,
      required this.description,
      this.id,
      required this.onTapRecipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTapRecipe(id);
        },
        child: Container(
            decoration: const BoxDecoration(
                border: Border(bottom: (BorderSide(color: Colors.grey)))),
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: SizedBox(
              height: 128,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 128,
                      width: MediaQuery.of(context).size.width - 140,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              Text(personName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodySmall),
                              (familyRelation != null)
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text("\"${familyRelation!}\"",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall))
                                  : Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 16, 0, 8),
                                      child: Container()),
                              Text(description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          )),
                    ),
                    Container(
                      width: 128,
                      height: 128,
                      color: Colors.grey,
                    )
                  ]),
            )));
  }
}
