import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/update_email.dart';
import 'package:mytradeasia/features/presentation/widgets/dialog_sheet_widget.dart';
import 'package:mytradeasia/features/presentation/widgets/text_editing_widget.dart';
import 'package:mytradeasia/helper/injections_container.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final TextEditingController _oldEmailController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final UpdateEmail _updateEmail = injections<UpdateEmail>();

  @override
  void dispose() {
    super.dispose();
    _oldEmailController.dispose();
    _newEmailController.dispose();
    _confirmEmailController.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 52.0),
              Center(
                child: Image.asset(
                  "assets/images/logo_change_email.png",
                  width: 132.0,
                  height: 109.0,
                ),
              ),
              const SizedBox(height: 21.0),
              const Text(
                "Change Email",
                style: text22,
              ),
              const SizedBox(height: 5.0),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Rhoncus malesuada nunc elementum non consectetur.",
                style: text12.copyWith(fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Old Email"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextEditingWidget(
                            readOnly: false,
                            controller: _oldEmailController,
                            hintText: "Enter your old email address"),
                      ),
                    ),
                    const Text("New Email"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextEditingWidget(
                            readOnly: false,
                            controller: _newEmailController,
                            hintText: "Enter your new email address"),
                      ),
                    ),
                    const Text("Confirm New Email"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextEditingWidget(
                            readOnly: false,
                            controller: _confirmEmailController,
                            hintText: "Enter your new email adress"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Container(
            height: 55,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(primaryColor1),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
              onPressed: () async {
                // context.go("/mytradeasia/personal_data/change_email/otp_email");
                if (_newEmailController.text == _confirmEmailController.text) {
                  await _updateEmail
                      .call(param: _newEmailController.text)
                      .then((res) {
                    switch (res) {
                      case "invalid-email":
                        showDialog(
                          context: context,
                          builder: (context) => DialogWidget(
                              urlIcon: "assets/images/logo_delete_account.png",
                              title: "Email is invalid",
                              subtitle: "The email you type is invalid",
                              textForButton: "Close",
                              navigatorFunction: () {
                                context.pop();
                              }),
                        );
                        break;
                      case "email-already-in-use":
                        showDialog(
                          context: context,
                          builder: (context) => DialogWidget(
                              urlIcon: "assets/images/logo_delete_account.png",
                              title: "Email already in use",
                              subtitle: "The email is already used",
                              textForButton: "Close",
                              navigatorFunction: () {
                                context.pop();
                              }),
                        );
                        break;
                      case "requires-recent-login":
                        showDialog(
                          context: context,
                          builder: (context) => DialogWidget(
                              urlIcon: "assets/images/logo_delete_account.png",
                              title: "Requires recent login",
                              subtitle: "You need to re-login",
                              textForButton: "Close",
                              navigatorFunction: () {
                                context.pop();
                              }),
                        );
                        break;
                      default:
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return DialogWidget(
                                urlIcon:
                                    "assets/images/icon_sukses_reset_password.png",
                                title: "Successful Email Update",
                                subtitle:
                                    "Lorem ipsum dolor sit amet consectetur. Egestas porttitor risus enim cursus rutrum molestie tortor",
                                textForButton: "Go to Home",
                                navigatorFunction: () {
                                  /* with go_router */
                                  context.go("/home");
                                });
                          },
                        );
                    }
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => DialogWidget(
                        urlIcon: "assets/images/logo_delete_account.png",
                        title: "Confirm email does not match",
                        subtitle:
                            "New email and confirm email need to be match",
                        textForButton: "Close",
                        navigatorFunction: () {
                          context.pop();
                        }),
                  );
                }

                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) {
                //     return const EmailChangeOtpScreen();
                //   },
                // ));
              },
              child: Text(
                "Verify",
                style: text16.copyWith(color: whiteColor),
              ),
            )),
      ),
    );
  }
}
