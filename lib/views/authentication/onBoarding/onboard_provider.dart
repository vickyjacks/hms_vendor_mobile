import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_vender_app/utils/constants/navigate.dart';
import 'package:my_vender_app/views/booking/booking_screen.dart';
import 'package:my_vender_app/views/dashboard/dashboard_screen.dart';
import 'package:my_vender_app/views/earnings/earning_screen.dart';
import 'package:my_vender_app/views/profile/profile_screen.dart';

import '../login/LoginScreen.dart';

class OnBoardingController extends ChangeNotifier {
  //variable
  final PageController pageController = PageController();
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  // update current index when page scrolls
  void updatePageIndicator(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  //Jump to specific dot selected page
  void dotNavigationClick(int index) {
    _currentPageIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  //update current index and jump to next page
  void nextPage(context) {
    if (_currentPageIndex == 2) {
      materialPageRoute(context, LoginScreen());
      // Implement navigation to login screen here
    } else {
      _currentPageIndex += 1;
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      notifyListeners();
    }
  }

  //update current index and jump to last page
  void skipPage() {
    _currentPageIndex = 2;
    pageController.jumpToPage(2);
    notifyListeners();
    // Implement navigation to login screen here
  }


  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  final List<Widget> screens = [
    const DashBoardScreen(),
    const BookingScreen(),
    const EarningScreen(),
    const ProfileScreen(),
  ];

}
