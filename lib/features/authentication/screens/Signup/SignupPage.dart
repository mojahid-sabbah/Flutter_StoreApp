import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/screens/Signup/SignupWidgets/SignUpForm.dart';

import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Regestration"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
             children: [
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),

              ////    FORM
              const SignUpForm()

              /// END FORM
            ],
          ),
        ),
      ),
    );
  }
}
