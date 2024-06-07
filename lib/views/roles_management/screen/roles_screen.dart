import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_vender_app/views/roles_management/screen/roles_details_screen.dart';
import 'package:provider/provider.dart';
import '../../../common/dialoge/common_dialoges.dart';
import '../../../common/loader/animation_loader.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';
import '../../../utils/constants/navigate.dart';
import '../provider/roles_provider.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<RolesManagementProvider>(context, listen: false).getAllRolesListApi();
    });
    super.initState();
  }

  var provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<RolesManagementProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final darkMode = myHelperFunctions.isDarkMode(context);
    print("+++++++++${provider.getAllRolesList.length}");
    return Scaffold(
      backgroundColor: darkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkMode ? Colors.black : Colors.white,
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
                'Roles Management',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.41,
                ),
              ),
            )),
      ),
      body: SafeArea(
        child: Consumer<RolesManagementProvider>(builder: (context, provider, child) {
          final providerData = provider.getAllRolesList;
          return provider.fetchData
              ? const Center(child: LoaderWidget())
              : SingleChildScrollView(
                child: Column(
                    children: [
                      ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        primary: true,
                        padding: const EdgeInsets.only(top: 0),
                        itemCount: providerData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10,bottom: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      materialPageRoute(context, RolesDetailsScreen(roleId: providerData[index].id));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.red,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey.shade300)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  border: Border.all(color: Colors.grey.shade300)),
                                              height: 80,
                                              width: 80,
                                              child: const Center(
                                                child: Icon(Iconsax.user,size: 40,),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    providerData[index].roleName,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Outfit',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  providerData[index].status,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Outfit',
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),

                            ],
                          );
                        },
                      ),
                    ],
                  ),
              );
        }),
      ),
      bottomNavigationBar: InkWell(
        onTap: (){
          CommonDialog().addRolesDialog(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 10.0),
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color:darkMode ?Colors.white: Colors.black,)
            ),
            child: const Center(
              child: Text(
                "Crete Roles",
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
