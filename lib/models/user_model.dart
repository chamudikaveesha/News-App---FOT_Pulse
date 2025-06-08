// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   final String? uid;
//   final String name;
//   final String email;
//   final String? mobileNo;
//   final String? address;
//   final String? profileImageUrl;
//   final String? studentId;
//   final String? personalStatement;

//   UserModel({
//     this.uid,
//     required this.name,
//     required this.email,
//     this.mobileNo,
//     this.address,
//     this.profileImageUrl,
//     this.studentId,
//     this.personalStatement,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'uid': uid,
//       'name': name,
//       'email': email,
//       'mobileNo': mobileNo,
//       'address': address,
//       'profileImageUrl': profileImageUrl,
//       'studentId': studentId,
//       'personalStatement': personalStatement,
//     };
//   }

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       uid: json['uid'],
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       mobileNo: json['mobileNo'],
//       address: json['address'],
//       profileImageUrl: json['profileImageUrl'],
//       studentId: json['studentId'],
//       personalStatement: json['personalStatement'],
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String name;
  final String email;
  final String? mobileNo;
  final String? address;
  final String? profileImageUrl;
  final String? studentId;
  final String? personalStatement;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    this.mobileNo,
    this.address,
    this.profileImageUrl,
    this.studentId,
    this.personalStatement,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'mobileNo': mobileNo,
      'address': address,
      'profileImageUrl': profileImageUrl,
      'studentId': studentId,
      'personalStatement': personalStatement,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobileNo'],
      address: json['address'],
      profileImageUrl: json['profileImageUrl'],
      studentId: json['studentId'],
      personalStatement: json['personalStatement'],
    );
  }
}