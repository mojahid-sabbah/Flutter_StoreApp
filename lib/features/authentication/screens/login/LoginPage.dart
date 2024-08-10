import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/features/authentication/screens/login/loginWidgets/TFormDivider.dart';
import 'package:t_store/features/authentication/screens/login/loginWidgets/TLoginFooter.dart';
import 'package:t_store/features/authentication/screens/login/loginWidgets/TLoginForm.dart';
import 'package:t_store/features/authentication/screens/login/loginWidgets/TloginHeader.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddin_appbar_height,
          child: Column(
            children: [
              TloginHeader(dark: dark),

              // login form
              const TLoginForm(),

              // Form Divider
              TFormDivider(
                dark: dark,
                dividerText: TTexts.orSignInWith.capitalize!,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              // Footer
              const TLoginFooter()
            ],
          ),
        ),
      ),
    );
  }
}
