import 'package:flutter/material.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          height: 10.0,
        ),
        Text(text),
      ],
    ),
  );
  showDialog(
    context: context,
    //allows that if user taps outside the dialog it will let or not let the user to do thid
    barrierDismissible: false,
    builder: (context) => dialog,
  );

  return () => Navigator.of(context).pop();
}
