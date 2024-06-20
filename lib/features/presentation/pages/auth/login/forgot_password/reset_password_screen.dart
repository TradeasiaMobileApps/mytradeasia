import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/themes/theme.dart';
import '../../../../widgets/dialog_sheet_widget.dart';
import '../login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  bool obscureText = true;
  bool obscureTextConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Image.asset("assets/images/logo_forgot_password.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Reset Password",
                style: text22,
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Rhoncus malesuada nunc elementum non consectetur.",
                  style: text12.copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: text14.copyWith(
                          color: primaryColor1, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        hintStyle: body1Regular.copyWith(
                            color: greyColor2, fontWeight: FontWeight.w400),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor1),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText == true
                              ? Image.asset(
                                  "assets/images/icon_eye_close.png",
                                  width: 24.0,
                                  height: 24.0,
                                )
                              : Image.asset(
                                  "assets/images/icon_eye_open.png",
                                  width: 24.0,
                                  height: 24.0,
                                ),
                        ),
                      ),
                      controller: _oldPasswordController,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Confirmation Password",
                      style: text14.copyWith(
                          color: primaryColor1, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: obscureTextConfirm,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        hintStyle: body1Regular.copyWith(
                            color: greyColor2, fontWeight: FontWeight.w400),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor1),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureTextConfirm = !obscureTextConfirm;
                            });
                          },
                          icon: obscureTextConfirm == true
                              ? Image.asset(
                                  "assets/images/icon_eye_close.png",
                                  width: 24.0,
                                  height: 24.0,
                                )
                              : Image.asset(
                                  "assets/images/icon_eye_open.png",
                                  width: 24.0,
                                  height: 24.0,
                                ),
                        ),
                      ),
                      controller: _newPasswordController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 55.0,
                child: (_oldPasswordController.text.isNotEmpty &&
                            _newPasswordController.text.isNotEmpty) &&
                        (_oldPasswordController.text ==
                            _newPasswordController.text)
                    ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(primaryColor1),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return DialogWidget(
                                urlIcon:
                                    "assets/images/icon_sukses_reset_password.png",
                                title: "Successful Reset Password",
                                subtitle:
                                    "Lorem ipsum dolor sit amet consectetur. Egestas porttitor risus enim cursus rutrum molestie tortor",
                                textForButton: "Back to Sign In",
                                navigatorFunction: () {
                                  // navigatorFunction;
                                  context.go("/auth/login");

                                  // Navigator.pushReplacement(context,
                                  //     MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return const LoginScreen();
                                  //   },
                                  // ));
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          "Send",
                          style: text16.copyWith(color: whiteColor),
                        ),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                        onPressed: null,
                        child: Text(
                          "Send",
                          style: text16.copyWith(color: whiteColor),
                        ),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Remember Password?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text("Sign in here"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
