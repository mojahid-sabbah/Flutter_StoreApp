import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  final String? userName;
  final String email;
  String? firstName;
  String? lastName;
  String phone;
  String password;
  String ProfilePicture = '';

  UserModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.ProfilePicture,
    required this.phone,
    required this.userName,
    required this.id,
  });

  //                 tojson
  Map<String, dynamic> convert2Map() {
    return {
      'email': email,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'ProfilePicture': ProfilePicture,
      'phone': phone,
      'password': password,
      "id": id,
    };
  }

  String get fullName => ' $firstName $lastName';
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phone);
  static List<String> nameParts(fullName) => fullName.split(" ");

  static generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelcaseUserName = "$firstName$lastName";
    String UsernameWithPrefix = "cwt_$camelcaseUserName";
    return UsernameWithPrefix;
  }

  static UserModel empty() => UserModel(
      email: "",
      password: "",
      firstName: "",
      lastName: "",
      phone: "",
      ProfilePicture:'',
      userName: "",
      id: "");
// create a model from firebase Document Snapshot .
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
       return UserModel(
      email: data["email"] ?? '',
      userName: data["userName"] ?? '',
      firstName: data["firstName"] ?? '',
      lastName: data["lastName"] ?? '',
      ProfilePicture: data["ProfilePicture"] ?? '',
      phone: data["phone"] ?? '',
      password: data["password"] ?? '',
      id: document.id,
    );
    } else {
      return UserModel.empty();
    }
  }
// for a provider-----------------------------------------------------------------------
  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot["email"] ?? '',
      userName: snapshot["userName"] ?? '',
      firstName: snapshot["firstName"] ?? '',
      lastName: snapshot["lastName"] ?? '',
      ProfilePicture: snapshot["ProfilePicture"] ?? '',
      phone: snapshot["phone"] ?? '',
      password: snapshot["password"] ?? '',
      id: snapshot["id"],
    );
  }
}
