import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toast{
  static showSuccessToast(BuildContext context,String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: CupertinoColors.systemGreen,
        elevation: 3.0,
        closeIconColor: CupertinoColors.white,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  static showErrorToast(BuildContext context,String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: CupertinoColors.destructiveRed,
        elevation: 3.0,
        closeIconColor: CupertinoColors.white,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }



}