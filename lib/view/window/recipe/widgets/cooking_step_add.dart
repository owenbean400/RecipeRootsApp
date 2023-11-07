import 'package:flutter/material.dart';

class CookingStepAdd extends StatelessWidget {
  final TextEditingController textController;
  final int step;
  final ValueSetter<int> isDelete;
  final double borderRadius = 8;

  const CookingStepAdd(
      {super.key,
      required this.textController,
      required this.step,
      required this.isDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Step ${step + 1}"),
          InkWell(
            onTap: () {
              isDelete(step);
            },
            child: const Text(
              "X",
              style: TextStyle(
                  color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold),
            ),
          )
        ]),
        TextField(
            controller: textController,
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Theme.of(context).hintColor,
              filled: true,
              focusColor: Theme.of(context).primaryColorLight,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide:
                    BorderSide(color: Theme.of(context).hintColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
            ))
      ],
    );
  }
}
