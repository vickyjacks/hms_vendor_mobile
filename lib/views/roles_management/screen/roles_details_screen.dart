import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import '../../../common/loader/animation_loader.dart';
import '../provider/roles_provider.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';

class RolesDetailsScreen extends StatefulWidget {
  String roleId = "";

  RolesDetailsScreen({super.key, required this.roleId});

  @override
  State<RolesDetailsScreen> createState() => _RolesDetailsScreenState();
}

class _RolesDetailsScreenState extends State<RolesDetailsScreen> with SingleTickerProviderStateMixin {
  bool status6 = false;
  bool status1 = false;
  bool status2 = false;
  TabController? _controller;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<RolesManagementProvider>(context, listen: false).getRolesDetailsApi(widget.roleId);
    });
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = myHelperFunctions.isDarkMode(context);
    log("++++++++++21${widget.roleId}");
    var height = MediaQuery.of(context).size.height;
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
                'Roles Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
      ),
      body: Consumer<RolesManagementProvider>(builder: (context, provider, child) {
        print("++++++++++++90 :: ${provider.roleDetailModelData}");
        return provider.fetchRollData
            ? const Center(child: LoaderWidget())
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Text(
                    provider.roleDetailModelData.roleData.roleName,
                    style: const TextStyle(
                      fontSize: 23.42,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  FlutterSwitch(
                    activeToggleColor: Colors.white,
                    inactiveTextColor: Colors.white,
                    inactiveTextFontWeight: FontWeight.w600,
                    activeTextFontWeight: FontWeight.w600,
                    activeText: "ACTIVE",
                    inactiveText: "INACTIVE",
                    activeColor: Colors.green,
                    inactiveColor: Colors.red,
                    value: status6,
                    valueFontSize: 11,
                    width: 100,
                    height: 38,
                    borderRadius: 20.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        status6 = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.80,
              color: Colors.transparent,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  TabBar(
                    // labelColor: Colors.black,
                    // indicatorColor: Colors.blue,
                    controller: _controller,
                    labelStyle: const TextStyle(
                      fontSize: 18.42,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w800,
                    ),
                    tabs: const [
                      Tab(
                        text: 'Permission',
                      ),
                      Tab(
                        text: 'Employee',
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Hotel Management',
                                      style: TextStyle(
                                        fontSize: 18.42,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    FlutterSwitch(
                                      activeToggleColor: Colors.white,
                                      inactiveTextColor: Colors.white,
                                      inactiveTextFontWeight: FontWeight.w600,
                                      activeTextFontWeight: FontWeight.w600,
                                      activeText: "ON",
                                      inactiveText: "OFF",
                                      activeColor: Colors.green,
                                      inactiveColor: Colors.red,
                                      value: status1,
                                      valueFontSize: 12,
                                      width: 65,
                                      height: 35,
                                      borderRadius: 20.0,
                                      showOnOff: true,
                                      onToggle: (val) {
                                        setState(() {
                                          status1 = val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: List.generate(
                                    150 ~/ 3,
                                        (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0 ? Colors.transparent : Colors.grey.shade300,
                                        height: 1,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Staff Management',
                                      style: TextStyle(
                                        fontSize: 18.42,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    FlutterSwitch(
                                      activeToggleColor: Colors.white,
                                      inactiveTextColor: Colors.white,
                                      inactiveTextFontWeight: FontWeight.w600,
                                      activeTextFontWeight: FontWeight.w600,
                                      activeText: "ON",
                                      inactiveText: "OFF",
                                      activeColor: Colors.green,
                                      inactiveColor: Colors.red,
                                      value: status2,
                                      valueFontSize: 12,
                                      width: 65,
                                      height: 35,
                                      borderRadius: 20.0,
                                      showOnOff: true,
                                      onToggle: (val) {
                                        setState(() {
                                          status2 = val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Mr. Ankit Yadav',
                                      style: TextStyle(
                                        fontSize: 18.42,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Sr. Manager',
                                      style: TextStyle(
                                        fontSize: 15.42,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: List.generate(
                                    150 ~/ 3,
                                        (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0 ? Colors.transparent : Colors.grey.shade300,
                                        height: 1,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Mr. Ankit Yadav',
                                      style: TextStyle(
                                        fontSize: 18.42,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Floor Manager',
                                      style: TextStyle(
                                        fontSize: 15.42,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
