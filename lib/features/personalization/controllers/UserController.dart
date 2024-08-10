import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/data/repositories/userRepositry.dart';
import 'package:t_store/features/personalization/models/userModel.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  Rx<UserModel> userr = UserModel.empty().obs;
  final profileLoading = false.obs;
  final imageUploader = false.obs;
  final userRepositryController = Get.put(UserRepositry());

  @override
  void onInit() {
    super.onInit();

    FetchUserDetails();
  }

  Future<void> FetchUserDetails() async {
    try {
      profileLoading.value = true;
      final user = await userRepositryController
          .fetchUserDetails(); // this will get all users data to use it
      userr(user);
    } catch (e) {
      userr(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecored(UserCredential? userCredentials) async {
    // we check if user data is exist or not
    try {
      if (userCredentials != null) {
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final userName =
            UserModel.generateUserName(userCredentials.user!.displayName ?? "");
        final newUser = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : '',
          userName: userName,
          email: userCredentials.user!.email ?? '',
          phone: userCredentials.user!.phoneNumber ?? '',
          ProfilePicture: userCredentials.user!.photoURL ?? '',
          password: '',
        );
        await UserRepositry.instance.saveUserRecored(newUser);
      }
    } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploader.value = true;
        final imageUrl = await userRepositryController.uploadImage(
            'Users/Images/Profile', image);
        // update ProfilePicture field
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepositryController.updateUserField(json);
        userr.value.ProfilePicture = imageUrl;
        userr.refresh();
        TLoaders.successSnackBar(
            title: 'Congratulation',
            message: 'Your Profile Image has been updated');
      }
    } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
    } finally {
      imageUploader.value = false;
    }
  }
}
