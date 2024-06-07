
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:my_vender_app/common/toast/toaster.dart';
import 'package:my_vender_app/views/authentication/login/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/navigate.dart';

class AuthenticationProviders extends ChangeNotifier{
  final apiObj = ApiServices();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registrationFirstNameController = TextEditingController();
  final registrationLastNameController = TextEditingController();
  final registrationEmailController = TextEditingController();
  final registrationMobileNoController = TextEditingController();
  final registrationPasswordController = TextEditingController();



  ///@ email login
  bool _emailLoginLoading = false;
  bool get emailLoginLoading => _emailLoginLoading;
  set emailLoginLoading(bool value) {
    _emailLoginLoading = value;
  }
  Future emailLoginApi() async {
    _emailLoginLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> postData = {
        'vendor_profile_id': loginEmailController.text,
        'password': loginPasswordController.text,
        // Add more key-value pairs as needed
      };
      var response =
      await apiObj.postData(APIConstants.emailLogin, postData);
      _emailLoginLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _emailLoginLoading = false;
      notifyListeners();
      throw Exception("$e");
    }
  }

  ///@ registration


  bool _registrationLoading = false;
  bool get registrationLoading => _registrationLoading;
  set registrationLoading(bool value) {
    _registrationLoading = value;
  }

  Future registrationApi() async {
    _registrationLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> postData = {
        // 'firstName': registrationFirstNameController.text,
        // 'lastName': registrationLastNameController.text,
        'email': registrationEmailController.text,
        'mobile_no': registrationMobileNoController.text,
        'password': registrationPasswordController.text,
        // Add more key-value pairs as needed
      };
      var response =
      await apiObj.postData(APIConstants.venderRegistration, postData);
      _registrationLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _registrationLoading = false;
      notifyListeners();
      throw Exception("$e");
    }
  }

  ///@ launching App First time
  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;
    return isFirstTime;
  }

  ///@ save userId locally
  Future<void> saveTokenLocally(String value) async {
    authToken = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value);
  }

  ///@ App open before
  void setAppOpened() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_time', false);
  }
  ///@ already login
  bool alreadyLogin = false;
  gettingId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await loadToken();
    authToken = prefs.getString("token")!;
    if (kDebugMode) {
      print("Token :: ${prefs.getString("token")}");
    }
    if (prefs.getString("token") != null || prefs.getString("token") == 'null' || prefs.getString("token") == '') {
      alreadyLogin = true;
      notifyListeners();
    }
  }
  ///@ load userId
  Future<String?> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  ///@ clear userId
  void clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }
  ///@ log out user
  bool isLogout = false;
  logOut(BuildContext context) async {
    isLogout = true;
    notifyListeners();
    clearToken();
    var userId = await loadToken();
    isLogout = false;
    notifyListeners();
    if (userId == null) {
      if (context.mounted) {
        Toast.showSuccessToast(context,"Logout successfully");
        materialPageRoute(context, const LoginScreen());
      }
    }
  }
}