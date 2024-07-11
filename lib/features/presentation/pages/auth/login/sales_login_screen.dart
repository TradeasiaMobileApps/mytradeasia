import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_event.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../config/themes/theme.dart';
import '../../../../../utils/notification_service.dart';
import '../../../widgets/loading_overlay_widget.dart';

class SalesLoginScreen extends StatefulWidget {
  const SalesLoginScreen({super.key});

  @override
  State<SalesLoginScreen> createState() => _SalesLoginScreenState();
}

class _SalesLoginScreenState extends State<SalesLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _connection = true;

  final dio = Dio();

  UserObject? user;
  bool logoutUser = false;

  NotificationService notificationServices = NotificationService();

  @override
  void initState() {
    _passwordVisible = false;
    checkConnection();
    super.initState();
  }

  checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      _connection = true;
      return;
    } else {
      _connection = false;
    }
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
      checkConnection();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(size20px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30.0),
                  Center(
                    child: SizedBox(
                      width: 159.0,
                      height: 65.0,
                      child: Image.asset("assets/images/logo_biru.png"),
                    ),
                  ),
                  const SizedBox(height: 50.48),
                  const Text("Hi there, Welcome Back!", style: heading1),
                  const SizedBox(height: 5.0),
                  Text(
                      "Lorem ipsum dolor sit amet consectetur. Tincidunt varius blandit a nisl purus pulvinar quis. Posuere ligula.",
                      style: body1Medium.copyWith(color: fontColor2)),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //Email
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email", style: heading3),
                        const SizedBox(height: 8),
                        // email
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            hintStyle: body1Regular.copyWith(color: greyColor),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: greyColor3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor1),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: size20px * 0.75, bottom: size20px - 12.0),
                          child: Text("Password", style: heading3),
                        ),
                        // phone number
                        TextFormField(
                          obscureText: !_passwordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          validator: (valuePassword) {
                            if (valuePassword!.isEmpty) {
                              return "Please input the password";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            hintStyle: body1Regular.copyWith(color: greyColor),
                            errorMaxLines: 3,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: greyColor3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor1),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              icon: !_passwordVisible
                                  ? Image.asset(
                                      "assets/images/icon_eye_close.png",
                                      width: 24.0,
                                      height: 24.0,
                                    )
                                  : Image.asset(
                                      "assets/images/icon_eye_open.png",
                                      width: 24.0,
                                      height: 24.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 50,
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55.0,
                    child: _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty
                        ? BlocBuilder<AuthBloc, AuthState>(
                            builder: (_, state) => ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    primaryColor1),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String? role =
                                    prefs.getString("role")?.toLowerCase();

                                String deviceType =
                                    Platform.isAndroid ? 'android' : 'ios';

                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _connection = !_connection;
                                  });
                                  notificationServices
                                      .requestNotificationPermission();
                                  String? deviceToken =
                                      await notificationServices
                                          .getDeviceToken();

                                  authBloc.add(LoginWithEmail(
                                    _emailController.text,
                                    _passwordController.text,
                                    role!,
                                    deviceType,
                                    deviceToken,
                                    context,
                                  ));
                                  if (state is AuthLoggedInState) {
                                    _connection = !_connection;
                                  }
                                }
                              },
                              child: Text(
                                "Sign In",
                                style: text16.copyWith(color: whiteColor),
                              ),
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(greyColor),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                            ),
                            onPressed: null,
                            child: Text(
                              "Sign In",
                              style: text16.copyWith(color: whiteColor),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            _connection
                ? const SizedBox()
                : SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: const LoadingOverlay(),
                  ),
          ],
        ),
      ),
    );
  }
}

class UserObject {
  UserObject({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImageUrl,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImageUrl;
}
