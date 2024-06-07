import 'package:flutter/material.dart';
import 'package:my_vender_app/views/authentication/onBoarding/onboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = myHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Consumer<OnBoardingController>(
        builder: (context, controller, _) => NavigationBar(
          elevation: 0,
          height: 80,
          selectedIndex: controller.selectedIndex,
          onDestinationSelected: (index) =>
          controller.selectedIndex = index,
          backgroundColor: darkMode ? Colors.black : Colors.white,
          indicatorColor: darkMode
              ? Colors.white.withOpacity(0.3)
              : Colors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home_trend_down), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.book4), label: "Booking"),
            NavigationDestination(icon: Icon(Iconsax.image), label: "Rooms"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
      body: Consumer<OnBoardingController>(
        builder: (context, controller, _) => controller.screens[controller.selectedIndex],
      ),
    );
  }
}


