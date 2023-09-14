import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final String? password;
  final String? role;
  final String? companyName;
  final String? country;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;

  const UserEntity({
    this.email,
    this.password,
    this.role,
    this.companyName,
    this.country,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  @override
  List<Object?> get props {
    return [
      email,
      password,
      role,
      companyName,
      country,
      firstName,
      lastName,
      phoneNumber,
    ];
  }
}
