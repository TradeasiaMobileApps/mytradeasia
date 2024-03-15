import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_credential_entity.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/delete_account.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_credentials.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/login.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/logout.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/register.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/sso_register_user.dart';
import 'package:mytradeasia/features/presentation/widgets/dialog_sheet_widget.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helper/injections_container.dart';

import '../../../domain/usecases/user_usecases/get_user_data.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUser _postRegisterUser;
  final SSORegisterUser _ssoRegisterUser;
  final LoginUser _postLoginUser;
  final LogOutUser _postLogoutUser;
  final DeleteAccount _deleteAccount;
  final GetUserData _geUserData = injections<GetUserData>();
  final GetUserCredentials _getUserCredentials =
      injections<GetUserCredentials>();

  AuthBloc(this._postRegisterUser, this._postLoginUser, this._postLogoutUser,
      this._ssoRegisterUser, this._deleteAccount)
      : super(const AuthInitState()) {
    on<LoginWithEmail>((event, emit) async {
      BuildContext context = event.context;

      final response = await _postLoginUser
          .call(param: {"email": event.email, "password": event.password});
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (response is UserCredentialEntity) {
        try {
          var userData = await _geUserData.call();
          final User user;

          if (userData["role"] != "Sales") {
            user = await SendbirdChat.connect(response.uid!,
                nickname: userData["firstName"]);
          } else {
            user = await SendbirdChat.connect("sales");
          }
          await prefs.setString("userId", response.uid!);
          emit(AuthLoggedInState(response, user, userData["role"]));
          context.go("/home");
        } catch (e) {
          log("failed to login with error: $e");
        }
      } else {
        if (response == "user-not-found") {
          showDialog(
            context: context,
            builder: (context) => DialogWidget(
                urlIcon: "assets/images/logo_delete_account.png",
                title: "Wrong Email",
                subtitle: "No user found for that email.",
                textForButton: "Go back",
                navigatorFunction: () {
                  context.pop(context);
                  context.pop(context);
                }),
          );
        } else if (response == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) => DialogWidget(
                urlIcon: "assets/images/logo_delete_account.png",
                title: "Wrong Password",
                subtitle: "Wrong password provided for that user.",
                textForButton: "Go back",
                navigatorFunction: () {
                  context.pop(context);
                  context.pop(context);
                }),
          );
        } else {
          log('auth code error');
        }
      }
    });
    on<RegisterWithEmail>((event, emit) async {
      BuildContext context = event.context;

      final response = await _postRegisterUser.call(param: event.userData);
      if (response == "success") {
        log("register success");
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return DialogWidget(
                urlIcon: "assets/images/icon_sukses_reset_password.png",
                title: "Successful Registration",
                subtitle:
                    "Lorem ipsum dolor sit amet consectetur. Egestas porttitor risus enim cursus rutrum molestie tortor",
                textForButton: "Go to Home",
                navigatorFunction: () {
                  /* with go_router */
                  context.go("/auth/login");
                });
          },
        );
      } else {
        log(response);
        showDialog(
          context: context,
          builder: (context) => DialogWidget(
              urlIcon: "assets/images/logo_delete_account.png",
              title: "Error",
              subtitle: "An error occurred, please try again",
              textForButton: "Try Again",
              navigatorFunction: () {
                Navigator.pop(context);
              }),
        );
      }
    });

    on<SSORegisterWithEmail>((event, emit) async {
      BuildContext context = event.context;

      final response = await _ssoRegisterUser.call(param: event.userData);
      if (response == "success") {
        log("register success");
      } else {
        log(response);
        showDialog(
          context: context,
          builder: (context) => DialogWidget(
              urlIcon: "assets/images/logo_delete_account.png",
              title: "Email already in use",
              subtitle: "Try another email for registration",
              textForButton: "Go back",
              navigatorFunction: () {
                Navigator.pop(context);
              }),
        );
      }
    });

    on<AuthLoading>(
      (event, emit) => emit(const AuthLoadingState()),
    );

    on<IsLoggedIn>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString("userId");
      String? role = prefs.getString("role");
      final User user;
      if (role != "Sales") {
        user = await SendbirdChat.connect(userId!);
      } else {
        user = await SendbirdChat.connect("sales");
      }
      emit(AuthLoggedInState(await _getUserCredentials.call(), user, role));
    });

    on<LogOut>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", false);
      prefs.setString("userId", "");
      prefs.clear();
      _postLogoutUser.call();
      emit(const AuthInitState());
    });

    on<DeleteAcc>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", false);
      prefs.setString("userId", "");
      prefs.clear();
      _deleteAccount.call();
    });
  }
}
