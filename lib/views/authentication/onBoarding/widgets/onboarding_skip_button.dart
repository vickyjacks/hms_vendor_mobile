
import 'package:flutter/material.dart';
import 'package:my_vender_app/utils/device/device_utiity.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import 'package:provider/provider.dart';

import '../onboard_provider.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnBoardingController>(context,listen: false);
    return Positioned(
        top: myDeviceUtils.getAppBarHeight(),
        right: mySizes.defaultSpace,
        child: TextButton(
          onPressed: () => controller.skipPage(),
          child: Text("Skip"),
        ));
  }
}
