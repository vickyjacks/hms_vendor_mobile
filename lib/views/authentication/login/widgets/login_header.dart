import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_vender_app/utils/constants/image_strings.dart';
import 'package:my_vender_app/utils/constants/sizes.dart';
import 'package:my_vender_app/utils/constants/text_strings.dart';

class myLoginHeader extends StatelessWidget {
  const myLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            height: 150,
            image: AssetImage(
                dark ? myImages.lightAppLogo : myImages.darkAppLogo)),
        Text(
          myTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: mySizes.sm,
        ),
        Text(
          myTexts.loginSubtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
