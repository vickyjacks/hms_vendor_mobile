import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/api_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/fetch_city_list_model.dart';
import '../model/fetch_country_list_model.dart';
import '../model/fetch_details_model.dart';
import '../model/fetch_document_model.dart';
import '../model/fetch_hotel_list_model.dart';
import '../model/fetch_state_list_model.dart';
import '../model/fetch_submission_level_model.dart';
enum DocumentType { AadharFront, AadharBack, PanFront, PanBack,GstNumber,RegistrationNumber,BlankCheque }

class HotelsProvider extends ChangeNotifier {
  final apiObj = ApiServices();

  bool _allDataLoading = false;
  bool get allDataLoading => _allDataLoading;
  set allDataLoading(bool value) {
    _allDataLoading = value;
    notifyListeners();
  }

  loadAllApiFunction()async{
    _allDataLoading = true;
    notifyListeners();
    try{
      await fetchCountryListApi();
      // await fetchStateListApi();
      _allDataLoading = false;
      notifyListeners();
    }on Exception catch(e){
      _allDataLoading = false;
      notifyListeners();
     throw Exception(e.toString());
    }
  }

  final accountNumberController = TextEditingController();
  final confirmAccountNumberController = TextEditingController();
  final nameController = TextEditingController();
  final ifscCodeController = TextEditingController();

  final guardianNameController = TextEditingController();
  final relationshipWithGuardianController = TextEditingController();
  final phoneController = TextEditingController();
  final countrySearchController = TextEditingController();
  final stateSearchController = TextEditingController();
  final citySearchController = TextEditingController();
  final hotelNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final hotelAddressController = TextEditingController();
  final pinCodeController = TextEditingController();

  File? adharFrontImageFile;
  File? adharBackImageFile;
  File? panFrontImageFile;
  File? panBackImageFile;
  File? gstImageFile;
  File? registrationImageFile;
  File? blankChequeFile;

  final ImagePicker _picker = ImagePicker();

  /// upload document
  bool _documentUploadLoading = false;
  bool get documentUploadLoading => _documentUploadLoading;
  set documentUploadLoading(bool value) {
    _documentUploadLoading = value;
  }

  Future documentUploadDetailApi() async {
    _documentUploadLoading = true;
    notifyListeners();
    var documentDetails = [
      {
        'uploadKey': 'aadharCardFile',
        'documentPath': adharFrontImageFile?.path ?? ''
      },
      // {
      //   'uploadKey': 'aadhar_back_side',
      //   'documentPath': adharBackImageFile?.path ?? ''
      // },
      {'uploadKey': 'panCardFile',
        'documentPath': panFrontImageFile?.path ?? ''
      }
    ];
    Map<String, String> postData = {
      "bankAccountNo": accountNumberController.text,
      'bankAccountHolder': nameController.text,
      'ifscCode': ifscCodeController.text,
      'gurdianName': guardianNameController.text,
      'relationShip': relationshipWithGuardianController.text,
      'gurdianMobileNo': phoneController.text
    };

    print("++++++++59");
    print(postData);
    print(documentDetails);
    try {
      var response = await apiObj.uploadDocumentsAndPostApi(
          apiUrl: "documents",
          documentDetails: documentDetails,
          postData: postData);

      _documentUploadLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _documentUploadLoading = false;
      notifyListeners();
      throw Exception("$e");
    }

  }





