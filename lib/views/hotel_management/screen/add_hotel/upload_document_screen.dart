import 'dart:io';
import 'package:my_vender_app/utils/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_vender_app/common/toast/toaster.dart';
import 'package:my_vender_app/utils/constants/navigate.dart';
import 'package:my_vender_app/views/hotel_management/screen/hotels_management_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import '../../../../common/loader/animation_loader.dart';
import '../../provider/hotel_provider.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});
  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  Future<void> pickPanCardFiles({required HotelsProvider provider}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          provider.panCardDoc = result;
          // provider.panCardDoc = result.files.single.name;
          // print("fileBytes---${provider.panCardDoc!.files.single.name}");
          // print("fileBytes---${provider.panCardDoc!.files.single.path}");
        });

        print("selectedDocument---${provider.panCardDoc}");
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

  Future<void> pickRegistrationDocFiles({required HotelsProvider provider}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          provider.registrationDoc = result;
          // provider.panCardDoc = result.files.single.name;
          // print("fileBytes---${provider.panCardDoc!.paths}");
        });

        print("selectedDocument---${provider.panCardDoc}");
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

  Future<void> pickBlankChequeFiles({required HotelsProvider provider}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          provider.blankChequeDoc = result;
          // provider.panCardDoc = result.files.single.name;
          print("fileBytes---${provider.panCardDoc!.files.single.name}");
        });

        print("selectedDocument---${provider.panCardDoc}");
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

  void removePanCardFile({required HotelsProvider provider}) {
    setState(() {
      provider.panCardDoc = null;
    });
  }
  void removeHotelRegistrationFile({required HotelsProvider provider}) {
    setState(() {
      provider.registrationDoc = null;
    });
  }
  void removeBlankChequeFile({required HotelsProvider provider}) {
    setState(() {
      provider.blankChequeDoc = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final darkMode = myHelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkMode ? Colors.black : Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: darkMode ? Colors.white : Colors.black,
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
                  'Hotel Documents',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
        ),
        body: Consumer<HotelsProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Pan Card",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "Outfit"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: size.height/3,
                          width: double.infinity,
                          padding:   EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color:darkMode ? myColors.darkMode: myColors.lightMode,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: provider.panCardDoc != null
                                ? Stack(
                                    children: [
                                      Container(),
                                      Center(
                                        child: provider.panCardDoc != null
                                            ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  if (provider.panCardDoc!.files.single.path!.endsWith('.pdf'))
                                                      Center(child: Icon(Icons.picture_as_pdf, size:  size.height/4))
                                                  else
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Image.file( 
                                                        File(provider.panCardDoc!.files.single.path.toString()),
                                                        height: size.height/3,
                                                        width: size.width-50,
                                                        // width: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),

                                                ],
                                              )
                                            : InkWell(
                                          onTap: () async {
                                            await pickPanCardFiles(provider: provider);
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 45,
                                            width: size.width/2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                color: darkMode ? Colors.white : Colors.black,
                                              ),
                                            ),
                                            child: const Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Add Pan Cards",
                                                  // style: CustomTextStyles.font14blackW500,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ),
                                      Positioned(
                                          child: IconButton(
                                        icon: const Icon(Icons.cancel,size: 40,color:myColors.error,),
                                        onPressed: () {
                                          removePanCardFile(provider: provider);
                                        },
                                      ))
                                    ],
                                  )
                                : InkWell(
                                    onTap: () async {
                                      await pickPanCardFiles(provider: provider);
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 45,
                                      width: size.width/2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: darkMode ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      child: const Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Add Pan Card",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Hotel Registration",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "Outfit"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: size.height/3,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color:darkMode ? myColors.darkMode: myColors.lightMode,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: provider.registrationDoc != null
                                ? Stack(
                              children: [
                                Container(),
                                Center(
                                    child: provider.registrationDoc != null
                                        ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        if (provider.registrationDoc!.files.single.path!.endsWith('.pdf'))
                                          Center(child: Icon(Icons.picture_as_pdf, size:  size.height/4))
                                        else
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.file(
                                              File(provider.registrationDoc!.files.single.path.toString()),
                                              height: size.height/3,
                                              width: size.width-50,
                                              // width: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                      ],
                                    )
                                        : InkWell(
                                      onTap: () async {
                                        await pickRegistrationDocFiles(provider: provider);
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 45,
                                        width: size.width/2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: darkMode ? Colors.white : Colors.black,
                                          ),
                                        ),
                                        child: const Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Hotel Registration",
                                              // style: CustomTextStyles.font14blackW500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                ),
                                Positioned(
                                    child: IconButton(
                                      icon: const Icon(Icons.cancel,size: 40,color:myColors.error,),
                                      onPressed: () {
                                        removeHotelRegistrationFile(provider: provider);
                                      },
                                    ))
                              ],
                            )
                                : InkWell(
                              onTap: () async {
                                await pickRegistrationDocFiles(provider: provider);
                                setState(() {});
                              },
                              child: Container(
                                height: 45,
                                width: size.width/2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: darkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Hotel Registration",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Blank Cheque",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "Outfit"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: size.height/3,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color:darkMode ? myColors.darkMode: myColors.lightMode,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: provider.blankChequeDoc != null
                                ? Stack(
                              children: [
                                Container(),
                                Center(
                                    child: provider.blankChequeDoc != null
                                        ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        if (provider.blankChequeDoc!.files.single.path!.endsWith('.pdf'))
                                          Center(child: Icon(Icons.picture_as_pdf, size:  size.height/4))
                                        else
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.file(
                                              File(provider.blankChequeDoc!.files.single.path.toString()),
                                              height: size.height/3,
                                              width: size.width-50,
                                              // width: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                      ],
                                    )
                                        : InkWell(
                                      onTap: () async {
                                        await pickBlankChequeFiles(provider: provider);
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 45,
                                        width: size.width/2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: darkMode ? Colors.white : Colors.black,
                                          ),
                                        ),
                                        child: const Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Blank Cheque",
                                              // style: CustomTextStyles.font14blackW500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                ),
                                Positioned(
                                    child: IconButton(
                                      icon: const Icon(Icons.cancel,size: 40,color:myColors.error,),
                                      onPressed: () {
                                        removeBlankChequeFile(provider: provider);
                                      },
                                    ))
                              ],
                            )
                                : InkWell(
                              onTap: () async {
                                await pickBlankChequeFiles(provider: provider);
                                setState(() {});
                              },
                              child: Container(
                                height: 45,
                                width: size.width/2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: darkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Blank Cheque",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Consumer<HotelsProvider>(
          builder: (BuildContext context, provider, child) {
            return provider.uploadDocumentLoading ? const LoaderWidget() :  Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0, top: 5),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final response = await provider.uploadHotelDocumentApi();
                  debugPrint("response ::: --- $response");
                  if(response["status"]==true){
                    Toast.showSuccessToast(context, response["message"]);
                    materialPageRoute(context, HotelManagementHomeScreen());
                  }
                  // Navigator.of(context).pop();
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  child: Center(
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
        ));
  }
}
