import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_vender_app/common/loader/animation_loader.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/views/hotel_management/provider/hotel_provider.dart';
import 'package:my_vender_app/views/hotel_management/screen/see_hotel_details_screen.dart';
import 'package:provider/provider.dart';
import '../../../../../common/dimention/dimention_screen.dart';
import '../../../../../utils/constants/navigate.dart';
import 'add_hotel/upload_document_screen.dart';
import 'add_hotel/upload_hotel_details_screen.dart';
import 'package:my_vender_app/utils/constants/image_strings.dart';

class HotelManagementHomeScreen extends StatefulWidget {
  const HotelManagementHomeScreen({Key? key}) : super(key: key);

  @override
  State<HotelManagementHomeScreen> createState() => _HotelManagementHomeScreenState();
}

class _HotelManagementHomeScreenState extends State<HotelManagementHomeScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<HotelsProvider>(context, listen: false).loadHotelListScreenGetApi();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final darkMode = myHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? Colors.black : Colors.white,
      body: Consumer<HotelsProvider>(
        builder: (context,provider,child){
          return provider.loadHotelListScreenApiLoading ? const Center(child: LoaderWidget()) :
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.deepOrange ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:25,),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeightGap(gap: 0.03),
                        Text("Welcome to Ola Otel",
                            style: TextStyle(
                              fontSize: 23,
                            )),

                        Text(
                            "Just a few steps to complete and then you can start earning with Us.",
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        HeightGap(gap: 0.04),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Create a New Hotel",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: provider.hotelListModel.hotels.isEmpty ? 1 : provider.hotelListModel.hotels.length,
                  itemBuilder: (context, index) {
                    if (provider.hotelListModel.hotels.isEmpty) {
                      return const Center(
                        child: Text(
                          'No hotels found.',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () async {
                              Provider.of<HotelsProvider>(context, listen: false).loadHotelDetailsScreenGetApi(provider.hotelListModel.hotels[index].hotelId);
                              if (context.mounted) materialPageRoute(context, const SeeHotelDetailsScreen());
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(myImages.hotel_icons, height: 100, width: 100),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider.hotelListModel.hotels[index].hotelName,
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: (provider.hotelListModel.hotels[index].hotelStatus.toString() == "Pending")
                                                  ? const Color(0xffffefc5)
                                                  : const Color(0xffd2d2d2),
                                              border: Border.all(
                                                  color: (provider.hotelListModel.hotels[index].hotelStatus.toString() == "Pending")
                                                      ? const Color(0xffffcc44)
                                                      : const Color(0xff6f6f6f)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 3, bottom: 3),
                                              child: Text(
                                                provider.hotelListModel.hotels[index].hotelStatus,
                                                style: TextStyle(
                                                  color: (provider.hotelListModel.hotels[index].hotelStatus.toString() == "Pending")
                                                      ? const Color(0xffffcc44)
                                                      : Color(0xff6f6f6f),
                                                  fontSize: 12.70,
                                                  fontFamily: 'Outfit',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Email : ${provider.hotelListModel.hotels[index].hotelEmail}",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Address : ${provider.hotelListModel.hotels[index].hotelAddress}",
                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),

              ),
            ],
          );
        },
      ),
      floatingActionButton: Consumer<HotelsProvider>(
        builder: (context,provider,child){
          return InkWell(
            onTap: ()async{
              if(provider.submissionLevelModel.status == true && provider.submissionLevelModel.level==1){
                if(context.mounted) materialPageRoute(context, const UploadHotelDetailsScreen());
              }else{
                materialPageRoute(context, const UploadDocumentScreen());
              }
              //  materialPageRoute(context, const UploadHotelDetailsScreen());
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color:darkMode ?Colors.black: Colors.white,
                  boxShadow:   [
                    BoxShadow(color:darkMode ?Colors.white: Colors.black, blurRadius: 5),
                  ]),
              child: const Center(
                child: Icon(Icons.add),
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar:  Padding(
      //   padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 10.0),
      //   child: InkWell( borderRadius: BorderRadius.circular(12),
      //     onTap: (){
      //       //  CommonDialog().addRolesDialog(context);
      //     },
      //     child: Container(
      //       height: 45,
      //       width: double.infinity,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(12),
      //         border: Border.all(color:darkMode ?Colors.white: Colors.black,),
      //       ),
      //       child: const Center(
      //         child: Text(
      //           "SUBMIT",
      //           style: TextStyle(
      //             // fontSize: 16.42,
      //             // fontFamily: 'Outfit',
      //             // fontWeight: FontWeight.w700,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
