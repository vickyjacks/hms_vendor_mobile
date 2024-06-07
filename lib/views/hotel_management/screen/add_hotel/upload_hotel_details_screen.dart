 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:my_vender_app/common/loader/animation_loader.dart';
import 'package:my_vender_app/common/toast/toaster.dart';
import 'package:my_vender_app/utils/constants/navigate.dart';
import 'package:my_vender_app/views/hotel_management/provider/hotel_provider.dart';
import 'package:my_vender_app/views/hotel_management/screen/add_hotel/upload_document_screen.dart';
import 'package:my_vender_app/views/hotel_management/screen/hotels_management_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';
import '../../../../../common/dimention/dimention_screen.dart';
import '../../model/fetch_city_list_model.dart';
import '../../model/fetch_state_list_model.dart';

class UploadHotelDetailsScreen extends StatefulWidget {
  final String screenRoute;
  const UploadHotelDetailsScreen({super.key,  this.screenRoute=""});

  @override
  State<UploadHotelDetailsScreen> createState() => _UploadHotelDetailsScreenState();
}

class _UploadHotelDetailsScreenState extends State<UploadHotelDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HotelsProvider>(context,listen: false).countrySearchController.clear();
    Provider.of<HotelsProvider>(context,listen: false).stateSearchController.clear();
    Provider.of<HotelsProvider>(context,listen: false).citySearchController.clear();
    Provider.of<HotelsProvider>(context,listen: false).countryReadOnly = false;
    // Provider.of<HotelsProvider>(context,listen: false).stateReadOnly = false;
    Provider.of<HotelsProvider>(context,listen: false).cityReadOnly = false;
    Provider.of<HotelsProvider>(context,listen: false).loadAllApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = myHelperFunctions.isDarkMode(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: darkMode ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: darkMode ? Colors.black : Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon:   Icon(
                  Icons.arrow_back_ios,
                  color:darkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: const Padding(
              padding: EdgeInsets.only(right: 20.0, top: 0),
              child: SizedBox(
                child: Text(
                  'Hotel Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Consumer<HotelsProvider>(
            builder: (context,provider,child){
              if(provider.allDataLoading){
                return const Center(child: LoaderWidget());
              }else{
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter your hotels details for verification approvals." ,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400 ),
                        ),
                        const HeightGap(gap: 0.02),
                        if (provider.fetchCountryModel.data.isNotEmpty) ...[
                          SizedBox(
                          height: 62,
                          width:size.width-35,
                          child:  MultiSelectDropDown(
                            borderColor: Colors.grey.shade500,
                            borderWidth: 1.0,
                            focusedBorderColor: Colors.grey.shade500,
                            focusedBorderWidth: 1.0,
                            // searchBackgroundColor: Colors.purple,
                            hintColor: Colors.white,
                            // selectedOptionBackgroundColor: Colors.orange,
                            optionsBackgroundColor: darkMode ? Colors.black : Colors.white,
                            dropdownBackgroundColor:darkMode ? Colors.black : Colors.white,
                            fieldBackgroundColor:darkMode ? Colors.black : Colors.white,
                            hint: "Country",
                            onOptionSelected: (List<ValueItem> selectedOptions) async {
                              provider.fetchStateModel = FetchStateModel();
                              provider.fetchCityModel = FetchCityModel();
                              if (selectedOptions.isNotEmpty) {
                                provider.selectedCountryId = selectedOptions[0].value.toString();
                                await provider.fetchStateListApi();
                              }else{
                                provider.selectedCountry = '';
                                provider.selectedState = '';
                                provider.selectedCity = '';
                              }
                              setState(() {});
                            },
                            options: provider.fetchCountryModel.data
                                .map((value) =>
                                ValueItem(label: value.countryName,value: value.countryId))
                                .toList(),
                            selectionType: SelectionType.single,
                  
                            searchEnabled: true,
                            chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                            dropdownHeight: 300,
                            // optionTextStyle: CustomTextStyles.font14blackW500,
                            selectedOptionIcon: const Icon(Icons.check_circle) ,
                            singleSelectItemStyle: TextStyle(color: Colors.white),
                          ),
                        ),],
                  
                        if (provider.fetchStateModel.data.isNotEmpty) ...[const HeightGap(gap: 0.02)],
                  
                        if (provider.fetchStateModel.data.isNotEmpty) ...[
                          SizedBox(
                          height: 62,
                          width:size.width-35,
                          child:  MultiSelectDropDown(
                            borderColor: Colors.grey.shade500,
                            borderWidth: 1.0,
                            focusedBorderColor: Colors.grey.shade500,
                            focusedBorderWidth: 1.0,
                            hintColor: Colors.white,
                            optionsBackgroundColor: darkMode ? Colors.black : Colors.white,
                            dropdownBackgroundColor:darkMode ? Colors.black : Colors.white,
                            fieldBackgroundColor:darkMode ? Colors.black : Colors.white,
                            hint: "State",
                            onOptionSelected: (List<ValueItem> selectedOptions) async {
                              provider.fetchCityModel = FetchCityModel();
                              if (selectedOptions.isNotEmpty) {
                                provider.selectedStatusId = selectedOptions[0].value.toString();
                                await provider.fetchCityListApi();
                              }else{
                                provider.selectedState = '';
                                provider.selectedCity = '';
                              }
                  
                              setState(() {});
                            },
                            options: provider.fetchStateModel.data
                                .map((value) =>
                                ValueItem(label: value.stateName, value: value.stateId))
                                .toList(),
                            selectionType: SelectionType.single,
                            searchEnabled: true,
                            chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                            dropdownHeight: 300,
                            singleSelectItemStyle: TextStyle(color: Colors.white),
                            selectedOptionIcon: const Icon(Icons.check_circle),
                          ),
                        ),
                        ],
                  
                        if (provider.fetchCityModel.data.isNotEmpty) ...[const HeightGap(gap: 0.02)],
                  
                        if (provider.fetchCityModel.data.isNotEmpty) ...[
                          SizedBox(
                            height: 62,
                            width:size.width-35,
                            child:  MultiSelectDropDown(
                              borderColor: Colors.grey.shade500,
                              borderWidth: 1.0,
                              focusedBorderColor: Colors.grey.shade500,
                              focusedBorderWidth: 1.0,
                              hintColor: Colors.white,
                              optionsBackgroundColor: darkMode ? Colors.black : Colors.white,
                              dropdownBackgroundColor:darkMode ? Colors.black : Colors.white,
                              fieldBackgroundColor:darkMode ? Colors.black : Colors.white,
                              hint: "City",
                              onOptionSelected: (List<ValueItem> selectedOptions) async {
                                if (selectedOptions.isNotEmpty) {
                                  provider.selectedCityId = selectedOptions[0].value.toString();
                                }else{
                                  provider.selectedCity = '';
                                }
                                setState(() {});
                              },
                              options: provider.fetchCityModel.data
                                  .map((value) =>
                                  ValueItem(label: value.cityName, value: value.cityId))
                                  .toList(),
                              selectionType: SelectionType.single,
                              searchEnabled: true,
                              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                              dropdownHeight: 300,
                              singleSelectItemStyle: TextStyle(color: Colors.white),
                              selectedOptionIcon: const Icon(Icons.check_circle),
                            ),
                          ),
                        ],
                  
                        const HeightGap(gap: 0.02),
                        TextFormField(
                          controller: provider.hotelNameController,
                          expands: false,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Iconsax.direct_right),
                          ),
                        ),
                        const HeightGap(gap: 0.02),
                        TextFormField(
                          controller: provider.emailController,
                          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: myTexts.email),
                        ),
                        const HeightGap(gap: 0.02),

                        TextFormField(
                          controller: provider.phoneController,
                          expands: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: const InputDecoration(
                            labelText: myTexts.phoneNumber,
                            prefixIcon: Icon(Iconsax.direct_right),
                          ),
                        ),
                        // TextFormField(
                        //   controller: provider.phoneController,
                        //   expands: false,
                        //   decoration: const InputDecoration(
                        //     labelText: "Phone Number",
                        //     prefixIcon: Icon(Iconsax.direct_right),
                        //   ),
                        // ),
                        const HeightGap(gap: 0.02),
                        TextFormField(
                          controller: provider.hotelAddressController,
                          expands: false,
                          decoration: const InputDecoration(
                            labelText: "Address",
                            prefixIcon: Icon(Iconsax.direct_right),
                          ),
                        ),
                        const HeightGap(gap: 0.02),

                        TextFormField(
                          controller: provider.pinCodeController,
                          expands: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                          ],
                          decoration: const InputDecoration(
                            labelText: myTexts.pinCode,
                            prefixIcon: Icon(Iconsax.direct_right),
                          ),
                        ),
                        const HeightGap(gap: 0.02),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       height: 72,
                        //       // width: size.width-30,
                        //       width: provider.countryReadOnly?size.width-80:size.width-30,
                        //       child: TypeAheadUtils.buildTypeAheadField(
                        //           hintText: "Country",
                        //           readOnly: provider.countryReadOnly,
                        //           textController: provider.countrySearchController,
                        //           data: provider.fetchCountryModel.data,
                        //           onSuggestionSelected: (data){
                        //             print("data---$data");
                        //             provider.selectedCountryId = data.countryId.toString();
                        //             provider.fetchStateListApi();
                        //             provider.countrySearchController.text = data.countryName;
                        //             provider.countryReadOnly = true;
                        //             print("data--1111-${ provider.selectedCountryId}");
                        //             setState(() {});
                        //           },
                        //           suggestionLabel: (item) =>
                        //           '${item.countryName}', selectedItems: [], onDelete: (){
                        //         setState(() {
                        //
                        //         });
                        //       }),
                        //     ),
                        //     if(provider.countryReadOnly == true)...[
                        //       InkWell(onTap: (){
                        //         provider.countryReadOnly = false;
                        //         provider.countrySearchController.clear();
                        //       },child: const Icon(Icons.close),)]
                        //   ],
                        // ),
                  
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       height: 72,
                        //       width: provider.stateReadOnly?size.width-80:size.width-30,
                        //       child: TypeAheadUtils.buildTypeAheadField(
                        //           hintText: "State",
                        //           readOnly: provider.stateReadOnly,
                        //           textController: provider.stateSearchController,
                        //           data: provider.fetchStateModel.data,
                        //           onSuggestionSelected: (data){
                        //             print("data---$data");
                        //             provider.selectedStatusId = data.stateId.toString();
                        //             provider.fetchCityListApi();
                        //             provider.stateSearchController.text = data.stateName;
                        //             provider.stateReadOnly = true;
                        //             print("data--1111-${ provider.selectedStatusId}");
                        //             setState(() {});
                        //           },
                        //           suggestionLabel: (item) =>
                        //           '${item.stateName}', selectedItems: [], onDelete: (){
                        //         setState(() {});
                        //       }),
                        //     ),
                        //     if(provider.stateReadOnly == true)...[
                        //       InkWell(onTap: (){
                        //         provider.stateReadOnly = false;
                        //         provider.stateSearchController.clear();
                        //       },child: const Icon(Icons.close),)]
                        //   ],
                        // ),
                        // const HeightGap(gap: 0.02),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       height: 72,
                        //       width: provider.cityReadOnly?size.width-80:size.width-30,
                        //       child: TypeAheadUtils.buildTypeAheadField(
                        //           hintText: "City",
                        //           readOnly: provider.cityReadOnly,
                        //           textController: provider.citySearchController,
                        //           data: provider.fetchCityModel.data,
                        //           onSuggestionSelected: (data){
                        //             print("data---$data");
                        //             provider.selectedCityId = data.cityId.toString();
                        //             provider.citySearchController.text = data.cityName;
                        //             provider.cityReadOnly = true;
                        //             print("data--1111-${ provider.selectedCityId}");
                        //             setState(() {});
                        //           },
                        //           suggestionLabel: (item) =>
                        //           '${item.cityName}', selectedItems: [], onDelete: (){
                        //         setState(() {});
                        //       }),
                        //     ),
                        //     if(provider.cityReadOnly == true)...[
                        //       InkWell(onTap: (){
                        //         provider.cityReadOnly = false;
                        //         provider.citySearchController.clear();
                        //       },child: const Icon(Icons.close),)]
                        //   ],
                        // ),
                        // const HeightGap(gap: 0.02),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
        bottomNavigationBar: (widget.screenRoute=="update")?
        Consumer<HotelsProvider>(
          builder: (context,provider,child){
            return provider.updateHotelLoading ?  const LoaderWidget():  Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 10.0,top: 5),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final response = await provider.updateHotelDetailsApi();
                 if (response["status"] == true) {
                    Toast.showSuccessToast(context, response["message"]);
                    // Navigator.of(context).pop();
                      materialPageRoute(context, HotelManagementHomeScreen());
                  }  else {
                   Toast.showErrorToast(context, response["message"]);
                  }
                  print("response :: $response");
                },

                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color:darkMode ?Colors.white: Colors.black,),
                  ),
                  child:  const Center(
                    child: Text(
                      "UPDATE",
                      style: TextStyle(
                        // fontSize: 16.42,
                        // fontFamily: 'Outfit',
                        // fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
            :
        Consumer<HotelsProvider>(
          builder: (context,provider,child){
            return provider.addHotelLoading ?  const LoaderWidget():  Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 10.0,top: 5),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final response = await provider.addHotelDetailsApi();
                  if (response != null && response.containsKey("hotelData") && response["hotelData"] != null) {
                    if (response["hotelData"]['hotelStatus'] == "Pending") {
                      Toast.showSuccessToast(context, response["message"]);
                      materialPageRoute(context, UploadDocumentScreen());
                    }else {
                      Toast.showErrorToast(context, response["message"]);
                    }
                  } else if (response["status"] == false) {
                    Toast.showErrorToast(context, response["message"]);
                    replaceScreen(context, UploadDocumentScreen());
                  }  else {
                    print("Response or hotelData is null");
                  }
                  print("response :: $response");
                },

                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color:darkMode ?Colors.white: Colors.black,),
                  ),
                  child:  Center(
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                        // fontSize: 16.42,
                        // fontFamily: 'Outfit',
                        // fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
