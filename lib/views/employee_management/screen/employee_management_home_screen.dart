import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_vender_app/views/employee_management/screen/update_employee_details.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../common/loader/animation_loader.dart';
import '../../../utils/constants/navigate.dart';
import '../provider/employee_provider.dart';
import 'add_employee_screen.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  EmployeeManagementScreenState createState() => EmployeeManagementScreenState();
}

class EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeProvider>(context, listen: false).getAllEmployeeListApi();
      Provider.of<EmployeeProvider>(context, listen: false).getRolesListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = myHelperFunctions.isDarkMode(context);
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
                'Employee',
                textAlign: TextAlign.center,
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
      body: SafeArea(child: Consumer<EmployeeProvider>(
        builder: (context, provider, child) {
          return provider.fetchData
              ?  Center(child: const LoaderWidget())
              : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.getAllEmployeeList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                        child: GestureDetector(
                          onTap: () {
                            materialPageRoute(
                                context,
                                UpdateEmployeeDetails(
                                  getEmployeeData: provider.getAllEmployeeList[index],
                                ));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey)),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 85.41,
                                    height: 85.41,
                                    decoration: ShapeDecoration(
                                      image: const DecorationImage(
                                        image: NetworkImage("https://via.placeholder.com/94x94"),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${provider.getAllEmployeeList[index].name} ${provider.getAllEmployeeList[index].lastName}",
                                      style: const TextStyle(
                                        fontSize: 16.42,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      provider.getAllEmployeeList[index].roleName ?? "",
                                      style: const TextStyle( 
                                        fontSize: 12.31,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      provider.getAllEmployeeList[index].email ?? "",
                                      style: const TextStyle(
                                        fontSize: 12.31,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      provider.getAllEmployeeList[index].employeeId ?? "",
                                      style: const TextStyle(
                                        fontSize: 12.31,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                // const Spacer(),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Container(
                                //     width: 50.52,
                                //     height: 50.52,
                                //     decoration: ShapeDecoration(
                                //       color: Colors.white,
                                //       shape: RoundedRectangleBorder(
                                //         side: const BorderSide(width: 2.30, color: Color(0xFFD1D3D4)),
                                //         borderRadius: BorderRadius.circular(43),
                                //       ),
                                //       shadows: const [
                                //         BoxShadow(
                                //           color: Color(0x0C8484A2),
                                //           blurRadius: 34.46,
                                //           offset: Offset(0, 17.23),
                                //           spreadRadius: 0,
                                //         )
                                //       ],
                                //     ),
                                //     child: const Center(
                                //         child: Icon(
                                //           Icons.delete,
                                //           color: Colors.red,
                                //         )),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 10.0),
        child: InkWell(
          onTap: (){
            materialPageRoute(context, const AddEmployeeScreen());
          },
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200,)
            ),
            child: const Center(
              child: Text(
                "Crete Employee",
                style: TextStyle(
                  fontSize: 16.42,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
