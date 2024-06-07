import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:my_vender_app/common/loader/animation_loader.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:provider/provider.dart';
import '../../../common/toast/toaster.dart';
import '../../../utils/constants/navigate.dart';
import '../provider/hotel_provider.dart';
import 'add_hotel/upload_hotel_details_screen.dart';
import 'hotels_management_home_screen.dart';

class SeeHotelDetailsScreen extends StatefulWidget {
  const SeeHotelDetailsScreen({super.key});

  @override
  State<SeeHotelDetailsScreen> createState() => _SeeHotelDetailsScreenState();
}

class _SeeHotelDetailsScreenState extends State<SeeHotelDetailsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Provider.of<HotelsProvider>(context, listen: false).fetchHotelDocument();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = myHelperFunctions.isDarkMode(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: darkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: darkMode ? Colors.white : Colors.black,
                size: 40,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Center(
              child: Text(
                'Hotel Details',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Consumer<HotelsProvider>(
          builder: (context, provider, child) {
            return provider.loadHotelDetailsScreenGetApiLoading
                ? const Center(child: LoaderWidget())
                : SingleChildScrollView(
                  child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Hotel Details",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  materialPageRoute(
                                      context,
                                      const UploadHotelDetailsScreen(
                                        screenRoute: "update",
                                      ));
                                },
                                child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: darkMode ? Colors.black12 : Colors.grey.shade200, border: Border.all(color: Colors.grey)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.edit,
                                        size: 15,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: darkMode ? Colors.black12 : Colors.grey.shade200, border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.getDetailModel.data!.hotelName,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: (provider.getDetailModel.data!.hotelStatus.toString() == "Pending") ? const Color(0xffffefc5) : const Color(0xffd2d2d2),
                                    border: Border.all(color: (provider.getDetailModel.data!.hotelStatus.toString() == "Pending") ? const Color(0xffffcc44) : const Color(0xff6f6f6f)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 3, bottom: 3),
                                    child: Text(
                                      provider.getDetailModel.data!.hotelStatus,
                                      style: TextStyle(
                                        color: (provider.getDetailModel.data!.hotelStatus.toString() == "Pending") ? const Color(0xffffcc44) : const Color(0xff6f6f6f),
                                        fontSize: 12.70,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Email - ${provider.getDetailModel.data!.hotelEmail}",
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                                ),
                                Text(
                                  "Phone - +91 ${provider.getDetailModel.data!.hotelMobile}",
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "ZIP CODE - ${provider.getDetailModel.data!.hotelPincode}",
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Address - ${provider.getDetailModel.data!.hotelAddress}",
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              "Documents :",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Pan Card",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  await provider.pickPanCardFiles(provider: provider);
                                  setState(() {});
                                },
                                child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: darkMode ? Colors.black12 : Colors.grey.shade200, border: Border.all(color: Colors.grey)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.edit,
                                        size: 15,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: darkMode ? Colors.black12 : Colors.grey.shade200, border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: provider.panCardDoc != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if (provider.panCardDoc!.files.single.path!.endsWith('.pdf'))
                                        Center(child: Icon(Icons.picture_as_pdf, size: size.height / 4))
                                      else
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.file(
                                            File(provider.panCardDoc!.files.single.path.toString()),
                                            height: size.height / 3,
                                            width: size.width - 50,
                                            // width: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                    ],
                                  )
                                : SizedBox(
                                    height: size.width / 2,
                                    width: size.width,
                                    child: (provider.getDocumentModel.data!.pancard.endsWith('.pdf'))
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: const PDF().cachedFromUrl(
                                              provider.getDocumentModel.data!.pancard,
                                              placeholder: (progress) => Center(child: Text('$progress %')),
                                              errorWidget: (error) => Center(child: Text(error.toString())),
                                            ),
                                          )
                                        : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(provider.getDocumentModel.data!.pancard, fit: BoxFit.cover)),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: darkMode ? Colors.black12 : Colors.grey.shade200, border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: size.width / 2,
                              width: size.width,
                              child: (provider.getDocumentModel.data!.hotelRegistration.endsWith('.pdf'))
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: const PDF().cachedFromUrl(
                                        provider.getDocumentModel.data!.hotelRegistration,
                                        placeholder: (progress) => Center(child: Text('$progress %')),
                                        errorWidget: (error) => Center(child: Text(error.toString())),
                                      ),
                                    )
                                  : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(provider.getDocumentModel.data!.hotelRegistration, fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: darkMode ? Colors.black12 : Colors.grey.shade200, border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: size.width / 2,
                              width: size.width,
                              child: (provider.getDocumentModel.data!.blankCheck.endsWith('.pdf'))
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: const PDF().cachedFromUrl(
                                        provider.getDocumentModel.data!.blankCheck,
                                        placeholder: (progress) => Center(child: Text('$progress %')),
                                        errorWidget: (error) => Center(child: Text(error.toString())),
                                      ),
                                    )
                                  : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(provider.getDocumentModel.data!.blankCheck, fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () async {
                            final response = await provider.updateHotelDocumentApi();
                            debugPrint("response ::: --- $response");
                            // if(response["status"]==true){
                            //   Toast.showSuccessToast(context, response["message"]);
                            //   materialPageRoute(context, HotelManagementHomeScreen());
                            // }
                            // // Navigator.of(context).pop();
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
                            child: provider.updateDocumentLoading ? const Center(child: LoaderWidget()) : const Center(
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
                        
                        // Container(
                        //   width: size.width,
                        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: darkMode ?Colors.black12 : Colors.grey.shade200, border: Border.all(color: Colors.grey)),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       SingleChildScrollView(
                        //         padding: const EdgeInsets.all(0),
                        //         physics: const ClampingScrollPhysics(),
                        //         scrollDirection: Axis.horizontal,
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: SizedBox(
                        //                 height: 100,
                        //                 width: size.width / 3,
                        //                 child: (provider.getDocumentModel.data!.pancard.endsWith('.pdf'))
                        //                     ? ClipRRect(
                        //                         borderRadius: BorderRadius.circular(12),
                        //                         child: const PDF().cachedFromUrl(
                        //                           provider.getDocumentModel.data!.pancard,
                        //                           placeholder: (progress) => Center(child: Text('$progress %')),
                        //                           errorWidget: (error) => Center(child: Text(error.toString())),
                        //                         ),
                        //                       )
                        //                     : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(provider.getDocumentModel.data!.pancard, fit: BoxFit.cover)),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: SizedBox(
                        //                 height: 100,
                        //                 width: size.width / 3,
                        //                 child: (provider.getDocumentModel.data!.hotelRegistration.endsWith('.pdf'))
                        //                     ? ClipRRect(
                        //                         borderRadius: BorderRadius.circular(12),
                        //                         child: const PDF().cachedFromUrl(
                        //                           provider.getDocumentModel.data!.hotelRegistration,
                        //                           placeholder: (progress) => Center(child: Text('$progress %')),
                        //                           errorWidget: (error) => Center(child: Text(error.toString())),
                        //                         ),
                        //                       )
                        //                     : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(provider.getDocumentModel.data!.hotelRegistration, fit: BoxFit.cover)),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: SizedBox(
                        //                 height: 100,
                        //                 width: size.width / 3,
                        //                 child: (provider.getDocumentModel.data!.blankCheck.endsWith('.pdf'))
                        //                     ? ClipRRect(
                        //                         borderRadius: BorderRadius.circular(12),
                        //                         child: const PDF().cachedFromUrl(
                        //                           provider.getDocumentModel.data!.blankCheck,
                        //                           placeholder: (progress) => Center(child: Text('$progress %')),
                        //                           errorWidget: (error) => Center(child: Text(error.toString())),
                        //                         ),
                        //                       )
                        //                     : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(provider.getDocumentModel.data!.blankCheck, fit: BoxFit.cover)),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                );
          },
        ),
      ),
    );
  }
}
