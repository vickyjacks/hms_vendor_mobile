import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/colors.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';
import 'package:my_vender_app/views/authentication/signup/widgets/signupForm.dart';

import '../login/widgets/divider.dart';
import '../login/widgets/social_buttons.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = myHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(mySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                myTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: mySizes.spaceBtwSections,
              ),

              /// Form
              MySignUpForm(),

              SizedBox(
                height: mySizes.spaceBtwSections,
              ),

              /// Divider
              myFormDivider(
                dark: dark,
                dividertext: myTexts.orSignUpWith,
              ),

              SizedBox(
                height: mySizes.spaceBtwSections,
              ),

              /// Social Button
              mySocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
