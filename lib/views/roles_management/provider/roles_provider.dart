import 'package:flutter/cupertino.dart';
import 'package:my_vender_app/services/api_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/fetch_roles_model.dart';
import '../model/roles_details_model_test.dart';

class RolesManagementProvider extends ChangeNotifier {
  final apiObj = ApiServices();

  bool _isLoading = false;

  get isLoading => _isLoading;

  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  final addRolesController = TextEditingController();

  /// add roles
  Future addRolesApi() async {
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> postData = {
        'roleName': addRolesController.text,
      };
      var response = await apiObj.postData(APIConstants.createRoles, postData);
      print("+++++25$response");
      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception("$e");
    }
  }

  ///fetch roles list
  List<FetchRolesListData> _getAllRolesList = <FetchRolesListData>[];

  set setAllRolesList(value) {
    _getAllRolesList = value;
    notifyListeners();
  }

  bool _fetchData = false;
  get fetchData => _fetchData;
  set fetchData(val) {
    _fetchData = val;
    notifyListeners();
  }
  get getAllRolesList => _getAllRolesList;
  Future getAllRolesListApi() async {
    _fetchData = true;
    notifyListeners();
    try {
      final response = await apiObj.getData(APIConstants.getRolesList);
      if (response['status'] == true) {
        var responseData = GetAllRolesListModel.fromMap(response);
        debugPrint("+++69 :: ${responseData.data}");
        _getAllRolesList = responseData.data;
        _fetchData = false;
        notifyListeners();
      }
    } on Exception catch (e) {
      _fetchData = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  /// fetch roles details
  GetRoleDetailModel? _roleDetailModelData;

  get roleDetailModelData => _roleDetailModelData;
  bool _fetchRollData = false;

  get fetchRollData => _fetchRollData;

  set fetchRollData(val) {
    _fetchRollData = val;
    notifyListeners();
  }

  Future getRolesDetailsApi(String roleID) async {
    _fetchRollData = true;
    notifyListeners();
    try {
      final response = await apiObj.putData("${APIConstants.getRolesDetails}/$roleID", {});
      debugPrint("+++++++44+$response");
      if (response['status'] == true) {
        _roleDetailModelData = GetRoleDetailModel.fromMap(response);
        debugPrint("+70++$_roleDetailModelData");
        _fetchRollData = false;
        notifyListeners();
      }
    } on Exception catch (e) {
      _fetchRollData = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  Future deletedRolesApi() async {
    try {
      final response = await apiObj.deleteData("ApiConstants.getAllRolesList");
      if (response['status'] == true) {
        var responseData = GetAllRolesListModel.fromMap(response);
        debugPrint("+++${responseData.data}");
        _getAllRolesList = responseData.data;
        notifyListeners();
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
