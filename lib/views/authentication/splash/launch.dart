import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_vender_app/views/authentication/onBoarding/OnBoardingScreen.dart';
import 'package:my_vender_app/views/authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/loader/animation_loader.dart';
import '../../../bottonsheet_screen.dart';
import '../login/LoginScreen.dart';

class AppLaunch extends StatelessWidget {
  const AppLaunch({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationProviders>(context, listen: false);
    return FutureBuilder(
      future: auth.isFirstTime(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoaderWidget());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          bool isFirstTime = snapshot.data!;
          if (isFirstTime) {
            if (kDebugMode) {
              print("Already in app launch24  $isFirstTime");
            }
            auth.setAppOpened();
            return const OnBoardingScreen();
          } else {
            if (kDebugMode) {
              print("Already in app launch  ${auth.alreadyLogin}");
            }
            if (auth.alreadyLogin) {
              return const BottomSheetScreen();
            } else {
              return const LoginScreen();

            }
          }
        }
      },
    );
  }
}
