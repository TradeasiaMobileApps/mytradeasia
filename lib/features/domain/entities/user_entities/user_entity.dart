import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final String? password;
  final String? role;
  final String? companyName;
  final String? country;
  final String? countryCode;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? profilePicUrl;

  const UserEntity({
    this.email,
    this.password,
    this.role,
    this.companyName,
    this.country,
    this.countryCode,
    this.firstName,
    this.lastName,
    this.phone,
    this.profilePicUrl,
  });

  @override
  List<Object?> get props {
    return [
      email,
      password,
      role,
      companyName,
      country,
      countryCode,
      firstName,
      lastName,
      phone,
      profilePicUrl,
    ];
  }
}
