
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_vender_app/views/authentication/onBoarding/OnBoardingScreen.dart';
import 'package:my_vender_app/views/authentication/onBoarding/onboard_provider.dart';
import 'package:my_vender_app/views/authentication/provider/auth_provider.dart';
import 'package:my_vender_app/views/authentication/splash/splash_screen.dart';
import 'package:my_vender_app/views/employee_management/provider/employee_provider.dart';
import 'package:my_vender_app/views/hotel_management/provider/hotel_provider.dart';
import 'package:my_vender_app/views/roles_management/provider/roles_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_vender_app/utils/Theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnBoardingController()),
        ChangeNotifierProvider(create: (_) => AuthenticationProviders()),
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
        ChangeNotifierProvider(create: (_) => RolesManagementProvider()),
        ChangeNotifierProvider(create: (_) => HotelsProvider()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: myAppTheme.lightTheme,
        darkTheme: myAppTheme.darkTheme,
        // home: const OnBoardingScreen(),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: true,
      ),
    );
  }
}
