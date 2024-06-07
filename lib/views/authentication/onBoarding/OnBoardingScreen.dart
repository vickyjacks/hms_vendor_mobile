import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_vender_app/views/authentication/onBoarding/widgets/onboarding_dot_navigation.dart';
import 'package:my_vender_app/views/authentication/onBoarding/widgets/onboarding_next_page_button.dart';
import 'package:my_vender_app/views/authentication/onBoarding/widgets/onboarding_page.dart';
import 'package:my_vender_app/views/authentication/onBoarding/widgets/onboarding_skip_button.dart';
import 'package:provider/provider.dart';
 import 'package:my_vender_app/utils/constants/image_strings.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:my_vender_app/utils/device/device_utiity.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import 'onboard_provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnBoardingController>(context,listen: false);
    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scrollable Pages
          PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const [
                OnBoardingPage(
                  image: myImages.onBoardingImage1,
                  title: myTexts.onBoardingTitle1,
                  subtitle: myTexts.onBoardingSubTitle1,
                ),
                OnBoardingPage(
                  image: myImages.onBoardingImage2,
                  title: myTexts.onBoardingTitle2,
                  subtitle: myTexts.onBoardingSubTitle2,
                ),
                OnBoardingPage(
                  image: myImages.onBoardingImage3,
                  title: myTexts.onBoardingTitle3,
                  subtitle: myTexts.onBoardingSubTitle3,
                ),
              ]),

          //skip button
          const OnBoardingSkipButton(),

          // smooth page indicator
          const OnBoardingDotNavigation(),

          // circular button
          const OnBoardingNextPageButton(),
        ],
      ),
    );
  }
}
