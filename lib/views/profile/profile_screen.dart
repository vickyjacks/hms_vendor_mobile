import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/image_strings.dart';
import 'package:my_vender_app/utils/constants/colors.dart';

import '../../utils/constants/navigate.dart';
import '../employee_management/screen/employee_management_home_screen.dart';
import '../hotel_management/screen/hotels_management_home_screen.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import '../roles_management/screen/roles_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = myHelperFunctions.isDarkMode(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 2.4,
        scrolledUnderElevation: 2,
        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
              child: GestureDetector(
                child: Icon(
                  Icons.widgets_outlined,
                  color: dark ? Colors.white : Colors.black,
                ),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        title: Row(
          children: [
            Icon(
              Icons.diversity_1_outlined,
              color: dark ? Colors.white : Colors.black,
              size: 40,
            )
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () async {
                //  materialPageRoute(context, const DemoPage());
                //  CommonDialog().addHotelStaffDialog(context);
              },
              child: const Icon(Iconsax.notification_bing),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: myColors.grey, width: 1.5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  myImages.dummy_user_img,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Elise Harry',
              style: TextStyle(
                fontSize: 16.42,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                materialPageRoute(context, const HotelManagementHomeScreen());
              },
              child: Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 1.5), borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text("Hotels"),
                    Spacer(),
                    Icon(Icons.navigate_next),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                materialPageRoute(context, const RolesScreen());
              },
              child: Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 1.5), borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text("Role Management"),
                    Spacer(),
                    Icon(Icons.navigate_next),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                materialPageRoute(context, const EmployeeManagementScreen());
              },
              child: Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 1.5), borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text("Employee Management"),
                    Spacer(),
                    Icon(Icons.navigate_next),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
