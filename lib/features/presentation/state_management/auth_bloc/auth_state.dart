import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_credential_entity.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

abstract class AuthState extends Equatable {
  final UserCredentialEntity? user;
  final User? sendbirdUser;
  final String? role;

  const AuthState({this.user, this.sendbirdUser, this.role});

  @override
  List<Object> get props => [user!, sendbirdUser!];
}

class AuthInitState extends AuthState {
  const AuthInitState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

// class AuthErrorState extends AuthState {
//   final FirebaseAuthException error;
//   const AuthErrorState(this.error);
// }

class AuthLoggedInState extends AuthState {
  const AuthLoggedInState(
      UserCredentialEntity? user, User sendbirdUser, String? role)
      : super(user: user, sendbirdUser: sendbirdUser, role: role);
}
