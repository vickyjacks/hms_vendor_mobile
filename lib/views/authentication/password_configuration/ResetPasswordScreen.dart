import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_vender_app/utils/constants/navigate.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/image_strings.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';

import '../login/LoginScreen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(mySizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Lottie.asset(
                myImages.restPasswordImage,
                width: myHelperFunctions.screenWidth(context) * 0.8,
              ),
              const SizedBox(
                height: mySizes.spaceBtwSections,
              ),

              /// Title and button
              Text(
                myTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: mySizes.spaceBtwItems,
              ),
              Text(
                myTexts.resetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: mySizes.spaceBtwSections,
              ),

              /// buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => materialPageRoute(context, LoginScreen()),
                  child: const Text(
                    myTexts.done,
                  ),
                ),
              ),
              const SizedBox(
                height: mySizes.spaceBtwSections,
              ),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    myTexts.resendEmail,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
