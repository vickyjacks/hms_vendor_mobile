import 'package:flutter/cupertino.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';

class mySpacingStyle {
  static EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: mySizes.appBarHeight,
    left: mySizes.defaultSpace,
    bottom: mySizes.defaultSpace,
    right: mySizes.defaultSpace,
  );
}
