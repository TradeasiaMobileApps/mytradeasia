import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/presentation/widgets/dialog_sheet_widget.dart';

import '../../../../../../../config/themes/theme.dart';
import '../../../../../widgets/text_editing_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  final snackbar = SnackBar(
    content: const Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 82.0),
              Center(
                child: Image.asset(
                  "assets/images/logo_change_email.png",
                  width: 132.0,
                  height: 109.0,
                ),
              ),
              const SizedBox(height: 21.0),
              const Text(
                "Change Password",
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
                    const Text("Old Password"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextEditingWithIconSuffix(
                          readOnly: false,
                          controller: _oldPasswordController,
                          hintText: "Enter your old password",
                          imageUrl: "assets/images/icon_eye_open.png",
                          navigationPage: () {
                            print("old password");
                          },
                        ),
                      ),
                    ),
                    const Text("New Password"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextEditingWithIconSuffix(
                          readOnly: false,
                          controller: _newPasswordController,
                          hintText: "Enter your new password",
                          imageUrl: "assets/images/icon_eye_open.png",
                          navigationPage: () {
                            print("new password");
                          },
                        ),
                      ),
                    ),
                    const Text("Confirm New Password"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextEditingWithIconSuffix(
                          readOnly: false,
                          controller: _confirmPasswordController,
                          hintText: "Enter your new password",
                          imageUrl: "assets/images/icon_eye_open.png",
                          navigationPage: () {
                            print("confirm new password");
                          },
                        ),
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
                if (_oldPasswordController.text.isNotEmpty &&
                    _newPasswordController.text.isNotEmpty &&
                    _confirmPasswordController.text.isNotEmpty) {
                  if (_newPasswordController.text !=
                      _confirmPasswordController.text) {
                    showDialog(
                        context: context,
                        builder: (context) => DialogWidget(
                            urlIcon: "assets/images/logo_email_change.png",
                            title: "Error",
                            subtitle:
                                "Confirmation password is not the same with new password",
                            textForButton: "Back",
                            navigatorFunction: () {
                              /* With go_route */
                              // context.go("/home");
                              Navigator.pop(context);

                              // Navigator.pushAndRemoveUntil(context,
                              //     MaterialPageRoute(
                              //       builder: (context) {
                              //         return const NavigationBarWidget();
                              //       },
                              //     ), (route) => false);
                            }));
                  } else {
                    log("DONE");
                    var cred = EmailAuthProvider.credential(
                        email: _auth.currentUser!.email!,
                        password: _oldPasswordController.text);

                    await _auth.currentUser!
                        .reauthenticateWithCredential(cred)
                        .then((value) {
                      _auth.currentUser!
                          .updatePassword(_newPasswordController.text);
                      showDialog(
                          context: context,
                          builder: (context) => DialogWidget(
                              urlIcon: "assets/images/logo_email_change.png",
                              title: "Password has been Change",
                              subtitle:
                                  "Lorem ipsum dolor sit amet consectetur. Egestas porttitor risus enim cursus rutrum molestie tortor",
                              textForButton: "Back to My Tradeasia",
                              navigatorFunction: () {
                                /* With go_route */
                                context.go("/home");
                                Navigator.pop(context);

                                // Navigator.pushAndRemoveUntil(context,
                                //     MaterialPageRoute(
                                //       builder: (context) {
                                //         return const NavigationBarWidget();
                                //       },
                                //     ), (route) => false);
                              }));
                    }).catchError((error) {
                      log("Error : $error");
                      showDialog(
                          context: context,
                          builder: (context) => DialogWidget(
                              urlIcon: "assets/images/logo_email_change.png",
                              title: "Error",
                              subtitle: error.toString(),
                              textForButton: "Back",
                              navigatorFunction: () {
                                /* With go_route */
                                // context.go("/home");
                                Navigator.pop(context);

                                // Navigator.pushAndRemoveUntil(context,
                                //     MaterialPageRoute(
                                //       builder: (context) {
                                //         return const NavigationBarWidget();
                                //       },
                                //     ), (route) => false);
                              }));
                    });
                  }
                } else {
                  log("Please fill all the fields");
                  showDialog(
                      context: context,
                      builder: (context) => DialogWidget(
                          urlIcon: "assets/images/logo_email_change.png",
                          title: "Error",
                          subtitle: "Please fill all the fields",
                          textForButton: "Back",
                          navigatorFunction: () {
                            /* With go_route */
                            // context.go("/home");
                            Navigator.pop(context);

                            // Navigator.pushAndRemoveUntil(context,
                            //     MaterialPageRoute(
                            //       builder: (context) {
                            //         return const NavigationBarWidget();
                            //       },
                            //     ), (route) => false);
                          }));
                }
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
