import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_credential_entity.dart';
// import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

abstract class AuthState extends Equatable {
  ///TODO: Sendbird function are commented for a while because of package problem
  final UserCredentialEntity? user;
  // final User? sendbirdUser;
  final String? role;

  // const AuthState({this.user, this.sendbirdUser, this.role});

  // @override
  // List<Object> get props => [user!, sendbirdUser!];
  const AuthState({this.user, this.role});

  @override
  List<Object> get props => [user!];
}

class AuthInitState extends AuthState {
  const AuthInitState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthLoggedInState extends AuthState {
  // const AuthLoggedInState(
  //     UserCredentialEntity? user, User sendbirdUser, String? role)
  //     : super(user: user, sendbirdUser: sendbirdUser, role: role);
  const AuthLoggedInState(UserCredentialEntity? user, String? role)
      : super(user: user, role: role);
}
