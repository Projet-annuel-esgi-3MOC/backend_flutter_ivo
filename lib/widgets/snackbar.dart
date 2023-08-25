import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);

  final snackBar = SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        scaffoldMessengerState.hideCurrentSnackBar();
      },
    ),
  );

  scaffoldMessengerState.showSnackBar(snackBar);
}
