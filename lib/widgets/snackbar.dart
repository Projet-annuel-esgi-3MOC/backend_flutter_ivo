import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessengerState _scaffoldMessengerState =
      ScaffoldMessenger.of(context);

  final snackBar = SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        _scaffoldMessengerState.hideCurrentSnackBar();
      },
    ),
  );

  _scaffoldMessengerState.showSnackBar(snackBar);
}
