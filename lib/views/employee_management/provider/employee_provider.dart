import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../services/api_service.dart';
import '../../roles_management/model/fetch_roles_model.dart';
import '../model/get_employee_list_model.dart';

class EmployeeProvider with ChangeNotifier {
  final apiObj = ApiServices();
  final firstNameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final employeeIDController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  ///  staff roll id dropdown
  bool _fetchData = false;

  bool get fetchData => _fetchData;

  set fetchData(bool value) {
    _fetchData = value;
  }

  List _roles = [];
  List get roles => _roles;

  set roles(List value) {
    _roles = value;
    notifyListeners();
  }

  String? selectedRole;

  void setSelectedRole(String? role) {
    selectedRole = role;
    notifyListeners();
  }

  Future getRolesListApi() async {
    _fetchData = true;
    notifyListeners();
    try {
      final response = await apiObj.getData(APIConstants.getRolesList);
      if (response['status'] == true) {
        var responseData = GetAllRolesListModel.fromMap(response).data;
        debugPrint("+++69 :: ${responseData}");
        var data = responseData
            .map(
              (value) => {'id': value.id, 'name': value.roleName},
        )
            .toList();
        _roles = data;
        _fetchData = false;
        notifyListeners();
      }
    } on Exception catch (e) {
      _fetchData = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  /// add staff
  bool _addStaffLoading = false;

  bool get addStaffLoading => _addStaffLoading;

  set addStaffLoading(bool value) {
    _addStaffLoading = value;
  }

  Future addStaffApi() async {
    _addStaffLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> postData = {
        'firstName': firstNameController.text,
        'lastName': lastnameController.text,
        'email': emailController.text,
        'employeeId': employeeIDController.text,
        'mobile_no': phoneNumberController.text,
        'roleId': selectedRole.toString(),
        'password': passwordController.text,
      };
      var response = await apiObj.postData(APIConstants.createEmployee, postData);
      print("+++++91$response");
      _addStaffLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _addStaffLoading = false;
      notifyListeners();
      throw Exception("$e");
    }
  }

  /// update employee staff
  bool _updateStaffLoading = false;

  bool get updateStaffLoading => _updateStaffLoading;

  set updateStaffLoading(bool value) {
    _updateStaffLoading = value;
  }

  Future updateStaffApi(String id) async {
    _updateStaffLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> postData = {
        'firstName': firstNameController.text,
        'lastName': lastnameController.text,
        'email': emailController.text,
        'employeeId': employeeIDController.text,
        'mobile_no': phoneNumberController.text,
        'roleId': selectedRole.toString(),
        'password': "",
      };
      var response = await apiObj.putData("${APIConstants.updateEmployeeDetails}/$id", postData);
      print("+++++125$response");
      _updateStaffLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _updateStaffLoading = false;
      notifyListeners();
      throw Exception("$e");
    }
  }

  /// update the employee status

  bool _empStatus = false;

  bool get empStatus => _empStatus;

  set empStatus(bool value) {
    _empStatus = value;
  }

  bool _updateEmployeeStatusLoading = false;
  bool get updateEmployeeStatusLoading => _updateEmployeeStatusLoading;
  set updateEmployeeStatusLoading(bool value) {
    _updateEmployeeStatusLoading = value;
    notifyListeners();
  }

  Future updateEmployeeStatusApi(String id) async {
    _updateEmployeeStatusLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> postData = {};
      var response = await apiObj.putData("${APIConstants.updateEmployeeStatus}/$id", postData);
      print("+++++143$response");
      getAllEmployeeListApi();
      _updateEmployeeStatusLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _updateEmployeeStatusLoading = false;
      notifyListeners();
      throw Exception("$e");
    }
  }

  ///fetch roles list
  List<GetEmployeeData> _getAllEmployeeList = <GetEmployeeData>[];

  set setAllEmployeeList(value) {
    _getAllEmployeeList = value;
    notifyListeners();
  }

  get getAllEmployeeList => _getAllEmployeeList;

  Future getAllEmployeeListApi() async {
    _fetchData = true;
    notifyListeners();
    try {
      final response = await apiObj.getData(APIConstants.getEmployeeList);
      if (response['status'] == true) {
        var responseData = GetEmployeeList.fromMap(response);
        log("+++117 :: ${responseData.data}");
        // log("+++117 :: ${responseData.data["name"]}");
        // for (var employee in _getAllEmployeeList) {
        //   firstNameController.text = employee.name.split(' ')[0];
        //   lastnameController.text = employee.name.split(' ')[1];
        //   emailController.text = employee.email;
        //   employeeIDController.text = employee.employeeId;
        //   phoneNumberController.text = employee.mobile;
        //   passwordController.text = '';
        // }
        _getAllEmployeeList = responseData.data;
        _fetchData = false;
        notifyListeners();
      }
    } on Exception catch (e) {
      _fetchData = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  EmployeeStatus _status = EmployeeStatus(isActive: false);

  EmployeeStatus get status => _status;

  void toggleStatus() {
    _status = EmployeeStatus(isActive: !_status.isActive);
    notifyListeners();
  }
}

class EmployeeStatus {
  final bool isActive;

  EmployeeStatus({required this.isActive});
}
