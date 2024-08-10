import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/features/shop/screens/MyAddress/Widgets/AddNewAddress.dart';
import 'package:t_store/features/shop/screens/MyAddress/Widgets/SingleAddressWidget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class MyAddress extends StatelessWidget {
  const MyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=> const AddNewAddress());
        },
        backgroundColor: TColors.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: const appBarWidget(
        showbackarrow: true,
        title: Text("My Address"), 
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SingleAddressWidget(
                selectedAddress: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
