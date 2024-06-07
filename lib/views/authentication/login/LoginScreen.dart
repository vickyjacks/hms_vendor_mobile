import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vender_app/common/styles/spacing_style.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/colors.dart';
import 'package:my_vender_app/utils/constants/image_strings.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';
import 'package:my_vender_app/views/authentication/login/widgets/login_form.dart';
import 'package:my_vender_app/views/authentication/login/widgets/login_header.dart';
import 'package:my_vender_app/views/authentication/login/widgets/social_buttons.dart';
import '../../../../utils/constants/colors.dart';
import 'widgets/divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = myHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: mySpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// logo, title and subTitle
              myLoginHeader(dark: dark),

              /// Form
              const myLoginForm(),

              /// Divider
              myFormDivider(
                dark: dark,
                dividertext: myTexts.orSigninwith,
              ),
              const SizedBox(
                height: mySizes.spaceBtwSections,
              ),

              /// Footer
              const mySocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
