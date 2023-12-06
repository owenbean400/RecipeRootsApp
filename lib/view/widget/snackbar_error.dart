import 'package:flutter/material.dart';

SnackBar getErrorSnackbar(String text, BuildContext context) {
  return SnackBar(
      backgroundColor: Theme.of(context).hintColor,
      content: Text(text,
          style: TextStyle(
            color: Colors.red.shade900,
            fontSize: 12,
          )),
      duration: const Duration(milliseconds: 4000),
      action: SnackBarAction(
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryColorDark,
        label: "OK",
        onPressed: () {},
      ));
}
