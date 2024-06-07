import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(mySizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: mySizes.defaultSpace * 5,
            ),
            Lottie.asset(image,
                width: myHelperFunctions.screenWidth(context) * 0.9,
                height: myHelperFunctions.screenWidth(context) * 0.8),
            const SizedBox(
              height: mySizes.spaceBtwSections - 20,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: mySizes.spaceBtwItems),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
