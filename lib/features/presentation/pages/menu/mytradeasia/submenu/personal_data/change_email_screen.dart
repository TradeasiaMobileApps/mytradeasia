import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/update_email.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_event.dart';
import 'package:mytradeasia/features/presentation/widgets/dialog_sheet_widget.dart';
import 'package:mytradeasia/features/presentation/widgets/loading_overlay_widget.dart';
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
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final UpdateEmail _updateEmail = injections<UpdateEmail>();
  bool _passwordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _oldEmailController.dispose();
    _newEmailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);

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
                            // key: _formKey,
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
                            // key: _formKey,
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
                            // key: _formKey,
                            readOnly: false,
                            controller: _confirmEmailController,
                            hintText: "Enter your new email address"),
                      ),
                    ),
                    const Text("Password"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          style: body1Regular,
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
              onPressed: () {
                // context.go("/mytradeasia/personal_data/change_email/otp_email");
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return DialogWidgetYesNo(
                          urlIcon:
                              "assets/images/icon_sukses_reset_password.png",
                          title: "Are you sure?",
                          subtitle:
                              "You'll need to re-log in after changing email",
                          textForButtonYes: "Proceed",
                          textForButtonNo: "No",
                          navigatorFunctionYes: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const LoadingOverlay();
                              },
                            );
                            if (_newEmailController.text ==
                                _confirmEmailController.text) {
                              await _updateEmail
                                  .call(
                                      paramsOne: _newEmailController.text,
                                      paramsTwo: _passwordController.text)
                                  .then((res) {
                                switch (res) {
                                  case "wrong-password":
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogWidget(
                                          urlIcon:
                                              "assets/images/logo_delete_account.png",
                                          title: "Wrong Password",
                                          subtitle:
                                              "Wrong password provided for that user.",
                                          textForButton: "Close",
                                          navigatorFunction: () {
                                            context.pop();
                                            context.pop();
                                            context.pop();
                                          }),
                                    );
                                    break;
                                  case "invalid-email":
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogWidget(
                                          urlIcon:
                                              "assets/images/logo_delete_account.png",
                                          title: "Email is invalid",
                                          subtitle:
                                              "The email you type is invalid",
                                          textForButton: "Close",
                                          navigatorFunction: () {
                                            context.pop();
                                            context.pop();
                                            context.pop();
                                          }),
                                    );
                                    break;
                                  case "email-already-in-use":
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogWidget(
                                          urlIcon:
                                              "assets/images/logo_delete_account.png",
                                          title: "Email already in use",
                                          subtitle: "The email is already used",
                                          textForButton: "Close",
                                          navigatorFunction: () {
                                            context.pop();
                                            context.pop();
                                            context.pop();
                                          }),
                                    );
                                    break;
                                  case "requires-recent-login":
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogWidget(
                                          urlIcon:
                                              "assets/images/logo_delete_account.png",
                                          title: "Requires recent login",
                                          subtitle: "You need to re-login",
                                          textForButton: "Close",
                                          navigatorFunction: () {
                                            context.pop();
                                            context.pop();
                                            context.pop();
                                          }),
                                    );

                                    break;
                                  default:
                                    authBloc.add(const LogOut());
                                    context.go("/");
                                }
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => DialogWidget(
                                    urlIcon:
                                        "assets/images/logo_delete_account.png",
                                    title: "Confirm email does not match",
                                    subtitle:
                                        "New email and confirm email need to be match",
                                    textForButton: "Close",
                                    navigatorFunction: () {
                                      context.pop();
                                      context.pop();
                                      context.pop();
                                    }),
                              );
                            }
                          },
                          navigatorFunctionNo: () {
                            context.pop();
                          });
                      // return DialogWidget(
                      //     urlIcon: "assets/images/icon_sukses_reset_password.png",
                      //     title: "Are you sure?",
                      //     subtitle:
                      //         "You'll need to re-log in after changing email",
                      //     textForButton: "Proceed",
                      //     navigatorFunction: () async {
                      //       context.pop();
                      //       showDialog(
                      //         context: context,
                      //         builder: (context) {
                      //           return const LoadingOverlay();
                      //         },
                      //       );
                      //       if (_newEmailController.text ==
                      //           _confirmEmailController.text) {
                      //         await _updateEmail
                      //             .call(param: _newEmailController.text)
                      //             .then((res) {
                      //           switch (res) {
                      //             case "invalid-email":
                      //               showDialog(
                      //                 context: context,
                      //                 builder: (context) => DialogWidget(
                      //                     urlIcon:
                      //                         "assets/images/logo_delete_account.png",
                      //                     title: "Email is invalid",
                      //                     subtitle:
                      //                         "The email you type is invalid",
                      //                     textForButton: "Close",
                      //                     navigatorFunction: () {
                      //                       context.pop();
                      //                       context.pop();
                      //                     }),
                      //               );
                      //               break;
                      //             case "email-already-in-use":
                      //               showDialog(
                      //                 context: context,
                      //                 builder: (context) => DialogWidget(
                      //                     urlIcon:
                      //                         "assets/images/logo_delete_account.png",
                      //                     title: "Email already in use",
                      //                     subtitle: "The email is already used",
                      //                     textForButton: "Close",
                      //                     navigatorFunction: () {
                      //                       context.pop();
                      //                       context.pop();
                      //                     }),
                      //               );
                      //               break;
                      //             case "requires-recent-login":
                      //               showDialog(
                      //                 context: context,
                      //                 builder: (context) => DialogWidget(
                      //                     urlIcon:
                      //                         "assets/images/logo_delete_account.png",
                      //                     title: "Requires recent login",
                      //                     subtitle: "You need to re-login",
                      //                     textForButton: "Close",
                      //                     navigatorFunction: () {
                      //                       context.pop();
                      //                       context.pop();
                      //                     }),
                      //               );

                      //               break;
                      //             default:
                      //               authBloc.add(const LogOut());
                      //               // context.pop();
                      //               context.go("/");
                      //           }
                      //         });
                      //       } else {
                      //         showDialog(
                      //           context: context,
                      //           builder: (context) => DialogWidget(
                      //               urlIcon:
                      //                   "assets/images/logo_delete_account.png",
                      //               title: "Confirm email does not match",
                      //               subtitle:
                      //                   "New email and confirm email need to be match",
                      //               textForButton: "Close",
                      //               navigatorFunction: () {
                      //                 context.pop();
                      //               }),
                      //         );
                      //       }
                      //     });
                    },
                  );
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