  Future getImage(DocumentType documentType, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _setImageFile(documentType, File(pickedFile.path));
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  void removeImage(DocumentType documentType) {
    _setImageFile(documentType, null);
    notifyListeners();
  }

  void _setImageFile(DocumentType documentType, File? file) {
    switch (documentType) {
      case DocumentType.AadharFront:
        adharFrontImageFile = file;
        notifyListeners();
        break;
      case DocumentType.AadharBack:
        adharBackImageFile = file;
        notifyListeners();
        break;
      case DocumentType.PanFront:
        panFrontImageFile = file;
        notifyListeners();
        break;
      case DocumentType.PanBack:
        panBackImageFile = file;
        notifyListeners();
        break;
      case DocumentType.GstNumber:
        gstImageFile = file;
        notifyListeners();
        break;
      case DocumentType.RegistrationNumber:
        registrationImageFile = file;
        notifyListeners();
        break;
      case DocumentType.BlankCheque:
        blankChequeFile = file;
        notifyListeners();
        break;
    }
  }

  Future<void> showImageSourceDialog(BuildContext context, DocumentType documentType) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  getImage(documentType, ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  getImage(documentType, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static const list = [
    'Pakistani',
    'Indian',
    'Middle Eastern',
    'Western',
    'Chinese',
    'Italian',
  ];

  /// fetch country list

  bool  _countryLoading = false;
  bool get countryLoading => _countryLoading;
  set countryLoading(bool value) {
    _countryLoading = value;
    notifyListeners();
  }
  String _selectedCountryId =  '';
  String get selectedCountryId => _selectedCountryId;
  set selectedCountryId(String value) {
    print("++++++++++226$value");
    _selectedCountryId = value;
    notifyListeners();
  }
  bool _countryReadOnly = false;
  bool get countryReadOnly => _countryReadOnly;
  set countryReadOnly(bool value) {
    _countryReadOnly = value;
    notifyListeners();
  }
  FetchCountryModel _fetchCountryModel = FetchCountryModel();
  FetchCountryModel get fetchCountryModel => _fetchCountryModel;
  set fetchCountryModel(FetchCountryModel value) {
    _fetchCountryModel = value;
  }
  Future fetchCountryListApi()async{
    _countryLoading=true;
    try{
      final response = await apiObj.getData(APIConstants.getCountryList);
      log("response----200---${response}");
      if(response["status"]==true){
        _fetchCountryModel=FetchCountryModel.fromMap(response);
        log("response----204---${_fetchCountryModel.data}");
        _countryLoading=false;
        notifyListeners();
      }
    }on Exception catch (e){
      _countryLoading=false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  /// fetch state list

  bool _stateLoading = false;
  bool get stateLoading => _stateLoading;
  set stateLoading(bool value) {
    _stateLoading = value;
    notifyListeners();
  }
  String _selectedStatusId =  '';
  String get selectedStatusId => _selectedStatusId;
  set selectedStatusId(String value) {
    _selectedStatusId = value;
    notifyListeners();
  }
  FetchStateModel _fetchStateModel = FetchStateModel();
  FetchStateModel get fetchStateModel => _fetchStateModel;
  set fetchStateModel(FetchStateModel value) {
    _fetchStateModel = value;
    notifyListeners();
  }
  Future fetchStateListApi()async{
    _stateLoading=true;
    try{
      final response = await apiObj.getData("${APIConstants.getStateList}?country=$_selectedCountryId");
      log("response----265---$response");
      if(response["status"]==true){
        _fetchStateModel=FetchStateModel.fromMap(response);
        log("response----292---${_fetchStateModel.data}");
        _stateLoading=false;
        notifyListeners();
      }
    }on Exception catch (e){
      _stateLoading=false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  /// fetch city list

  bool _cityLoading = false;
  bool get cityLoading => _cityLoading;
  set cityLoading(bool value) {
    _cityLoading = value;
    notifyListeners();
  }
  FetchCityModel _fetchCityModel = FetchCityModel();
  FetchCityModel get fetchCityModel => _fetchCityModel;
  set fetchCityModel(FetchCityModel value) {
    _fetchCityModel = value;
    notifyListeners();
  }
  bool _cityReadOnly = false;
  bool get cityReadOnly => _cityReadOnly;
  set cityReadOnly(bool value) {
    _cityReadOnly = value;
    notifyListeners();
  }
  String _selectedCityId =  '';
  String get selectedCityId => _selectedCityId;
  set selectedCityId(String value) {
    _selectedCityId = value;
    notifyListeners();
  }

  Future fetchCityListApi()async{
    _cityLoading=true;
    try{
      final response = await apiObj.getData("${APIConstants.getCityList}?stateId=$_selectedStatusId");
      log("response----323---$response");
      if(response["status"]==true){
        _fetchCityModel=FetchCityModel.fromMap(response);
        log("response----326---${_fetchCityModel.data}");
        _cityLoading=false;
        notifyListeners();
      }
    }on Exception catch (e){
      _cityLoading=false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  /// add hotel details

  bool _addHotelLoading = false;
  bool get addHotelLoading => _addHotelLoading;
  set addHotelLoading(bool value) {
    _addHotelLoading = value;
    notifyListeners();
  }

  Future addHotelDetailsApi()async{
    _addHotelLoading = true;
    notifyListeners();
    try{
      Map<String, dynamic> postData = {
        "hotelName": hotelNameController.text,
        "hotelEmail": emailController.text,
        "hotelMobile":phoneController.text,
        "hotelAddress": hotelAddressController.text,
        "hotelPincode": pinCodeController.text,
        "hotelCountry": _selectedCountryId,
        "hotelState":_selectedStatusId,
        "hotelCity": _selectedCityId
      };
      final response = await apiObj.postData("hotels/${APIConstants.addHotelDetail}", postData);
      print("++++++++postData $postData");
      print("++++++++response $response");
      _addHotelLoading = false;
      notifyListeners();
      return response;

    }on Exception catch(e){
      _addHotelLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
}

  bool _uploadDocumentLoading = false;
  bool get uploadDocumentLoading => _uploadDocumentLoading;
  set uploadDocumentLoading(bool value) {
    _uploadDocumentLoading = value;
    notifyListeners();
  }

  Future uploadHotelDocumentApi() async{
    _uploadDocumentLoading = true;
    try{
      var data  = [
        {"key":"pancard","value":panCardDoc?.files.single.path ?? ''},
        {"key":"hotelsRegistration","value":registrationDoc?.files.single.path ?? ''},
        {"key":"blankCheck","value":blankChequeDoc?.files.single.path ?? ''},
      ];
      final response = await apiObj.uploadFileApi(data: data,endPoint: "hotels/${APIConstants.addHotelDocument}");
    print("+++++++400");
      _uploadDocumentLoading = false;
      notifyListeners();
      return response;
    }catch(e){
      _uploadDocumentLoading = false;
      notifyListeners();
      throw Exception(e);
    }
  }

  String _selectedCountry = '';

  String get selectedCountry => _selectedCountry;

  set selectedCountry(String value) {
    print("+++++++416$value");
    _selectedCountry = value;
    notifyListeners();
  }

  String _selectedState = '';

  String get selectedState => _selectedState;

  set selectedState(String value) {
    _selectedState = value;
    notifyListeners();
  }

  String _selectedCity = '';

  String get selectedCity => _selectedCity;

  set selectedCity(String value) {
    _selectedCity = value;
    notifyListeners();
  }

  bool _documentList = false;

  bool get documentList => _documentList;

  set documentList(bool value) {
    _documentList = value;
    notifyListeners();
  }

  FilePickerResult? _panCardDoc;


  FilePickerResult? get panCardDoc => _panCardDoc;

  set panCardDoc(FilePickerResult? value) {
    _panCardDoc = value;
    notifyListeners();
  }

  FilePickerResult? _registrationDoc;


  FilePickerResult? get registrationDoc => _registrationDoc;

  set registrationDoc(FilePickerResult? value) {
    _registrationDoc = value;
    notifyListeners();
  }

  FilePickerResult? _blankChequeDoc;

  FilePickerResult? get blankChequeDoc => _blankChequeDoc;

  set blankChequeDoc(FilePickerResult? value) {
    _blankChequeDoc = value;
    notifyListeners();
  }

  /// load all hotel list api

  bool _loadHotelListScreenApiLoading = false;
  bool get loadHotelListScreenApiLoading => _loadHotelListScreenApiLoading;
  set loadHotelListScreenApiLoading(bool value) {
    _loadHotelListScreenApiLoading = value;
    notifyListeners();
  }

  loadHotelListScreenGetApi()async{
    _loadHotelListScreenApiLoading = true;
    notifyListeners();
    try{
      await hotelListDataApi();
      await fetchSubmissionLevelApi();
      _loadHotelListScreenApiLoading = false;
      notifyListeners();
    }on Exception catch(e){
      _loadHotelListScreenApiLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  
  /// fetch hotel list data

  FetchHotelListModel _hotelListModel = FetchHotelListModel();
  FetchHotelListModel get hotelListModel => _hotelListModel;
  set hotelListModel(FetchHotelListModel value) {
    _hotelListModel = value;
    notifyListeners();
  }

  bool _fetchHotelLoading = false;
  bool get fetchHotelLoading => _fetchHotelLoading;
  set fetchHotelLoading(bool value) {
    _fetchHotelLoading = value;
    notifyListeners();
  }

  Future hotelListDataApi()async{
    _fetchHotelLoading = true;
    notifyListeners();
    try{
      final response = await apiObj.getData("hotels/${APIConstants.fetchHotelList}");
      debugPrint("fetch hotel list :: ${response}");
      _hotelListModel = FetchHotelListModel.fromMap(response);
      _fetchHotelLoading = false;
      notifyListeners();
    }on Exception catch(e){
      _fetchHotelLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
 } 


 /// fetch submission level api

  bool _fetchSubmissionLoading = false;
  bool get fetchSubmissionLoading => _fetchSubmissionLoading;
  set fetchSubmissionLoading(bool value) {
    _fetchSubmissionLoading = value;
    notifyListeners();
  }

  FetchSubmissionLevelModel _submissionLevelModel = FetchSubmissionLevelModel();
  FetchSubmissionLevelModel get submissionLevelModel => _submissionLevelModel;
  set submissionLevelModel(FetchSubmissionLevelModel value) {
    _submissionLevelModel = value;
    notifyListeners();
  }

  Future fetchSubmissionLevelApi()async{
    _fetchSubmissionLoading = true;
    notifyListeners();
    try{
      final response = await apiObj.getData("hotels/${APIConstants.submissionLevel}");
      print("++++++++++538 ${response} ");
      _submissionLevelModel = FetchSubmissionLevelModel.fromMap(response);
      _fetchSubmissionLoading = false;
      notifyListeners();
      return response;
      
    }on Exception catch(e){
      _fetchSubmissionLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }


  /// load hotel details screen api

  bool _loadHotelDetailsScreenGetApiLoading = false;
  bool get loadHotelDetailsScreenGetApiLoading => _loadHotelDetailsScreenGetApiLoading;
  set loadHotelDetailsScreenGetApiLoading(bool value) {
    _loadHotelDetailsScreenGetApiLoading = value;
    notifyListeners();
  }

  loadHotelDetailsScreenGetApi(String bookingId)async{
    _loadHotelDetailsScreenGetApiLoading = true;
    notifyListeners();
    try{
      await fetchHotelDocumentApi(bookingId);
      await fetchHotelDetailApi(bookingId);
      _loadHotelDetailsScreenGetApiLoading = false;
      notifyListeners();
    }on Exception catch(e){
      _loadHotelDetailsScreenGetApiLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }
  /// fetch hotel document

  bool _fetchHotelDocumentLoading = false;
  bool get fetchHotelDocumentLoading => _fetchHotelDocumentLoading;
  set fetchHotelDocumentLoading(bool value) {
    _fetchHotelDocumentLoading = value;
    notifyListeners();
  }

  GetDocumentModel _getDocumentModel = GetDocumentModel();
  GetDocumentModel get getDocumentModel => _getDocumentModel;
  set getDocumentModel(GetDocumentModel value) {
    _getDocumentModel = value;
    notifyListeners();
  }

  Future fetchHotelDocumentApi(String bookingId)async{
    _fetchHotelDocumentLoading = true;
    try{
      final response = await apiObj.getData("hotels/${APIConstants.fetchHotelDocument}/$bookingId");
      print("Fetch Hotel Document ::  $response");
      _getDocumentModel = GetDocumentModel.fromMap(response);
      _fetchHotelDocumentLoading = false;
      notifyListeners();
    }on Exception catch(e){
      _fetchHotelDocumentLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }
  /// fetch hotel details

  bool _fetchHotelDetailLoading = false;
  bool get fetchHotelDetailLoading => _fetchHotelDetailLoading;
  set fetchHotelDetailLoading(bool value) {
    _fetchHotelDetailLoading = value;
    notifyListeners();
  }

  GetDetailModel _getDetailModel = GetDetailModel();
  GetDetailModel get getDetailModel => _getDetailModel;
  set getDetailModel(GetDetailModel value) {
    _getDetailModel = value;
    notifyListeners();
  }

  Future fetchHotelDetailApi(String bookingId)async{
    _fetchHotelDetailLoading = true;
    try{
      final response = await apiObj.getData("hotels/${APIConstants.fetchHotelDetail}/$bookingId");
      debugPrint("Fetch Hotel Details ::  $response");
      _getDetailModel = GetDetailModel.fromMap(response);
      log("+++++++line number 644  ${_getDetailModel.data}");
      hotelNameController.text =_getDetailModel.data!.hotelName;
      emailController.text =_getDetailModel.data!.hotelEmail;
      phoneController.text =_getDetailModel.data!.hotelMobile;
      hotelAddressController.text =_getDetailModel.data!.hotelAddress;
      pinCodeController.text =_getDetailModel.data!.hotelPincode;
      // countrySearchController.text =_getDetailModel.data!.c;
      _fetchHotelDetailLoading = false;
      notifyListeners();
    }on Exception catch(e){
      _fetchHotelDetailLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }


  /// update hotel details data

  bool _updateHotelLoading = false;
  bool get updateHotelLoading => _updateHotelLoading;
  set updateHotelLoading(bool value) {
    _updateHotelLoading = value;
    notifyListeners();
  }

  Future updateHotelDetailsApi()async{
    _updateHotelLoading = true;
    notifyListeners();
    try{
      Map<String, dynamic> postData = {
        "hotelName": hotelNameController.text,
        "hotelEmail": emailController.text,
        "hotelMobile":phoneController.text,
        "hotelAddress": hotelAddressController.text,
        "hotelPincode": pinCodeController.text,
        "hotelCountry": "101",
        "hotelState":"1",
        "hotelCity": "1"
      };
      final response = await apiObj.putData("hotels/${APIConstants.updateHotelDetail}/${_getDetailModel.data!.hotelId}", postData);
      print("++++++++postData685 $postData");
      print("++++++++response686 $response");
      _updateHotelLoading = false;
      notifyListeners();
      return response;

    }on Exception catch(e){
      _updateHotelLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  /// update hotel document

  bool _updateDocumentLoading = false;
  bool get updateDocumentLoading => _updateDocumentLoading;
  set updateDocumentLoading(bool value) {
    _updateDocumentLoading = value;
    notifyListeners();
  }


  Future updateHotelDocumentApi() async {
    _updateDocumentLoading = true;
    try {
      List<Map<String, dynamic>> data = [];

      if (panCardDoc != null && panCardDoc!.files.isNotEmpty && panCardDoc!.files.single.path!.isNotEmpty) {
        data.add({"key": "pancard", "value": panCardDoc!.files.single.path});
      }
      if (registrationDoc != null && registrationDoc!.files.isNotEmpty && registrationDoc!.files.single.path!.isNotEmpty) {
        data.add({"key": "hotelsRegistration", "value": registrationDoc!.files.single.path});
      }
      if (blankChequeDoc != null && blankChequeDoc!.files.isNotEmpty && blankChequeDoc!.files.single.path!.isNotEmpty) {
        data.add({"key": "blankCheck", "value": blankChequeDoc!.files.single.path});
      }

      final response = await apiObj.uploadFileApis(
        data: data,
        endPoint: "hotels/${APIConstants.updateHotelDocument}/${_getDetailModel.data!.hotelId}",
      );
      print("+++++++7165");
      print(data);
      _updateDocumentLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _updateDocumentLoading = false;
      notifyListeners();
      throw Exception(e);
    }
  }


  // Future updateHotelDocumentApi() async{
  //   _updateDocumentLoading = true;
  //   try{
  //     var data  = [
  //       {"key":"pancard","value":panCardDoc?.files.single.path ?? ''},
  //       {"key":"hotelsRegistration","value":registrationDoc?.files.single.path ?? ''},
  //       {"key":"blankCheck","value":blankChequeDoc?.files.single.path ?? ''},
  //     ];
  //     final response = await apiObj.uploadFileApi(data: data,endPoint: "hotels/${APIConstants.updateHotelDocument}/${_getDetailModel.data!.hotelId}");
  //     print("+++++++7165");
  //     print(data);
  //     _updateDocumentLoading = false;
  //     notifyListeners();
  //     return response;
  //   }catch(e){
  //     _updateDocumentLoading = false;
  //     notifyListeners();
  //     throw Exception(e);
  //   }
  // }


  /// pic pan card
  Future<void> pickPanCardFiles({required HotelsProvider provider}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result != null) {
          provider.panCardDoc = result;
       notifyListeners();

        print("selectedDocument---${provider.panCardDoc}");
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }


}
