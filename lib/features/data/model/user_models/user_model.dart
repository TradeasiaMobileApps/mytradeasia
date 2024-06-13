import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {String? email,
      String? password,
      String? role,
      String? companyName,
      String? country,
      String? countryCode,
      String? firstName,
      String? lastName,
      String? phone,
      String? profilePicUrl})
      : super(
          email: email,
          password: password,
          role: role,
          companyName: companyName,
          country: country,
          countryCode: countryCode,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          profilePicUrl: profilePicUrl,
        );

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'companyName': companyName,
      'country': country,
      'countryCode': countryCode,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'profilePicUrl': profilePicUrl,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      role: documentSnapshot.data().toString().contains('role')
          ? documentSnapshot.get('role')
          : "",
      companyName: documentSnapshot.data().toString().contains('companyName')
          ? documentSnapshot.get('companyName')
          : "",
      country: documentSnapshot.data().toString().contains('country')
          ? documentSnapshot.get('country')
          : "",
      countryCode: documentSnapshot.data().toString().contains('countryCode')
          ? documentSnapshot.get('countryCode')
          : "",
      firstName: documentSnapshot.data().toString().contains('firstName')
          ? documentSnapshot.get('firstName')
          : "",
      lastName: documentSnapshot.data().toString().contains('lastName')
          ? documentSnapshot.get('lastName')
          : "",
      phone: documentSnapshot.data().toString().contains('phone')
          ? documentSnapshot.get('phone')
          : "",
      profilePicUrl:
          documentSnapshot.data().toString().contains('profilePicUrl')
              ? documentSnapshot.get('profilePicUrl')
              : "",
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        role: json['role'],
        companyName: json['company_name'],
        country: json['country'],
        countryCode: json['dialing_code'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phone: json['mobile_number'],
        profilePicUrl: json['profile_pic']);
  }
}
