import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_vender_app/common/toast/toaster.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/colors.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';
import 'package:my_vender_app/views/authentication/login/LoginScreen.dart';
import 'package:my_vender_app/views/authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants/navigate.dart';

class MySignUpForm extends StatelessWidget {
  const MySignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = myHelperFunctions.isDarkMode(context);
    return Consumer<AuthenticationProviders>(builder: (context,provider,child){
      return Form(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: provider.registrationFirstNameController,
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: myTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
                const SizedBox(
                  width: mySizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: TextFormField(
                    controller: provider.registrationLastNameController,
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: myTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: mySizes.spaceBtwInputFields,
            ),

            /// mobile text field
            TextFormField(
              controller: provider.registrationMobileNoController,
              expands: false,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                labelText: myTexts.phoneNumber,
                prefixIcon: Icon(Iconsax.call),
              ),
            ),
            const SizedBox(
              height: mySizes.spaceBtwInputFields,
            ),

            /// Email testfield
            TextFormField(
              controller: provider.registrationEmailController,
              decoration: const InputDecoration(
                labelText: myTexts.email,
                prefixIcon: Icon(Iconsax.direct),
              ),
            ),


            const SizedBox(
              height: mySizes.spaceBtwInputFields,
            ),

            /// password textfield
            TextFormField(
              controller: provider.registrationPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: myTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
                prefixIcon: Icon(Iconsax.password_check),
              ),
            ),

            const SizedBox(
              height: mySizes.spaceBtwSections,
            ),

            /// Terms and conditions
            Row(
              children: [
                SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(value: true, onChanged: (value) {})),
                const SizedBox(
                  width: mySizes.spaceBtwItems,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '${myTexts.iAgreeTo}',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: myTexts.privacyPolicy,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? myColors.white : myColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                          dark ? myColors.white : myColors.primary)),
                  TextSpan(
                      text: '${myTexts.and}',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: myTexts.termsToUse,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? myColors.white : myColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                          dark ? myColors.white : myColors.primary)),
                ]))
              ],
            ),
            const SizedBox(
              height: mySizes.spaceBtwSections,
            ),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              child: provider.registrationLoading
                  ? Center(child: LoadingAnimationWidget.fallingDot(color: myColors.primary, size: 45))
                  :  ElevatedButton(
                onPressed: ()async{
                  if(provider.registrationMobileNoController.text.length!=10 ){
                    Toast.showErrorToast(context,"please enter the valid phone number");
                  }else if(provider.registrationEmailController.text==''){
                    Toast.showErrorToast(context,"please enter the valid email address");
                  }else if(provider.registrationPasswordController.text==''){
                    Toast.showErrorToast(context,"please enter the strong password");
                  }else{
                   var response = await provider.registrationApi();
                   if (response['code'] == 200) {
                     if (context.mounted) {
                       Toast.showSuccessToast(context, response['message']);
                       materialPageRoute(context, const LoginScreen());
                     }
                   } else {
                     if (context.mounted) Toast.showErrorToast(context, response['message']);
                   }
                  }
                },
                // onPressed: () => materialPageRoute(context, const VerfyEmailScreen()),
                child: const Text(myTexts.createAccount),
              ),
            ),
          ],
        ),
      );
    });
  }
}
