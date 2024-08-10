import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/screens/Signup/Controllers/SignUpControllers.dart';
import 'package:t_store/features/authentication/screens/Signup/SignupWidgets/Terms_checkBox.dart';
import 'package:t_store/features/authentication/screens/login/loginWidgets/TFormDivider.dart';
import 'package:t_store/features/authentication/screens/login/loginWidgets/TLoginFooter.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/validators/validation.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignUpControllers());

    return Form(
        key: controller.signupformkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstnameController,
                    validator: (value) =>
                        TValidator.validateEmptyText('first Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastnameController,
                    validator: (value) =>
                        TValidator.validateEmptyText('last Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: controller.usernameController,
              validator: (value) =>
                  TValidator.validateEmptyText('user Name', value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: TTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: controller.emailController,
              validator: (value) => TValidator.validateEmail(value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: controller.phoneController,
              validator: (value) => TValidator.validatePhoneNumber(value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(
              // use obx to make onpressed to work
              () => TextFormField(
                controller: controller.passwordController,
                validator: (value) => TValidator.validatePassword(value),
                expands: false,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.hidePassword.value =
                              !controller.hidePassword.value;
                        },
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye))),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            Terms_checkBox(dark: dark),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                  //  controller.signupformkey.currentState!.validate();
                    controller.signup();
                  },
                  child: const Text(TTexts.createAccount)),
            ),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            TFormDivider(
                dark: dark, dividerText: TTexts.orSignUpWith.capitalize!),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            const TLoginFooter()

            ////
          ],
        ));
  }
}
