import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_vender_app/views/authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/image_strings.dart';
import 'package:my_vender_app/utils/constants/colors.dart';
import '../../../utils/constants/navigate.dart';
import 'launch.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<AuthenticationProviders>(context, listen: false).gettingId();
    Timer(const Duration(seconds: 3), () {
      pushAndRemoveUntil(context, const AppLaunch());
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final dark = myHelperFunctions.isDarkMode(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height/2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image(
                          height: 150,
                          image: AssetImage(
                              dark ? myImages.lightAppLogo : myImages.darkAppLogo)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: height/2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.newtonCradle(color: myColors.black, size:200),
                    ],
                  ))
            ],
          ),
        )
    );
  }
}
