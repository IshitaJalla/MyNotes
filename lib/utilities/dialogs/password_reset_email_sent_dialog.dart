import 'package:flutter/cupertino.dart';
import 'package:learningdart/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content: 'We have sent you a password reset link.Please check your email',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
