import 'package:flutter/material.dart';

void materialPageRoute(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}


void pushAndRemoveUntil(BuildContext context, Widget page) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => page),
        (route) => false,
  );
}

replaceScreen(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}