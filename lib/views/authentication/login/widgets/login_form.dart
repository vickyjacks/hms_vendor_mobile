import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_vender_app/utils/constants/navigate.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';
import 'package:my_vender_app/views/authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/toast/toaster.dart';
import '../../../../bottonsheet_screen.dart';
import '../../../../utils/constants/colors.dart';
import '../../password_configuration/ForgetPasswordScreen.dart';
import '../../signup/SignUpScreen.dart';

class myLoginForm extends StatelessWidget {
  const myLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProviders>(builder: (context, provider, child) {
      return Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: mySizes.spaceBtwSections,
          ),
          child: Column(
            children: [
              /// Email
              TextFormField(
                controller: provider.loginEmailController,
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: myTexts.email),
              ),
              const SizedBox(
                height: mySizes.spaceBtwInputFields,
              ),

              /// Password
              TextFormField(
                controller: provider.loginPasswordController,
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.password_check), suffixIcon: Icon(Iconsax.eye_slash), labelText: myTexts.password),
              ),
              const SizedBox(
                height: mySizes.spaceBtwInputFields / 2,
              ),

              /// remember me and forget password
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // remember me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(myTexts.rememberMe),
                  ],
                ),

                /// forget password
                TextButton(onPressed: () => materialPageRoute(context, ForgetPasswordScreen()), child: const Text(myTexts.forgetPassword)),
              ]),

              const SizedBox(
                height: mySizes.spaceBtwSections,
              ),

              /// Sign In Button
              SizedBox(
                  width: double.infinity,
                  child: provider.emailLoginLoading
                      ? Center(child: LoadingAnimationWidget.fallingDot(color: myColors.primary, size: 45))
                      : ElevatedButton(
                          // onPressed: () =>pushAndRemoveUntil(context, NavigationMenu()),
                          onPressed: () async {
                            if (provider.loginEmailController.text.isEmpty) {
                              Toast.showErrorToast(context, "please enter email id");
                            } else if (provider.loginPasswordController.text.isEmpty) {
                              Toast.showErrorToast(context, "please enter password");
                            } else {
                              var response = await provider.emailLoginApi();
                              // print("+++++++++login");
                              // log(response['code']);
                              // log(response['message']);
                              if (response['code'] == 200) {
                                if (context.mounted) {
                                  Toast.showSuccessToast(context, response['message']);
                                  provider.saveTokenLocally(response['data']['token']);
                                   materialPageRoute(context, const BottomSheetScreen());
                                }
                              } else {
                                if (context.mounted) Toast.showErrorToast(context, response['message']);
                              }
                            }
                          },
                          child: const Text(myTexts.signIn))),
              const SizedBox(
                height: mySizes.spaceBtwSections,
              ),

              /// create account button
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => materialPageRoute(context, SignUpScreen()), child: const Text(myTexts.createAccount))),

              const SizedBox(
                height: mySizes.spaceBtwSections,
              )
            ],
          ),
        ),
      );
    });
  }
}
