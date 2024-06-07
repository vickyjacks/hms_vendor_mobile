import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_vender_app/utils/constants/colors.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = myHelperFunctions.isDarkMode(context);
    return LoadingAnimationWidget.fallingDot(color: darkMode ? Colors.white : Colors.black, size: 45);
  }
}
