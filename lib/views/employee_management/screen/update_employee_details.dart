import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_vender_app/common/toast/toaster.dart';
import 'package:my_vender_app/views/employee_management/provider/employee_provider.dart';
import 'package:my_vender_app/views/employee_management/screen/employee_management_home_screen.dart';
import 'package:provider/provider.dart';
import '../../../common/loader/animation_loader.dart';
import '../../../utils/constants/navigate.dart';
import '../model/get_employee_list_model.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';

class UpdateEmployeeDetails extends StatefulWidget {
  final GetEmployeeData getEmployeeData;
  const UpdateEmployeeDetails({super.key, required this.getEmployeeData});
  @override
  State<UpdateEmployeeDetails> createState() => _UpdateEmployeeDetailsState();
}

class _UpdateEmployeeDetailsState extends State<UpdateEmployeeDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EmployeeProvider>(context, listen: false).firstNameController.text = widget.getEmployeeData.name;
    Provider.of<EmployeeProvider>(context, listen: false).lastnameController.text = widget.getEmployeeData.lastName;
    Provider.of<EmployeeProvider>(context, listen: false).emailController.text = widget.getEmployeeData.email;
    Provider.of<EmployeeProvider>(context, listen: false).employeeIDController.text = widget.getEmployeeData.employeeId;
    Provider.of<EmployeeProvider>(context, listen: false).phoneNumberController.text = widget.getEmployeeData.mobile;
    Provider.of<EmployeeProvider>(context, listen: false).empStatus = widget.getEmployeeData.status.toLowerCase() == "active" ? true : false;
    Provider.of<EmployeeProvider>(context, listen: false).selectedRole = widget.getEmployeeData.roleId;


    // print("++++++33${widget.getEmployeeData.}")
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeProvider>(context, listen: false).getAllEmployeeListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                'Employee Details',
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
      body: SingleChildScrollView(
        child: Consumer<EmployeeProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 3, bottom: 3),
                          child: Text(
                            widget.getEmployeeData.roleName,
                            style: const TextStyle(fontFamily: "Outfit", fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ),
                      const Spacer(),
                      provider.updateEmployeeStatusLoading ? Container(
                          width: 100,
                          height: 38,
                          child: const LoaderWidget()): FlutterSwitch(
                        activeToggleColor: Colors.white,
                        inactiveTextColor: Colors.white,
                        inactiveTextFontWeight: FontWeight.w600,
                        activeTextFontWeight: FontWeight.w600,
                        activeText: "ACTIVE",
                        inactiveText: "INACTIVE",
                        activeColor: Colors.green,
                        inactiveColor: Colors.red,
                        value: provider.empStatus,
                        valueFontSize: 11,
                        width: 100,
                        height: 38,
                        borderRadius: 20.0,
                        showOnOff: true,
                        onToggle: (val) async {
                          var result = await provider.updateEmployeeStatusApi(widget.getEmployeeData.id.toString());
                          provider.empStatus = val;
                          print("++++++120 $result");
                          Toast.showSuccessToast(context, result["message"]);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120.41,
                      height: 120.41,
                      decoration: ShapeDecoration(
                        color: darkMode ? Colors.grey.shade400 : Colors.black.withOpacity(0.5),
                        // image: const DecorationImage(
                        //   image: NetworkImage("https://via.placeholder.com/94x94"),
                        //   fit: BoxFit.fill,
                        // ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 80,
                        color: darkMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  /// first name

                  TextFormField(
                    controller: provider.firstNameController,
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: myTexts.firstName),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// last name
                  TextFormField(
                    controller: provider.lastnameController,
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: myTexts.lastName),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///email
                  TextFormField(
                    controller: provider.emailController,
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: myTexts.email),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// employee ID
                  TextFormField(
                    controller: provider.employeeIDController,
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: "Employee ID"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// phone number
                  TextFormField(
                    controller: provider.phoneNumberController,
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: myTexts.phoneNumber),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Container(
                  //   height: 45,
                  //   decoration: BoxDecoration(
                  //     color: darkMode ? Colors.black : Colors.white,
                  //     borderRadius: BorderRadius.circular(8),
                  //     border: Border.all(color: Colors.grey.shade600),
                  //   ),
                  //   child: DropdownButton<String>(
                  //     underline: SizedBox(),
                  //     isExpanded: true,
                  //     value: provider.selectedRole,
                  //     onChanged: (newValue) {
                  //       provider.setSelectedRole(newValue);
                  //     },
                  //     items: [
                  //       DropdownMenuItem<String>(
                  //         value: null,
                  //         child: Text("Select Designation"),
                  //       ),
                  //       ...provider.roles.map<DropdownMenuItem<String>>((role) {
                  //         return DropdownMenuItem<String>(
                  //           value: role['id'],
                  //           child: Text(role['name']),
                  //         );
                  //       }).toList(),
                  //     ],
                  //   ),
                  // ),

                  Container(
                    height: 45,
                    decoration: BoxDecoration(color: darkMode ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade600)),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      isExpanded: true,
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      value: provider.selectedRole,
                      onChanged: (newValue) {
                        provider.setSelectedRole(newValue);
                      },
                      items: provider.roles.map<DropdownMenuItem<String>>((role) {
                        return DropdownMenuItem<String>(
                          value: role['id'],
                          child: Text(role['name']),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///button
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 10.0),
          child: Consumer<EmployeeProvider>(
            builder: (context,provider,child){
              return provider.updateStaffLoading
                  ? const Center(child: LoaderWidget())
                  : InkWell(
                onTap: () async {
                  var result = await provider.updateStaffApi(widget.getEmployeeData.id.toString());
                  if (result['status'] == true) {
                    if(context.mounted)Toast.showSuccessToast(context, result['message']);
                    if (context.mounted) materialPageRoute(context, const EmployeeManagementScreen());
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
                      "Update Employee",
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
