import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:my_vender_app/utils/device/device_utiity.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import '../onboard_provider.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnBoardingController>(context,listen: false);
     final dark = myHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: myDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: mySizes.defaultSpace,
        child: SmoothPageIndicator(
          effect: ExpandingDotsEffect(
              activeDotColor: dark ? myColors.light : myColors.dark,
              dotHeight: 6),
          count: 3,
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
        ));
  }
}
