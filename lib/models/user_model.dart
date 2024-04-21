import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String userName;

  UserModel({
    required this.email,
    required this.userName,
  });

  factory UserModel.fromSnap(DocumentSnapshot snap) {
    var snapshoot = snap.data() as Map<String, dynamic>;
    return UserModel(

      email: snapshoot["email"],
      userName: snapshoot["userName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "userName": userName,
      };
}
