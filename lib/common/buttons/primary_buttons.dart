
import '../../../../utils/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButtons extends StatelessWidget {
  final void Function() onPressed;
  String title;
  double height;
  double width;

  PrimaryButtons(
      {super.key, required this.onPressed,
        required this.title,
        required this.height,
        required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 10),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: myColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                   ),
            ),
          ),
        ),
      ),
    );
  }
}