import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_vender_app/common/toast/toaster.dart';
import 'package:provider/provider.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';

import '../../../../common/loader/animation_loader.dart';
import '../../provider/roles_provider.dart';

class AddRolesDialog extends StatefulWidget {
  const AddRolesDialog({super.key});

  @override
  State<AddRolesDialog> createState() => _AddRolesDialogState();
}

class _AddRolesDialogState extends State<AddRolesDialog> {
  var provider;

  @override
  Widget build(BuildContext context) {
    final darkMode = myHelperFunctions.isDarkMode(context);
    provider = Provider.of<RolesManagementProvider>(context);
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        "Add Roles",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
      ),
      actions: [
        TextFormField(
            controller: provider.addRolesController,
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user_add), labelText:"Role Name"),
        ),
        const SizedBox(
          height: 40,
        ),
        Consumer<RolesManagementProvider>(
          builder: (context, provider, child) {
            return provider.isLoading
                ? const Center(child: LoaderWidget())
                :
            InkWell(
              onTap : () async {
                if (provider.addRolesController.text.isEmpty) {
                  Toast.showErrorToast(context,"please enter roles name");
                } else {
                  var response = await provider.addRolesApi();
                  if (response['status'] == true) {
                    Toast.showErrorToast(context,response['message']);
                  } else {
                    Toast.showErrorToast(context,response['message']);
                  }
                }
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color:darkMode ?Colors.white: Colors.black,)
                ),
                child: const Center(
                  child: Text(
                    "Create Role",
                    style: TextStyle(
                      fontSize: 16.42,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            );
                // : PrimaryButtons(
                //     onPressed: () async {
                //       if (provider.addRolesController.text.isEmpty) {
                //         Toast.showErrorToast(context,"please enter roles name");
                //       } else {
                //         var response = await provider.addRolesApi();
                //         if (response['status'] == true) {
                //           Toast.showErrorToast(context,response['message']);
                //         } else {
                //           Toast.showErrorToast(context,response['message']);
                //         }
                //       }
                //     },
                //     title: "Submit",
                //     height: 45.0,
                //     width: width,
                //     // loading: provider.stepLoading,
                //   );
          },
        )
      ],
    );
  }
}
