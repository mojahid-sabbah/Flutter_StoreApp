import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/app.dart';
import 'package:t_store/data/repositories/authentication_repositry.dart';
import 'package:t_store/firebase_options.dart';

Future<void> main() async {
  // LESSON 34 >>    https://www.youtube.com/watch?v=GYtMpccOOtU&list=PL5jb9EteFAOAusKTSuJ5eRl1BapQmMDT6&index=34
  // WidgetsBinding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
//GetStorage
  await GetStorage.init();
// await splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepositry()));

  runApp(const App());
}
