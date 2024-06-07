import 'package:flutter/material.dart';
import 'package:my_vender_app/views/authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(onTap:()async{
            await Provider.of<AuthenticationProviders>(context, listen: false).logOut(context);
        },child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.red
            ),
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Logout"),
        ))),
      ),
    );
  }
}
