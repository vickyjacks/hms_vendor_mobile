import 'package:flutter/material.dart';

import '../../views/roles_management/screen/widgets/add_roles_bottomsheet.dart';

class CommonDialog {
  Future addRolesDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const AddRolesDialog();
        });
  }
}
