import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';

abstract class AuthEvent extends Equatable {
  // final User? user;

  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmail extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginWithEmail(this.email, this.password, this.context);
}

class RegisterWithEmail extends AuthEvent {
  final UserEntity userData;
  // final String email;
  // final String phoneNumber;
  // final String companyName;
  // final String firstName;
  // final String lastName;
  // final String role;
  // final String country;
  // final String password;
  final BuildContext context;

  const RegisterWithEmail(
    this.userData,
    // this.email,
    // this.phoneNumber,
    // this.role,
    this.context,
    // this.companyName,
    // this.firstName,
    // this.lastName,
    // this.password,
    // this.country);
  );
}

class SSORegisterWithEmail extends AuthEvent {
  final UserEntity userData;
  final BuildContext context;

  const SSORegisterWithEmail(
    this.userData,
    this.context,
  );
}

class IsLoggedIn extends AuthEvent {
  const IsLoggedIn();
}

class AuthLoading extends AuthEvent {
  const AuthLoading();
}

class LogOut extends AuthEvent {
  const LogOut();
}

class DeleteAcc extends AuthEvent {
  const DeleteAcc();
}
