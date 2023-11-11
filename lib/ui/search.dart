import 'dart:async';

import 'package:flutter/material.dart';

Future<String?> showTextFieldDialog(BuildContext context) async {
  Completer<String?> completer = Completer();
  TextEditingController textFieldController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Enter city name'),
        content: TextField(
          controller: textFieldController,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String enteredText = textFieldController.text;
              Navigator.pop(context);
              completer.complete(enteredText);
              textFieldController.clear();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );

  return completer.future;
}

