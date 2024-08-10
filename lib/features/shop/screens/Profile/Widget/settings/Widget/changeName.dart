import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/features/shop/screens/Profile/Widget/settings/Widget/controller/updateNameController.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class changeName extends StatelessWidget {
  const changeName({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(updateNameControllers());
    return Scaffold(
      appBar: const appBarWidget(
        showbackarrow: true,
        title: Text("Change Name"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text('use real name to easy verification '),
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller:  controller.firstname,
                  validator: (value) =>
                      TValidator.validateEmptyText('first Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                TextFormField(
                  controller: controller.lastname,
                  validator: (value) =>
                      TValidator.validateEmptyText('last Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.updateUserName();
                      },
                      child: const Text('save')),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
