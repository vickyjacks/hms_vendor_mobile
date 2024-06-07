import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_vender_app/common/toast/toaster.dart';
import 'package:my_vender_app/utils/constants/navigate.dart';
import 'package:my_vender_app/views/employee_management/provider/employee_provider.dart';
import 'package:my_vender_app/views/employee_management/screen/employee_management_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';
import '../../../../utils/constants/colors.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
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
                'Create Employee',
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
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Consumer<EmployeeProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                          Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Designation",
                            style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black,
                              fontSize: 15,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: darkMode ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade600),
                          ),
                          child: DropdownButton(
                            underline: SizedBox(),
                            isExpanded: true,
                            value: provider.selectedRole,
                            onChanged: (newValue) {
                              provider.setSelectedRole(newValue);
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: null, // Or any default value you want to assign
                                child: Text("Select Designation"), // Change this text as needed
                              ),
                              ...provider.roles.map<DropdownMenuItem<String>>((role) {
                                return DropdownMenuItem<String>(
                                  value: role['id'],
                                  child: Text(role['name']),
                                );
                              }).toList(),
                            ],
                          ),
                        ),

                        // Container(
                        //   height: 45,
                        //   decoration: BoxDecoration(
                        //       color:darkMode ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade600)),
                        //   child: DropdownButton(
                        //     underline: const SizedBox(),
                        //     isExpanded: true,
                        //     padding: const EdgeInsets.only(left: 8),
                        //     value: provider.selectedRole,
                        //     onChanged: (newValue) {
                        //       provider.setSelectedRole(newValue);
                        //     },
                        //     items: provider.roles.map<DropdownMenuItem<String>>((role) {
                        //       print("+++++++++++74 :: ${role['id']}");
                        //       return DropdownMenuItem<String>(
                        //         value: role['id'],
                        //         child: Text(role['name']),
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "First Name",
                        //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        // Container(
                        //     height: 45,
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     child: TextFormField(
                        //       controller: provider.firstNameController,
                        //       decoration: InputDecoration(
                        //         contentPadding: const EdgeInsets.only(top: 5.0, left: 10),
                        //         focusedBorder: const OutlineInputBorder(
                        //             borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        //             borderSide: BorderSide(
                        //               color: Color(0xFF163E6E),
                        //             )),
                        //         border: OutlineInputBorder(
                        //           borderSide: const BorderSide(width: 0.30, color: Color(0xFF6C6A6A)),
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //         // labelText: "Classroom Name",
                        //         hintText: "Ankit",
                        //       ),
                        //     )),

                        TextFormField(
                          controller: provider.firstNameController,
                          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: myTexts.firstName),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "Last Name",
                        //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        // Container(
                        //     height: 45,
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     child: TextFormField(
                        //       controller: provider.lastnameController,
                        //       decoration: InputDecoration(
                        //         contentPadding: const EdgeInsets.only(top: 5.0, left: 10),
                        //         focusedBorder: const OutlineInputBorder(
                        //             borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        //             borderSide: BorderSide(
                        //               color: Color(0xFF163E6E),
                        //             )),
                        //         border: OutlineInputBorder(
                        //           borderSide: const BorderSide(width: 0.30, color: Color(0xFF6C6A6A)),
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //         // labelText: "Classroom Name",
                        //         hintText: "Yadav",
                        //       ),
                        //     )),
                        TextFormField(
                          controller: provider.lastnameController,
                          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: myTexts.lastName),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "Email ID",
                        //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        // Container(
                        //     height: 45,
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     child: TextFormField(
                        //       controller: provider.emailController,
                        //       decoration: InputDecoration(
                        //         contentPadding: const EdgeInsets.only(top: 5.0, left: 10),
                        //         focusedBorder: const OutlineInputBorder(
                        //             borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        //             borderSide: BorderSide(
                        //               color: Color(0xFF163E6E),
                        //             )),
                        //         border: OutlineInputBorder(
                        //           borderSide: const BorderSide(width: 0.30, color: Color(0xFF6C6A6A)),
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //         // labelText: "Classroom Name",
                        //         hintText: "ankit@gmail.com",
                        //       ),
                        //     )),
                        TextFormField(
                          controller: provider.emailController,
                          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: myTexts.email),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: provider.employeeIDController,
                          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: "Employee ID"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: provider.phoneNumberController,
                          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: myTexts.phoneNumber),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "Password",
                        //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        // Container(
                        //     height: 45,
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     child: TextFormField(
                        //       controller: provider.passwordController,
                        //       decoration: InputDecoration(
                        //         contentPadding: const EdgeInsets.only(top: 5.0, left: 10),
                        //         focusedBorder: const OutlineInputBorder(
                        //             borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        //             borderSide: BorderSide(
                        //               color: Color(0xFF163E6E),
                        //             )),
                        //         border: OutlineInputBorder(
                        //           borderSide: const BorderSide(width: 0.30, color: Color(0xFF6C6A6A)),
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //         // labelText: "Classroom Name",
                        //         hintText: "Password@3%**#1234",
                        //       ),
                        //     )),
                        TextFormField(
                          controller: provider.passwordController,
                          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.password_check), labelText: myTexts.password),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                      ],
                    );
                  },
                ))),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 10.0),
        child: Consumer<EmployeeProvider>(
          builder: (context,provider,child){
            return provider.addStaffLoading
                ? Center(child: LoadingAnimationWidget.fallingDot(color: myColors.primary, size: 45))
                : InkWell(
              onTap: () async {
                var result = await provider.addStaffApi();
                if (result["success"] == true) {
                  Toast.showSuccessToast(context,result["message"]);
                  materialPageRoute(context, EmployeeManagementScreen());
                } else if (result["status"] == 400) {
                  Map<String, dynamic> errors = result['errors'];
                  if (errors.containsKey('email')) {
                    Toast.showErrorToast(context,errors['email']);
                  } else if (errors.containsKey('employeeId')) {
                    Toast.showErrorToast(context,errors['employeeId']);
                  } else if (errors.containsKey('mobile_no')) {
                    Toast.showErrorToast(context,errors['mobile_no']);
                  }
                }
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
            );
          },
        )
      ),
    );
  }
}
