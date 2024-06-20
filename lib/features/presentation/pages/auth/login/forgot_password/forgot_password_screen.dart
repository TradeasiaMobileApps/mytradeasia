import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/send_reset_pass.dart';
import 'package:mytradeasia/helper/injections_container.dart';

import '../../../../../../config/themes/theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final SendResetPass _sendResetPass = injections<SendResetPass>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Image.asset(
              "assets/images/icon_back.png",
              width: 24.0,
              height: 24.0,
            )),
        backgroundColor: whiteColor,
        elevation: 0.0,
      ),
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
                "Forgot your Password?",
                style: text22,
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Rhoncus malesuada nunc elementum non consectetur.",
                  style: text12.copyWith(
                      fontWeight: FontWeight.w400, color: greyColor),
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
                      "Email",
                      style: text22.copyWith(
                          color: primaryColor1, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: body1Regular.copyWith(
                            color: greyColor, fontWeight: FontWeight.w400),
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
                      controller: _emailController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 55.0,
                child: _emailController.text.isNotEmpty
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
                          /* With go_route */
                          _sendResetPass.call(param: _emailController.text);
                          // context.go("/auth/login/reset_password");
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
                      /* With go_route */
                      context.go("/auth/login");
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return const LoginScreen();
                      //   },
                      // ), (route) => false);
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
