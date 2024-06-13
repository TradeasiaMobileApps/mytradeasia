import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_credential_entity.dart';

import 'package:mytradeasia/features/domain/usecases/user_usecases/user_usecase_index.dart';
import 'package:mytradeasia/features/presentation/widgets/dialog_sheet_widget.dart';
import 'package:mytradeasia/helper/helper_functions.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserUsecaseIndex _userUseCase;

  AuthBloc(this._userUseCase) : super(const AuthInitState()) {
    on<LoginWithEmail>((event, emit) async {
      BuildContext context = event.context;

      if (event.role != 'sales') {
        // final response = await _postLoginUser
        //     .call(param: {"email": event.email, "password": event.password});
        final response = await _userUseCase.loginUser(loginCredential: {
          "email": event.email,
          "password": event.password
        });
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        if (response["code"] is UserCredentialEntity) {
          try {
            var userData = await _userUseCase.getUserData();
            final User user;
            UserCredentialEntity userCredential = response["code"];
            if (userData["role"] != "Sales") {
              user = await SendbirdChat.connect(userCredential.uid!,
                  nickname: userData["firstName"]);
            } else {
              user = await SendbirdChat.connect("sales");
            }
            await prefs.setString("userId", userCredential.uid!);
            emit(AuthLoggedInState(userCredential, user, userData["role"]));
            context.go("/home");
          } catch (e) {
            log("failed to login with error: $e");
          }
        } else {
          if (response["code"] == "user-not-found") {
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
          } else if (response["code"] == 'wrong-password') {
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
            showDialog(
              context: context,
              builder: (context) => DialogWidget(
                  urlIcon: "assets/images/logo_delete_account.png",
                  title: "Authentication error",
                  subtitle: response["message"],
                  textForButton: "Go back",
                  navigatorFunction: () {
                    context.pop(context);
                    context.pop(context);
                  }),
            );
          }
        }
      } else {
        final response = await _userUseCase.loginSales(sales: {
          "email": event.email,
          "password": event.password,
          "device_type": event.deviceType,
          "device_token": event.deviceToken
        });
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if (response.status!) {
          final User user;
          user = await SendbirdChat.connect("sales");

          UserCredentialEntity userCred =
              await _userUseCase.getUserCredentials();

          await prefs.setString("userId", userCred.uid!);
          emit(AuthLoggedInState(
              toUserCredentialEntityFromSalesModel(
                  response.salesUserData!.user!),
              user,
              "sales"));
          context.go("/home");
        } else {
          showDialog(
            context: context,
            builder: (context) => DialogWidget(
                urlIcon: "assets/images/logo_delete_account.png",
                title: "Authentication error",
                subtitle: response.message!,
                textForButton: "Go back",
                navigatorFunction: () {
                  context.pop(context);
                  context.pop(context);
                }),
          );
        }
      }
    });

    on<RegisterWithEmail>((event, emit) async {
      BuildContext context = event.context;

      final response = await _userUseCase.registerUser(user: event.userData);
      event.stopLoadingFunc();

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
        showDialog(
          context: context,
          builder: (context) => DialogWidget(
              urlIcon: "assets/images/logo_delete_account.png",
              title: response,
              subtitle: "",
              textForButton: "Try Again",
              navigatorFunction: () {
                Navigator.pop(context);
              }),
        );
      }
    });

    on<SSORegisterWithEmail>((event, emit) async {
      BuildContext context = event.context;

      final response = await _userUseCase.ssoRegisterUser(user: event.userData);
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
      emit(AuthLoggedInState(
          await _userUseCase.getUserCredentials(), user, role));
    });

    on<LogOut>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", false);
      prefs.setString("userId", "");
      prefs.clear();
      _userUseCase.logoutUser();
      emit(const AuthInitState());
    });

    on<DeleteAcc>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", false);
      prefs.setString("userId", "");
      prefs.clear();
      _userUseCase.deleteAccount();
    });
  }
}
