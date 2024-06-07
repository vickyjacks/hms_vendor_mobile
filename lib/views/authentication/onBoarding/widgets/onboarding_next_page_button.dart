import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:my_vender_app/utils/device/device_utiity.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/colors.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import '../onboard_provider.dart';

class OnBoardingNextPageButton extends StatelessWidget {
  const OnBoardingNextPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnBoardingController>(context,listen: false);
    final dark = myHelperFunctions.isDarkMode(context);
    return Positioned(
        right: mySizes.defaultSpace,
        bottom: myDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
          onPressed: () => controller.nextPage(context),
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: dark ? myColors.primary : myColors.dark),
          child: const Icon(Iconsax.arrow_right_3),
        ));
  }
}
