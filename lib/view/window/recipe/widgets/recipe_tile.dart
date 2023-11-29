import 'package:flutter/material.dart';

class RecipeTile extends StatelessWidget {
  final int? id;
  final String title;
  final String personName;
  final String? familyRelation;
  final bool? isBottomBorder;
  final String description;
  final String? imagePath;
  final ValueSetter<int?> onTapRecipe;

  const RecipeTile(
      {super.key,
      required this.title,
      required this.personName,
      this.familyRelation,
      required this.description,
      this.id,
      required this.onTapRecipe,
      this.isBottomBorder,
      this.imagePath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTapRecipe(id);
        },
        child: Container(
            decoration: BoxDecoration(
                border: (isBottomBorder ?? true)
                    ? const Border(bottom: (BorderSide(color: Colors.grey)))
                    : const Border()),
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: SizedBox(
              height: 128,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 128,
                      width: (imagePath != null)
                          ? MediaQuery.of(context).size.width - 140
                          : MediaQuery.of(context).size.width - 16,
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
                    (imagePath != null)
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                            child: Container(
                              width: 128,
                              height: 128,
                              color: Colors.grey,
                            ))
                        : Container()
                  ]),
            )));
  }
}
