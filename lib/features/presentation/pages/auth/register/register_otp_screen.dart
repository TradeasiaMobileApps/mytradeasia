import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/otp_usecases/send_otp.dart';
import 'package:mytradeasia/features/domain/usecases/otp_usecases/verify_otp.dart';
import 'package:mytradeasia/helper/helper_functions.dart';
import 'package:mytradeasia/helper/injections_container.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../../../../config/themes/theme.dart';
import '../../../widgets/dialog_sheet_widget.dart';

class RegisterOtpScreen extends StatefulWidget {
  const RegisterOtpScreen(
      {super.key, required this.phone, required this.email});

  final String phone;
  final String email;

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  final TextEditingController _digit1Controller = TextEditingController();
  final TextEditingController _digit2Controller = TextEditingController();
  final TextEditingController _digit3Controller = TextEditingController();
  final TextEditingController _digit4Controller = TextEditingController();
  final TextEditingController _digit5Controller = TextEditingController();
  final TextEditingController _digit6Controller = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final VerifyOTP _verifyOTP = injections<VerifyOTP>();
  final SendOTP _sendOTP = injections<SendOTP>();
  bool isSendingOTP = false;
  bool isVerifying = false;
  bool canResend = false;

  @override
  void dispose() {
    _digit1Controller.dispose();
    _digit2Controller.dispose();
    _digit3Controller.dispose();
    _digit4Controller.dispose();
    _digit5Controller.dispose();
    _digit6Controller.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    super.dispose();
  }

  //TODO:masih pake firebase
  // final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 45 + 38),
              Center(
                child: Image.asset(
                  "assets/images/logo_change_email_verif.png",
                  width: 150.0,
                  height: 109.0,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "OTP Verification",
                style: text22,
              ),
              const SizedBox(height: 5),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    "Enter the OTP sent to ",
                    style: text12,
                  ),
                  Text(
                    widget.email,
                    style: text12.copyWith(color: secondaryColor1),
                  )
                ],
              ),
              const SizedBox(height: 40),
              // FORM OTP
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _digit1Controller,
                        focusNode: _focusNode1,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode1.unfocus();
                            _focusNode2.requestFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                          border: OutlineInputBorder(),
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor1),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a digit';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _digit2Controller,
                        focusNode: _focusNode2,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode2.unfocus();
                            _focusNode3.requestFocus();
                          } else {
                            _focusNode1.requestFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                          border: OutlineInputBorder(),
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor1),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a digit';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _digit3Controller,
                        focusNode: _focusNode3,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode3.unfocus();
                            _focusNode4.requestFocus();
                          } else {
                            _focusNode2.requestFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                          border: OutlineInputBorder(),
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor1),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a digit';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _digit4Controller,
                        focusNode: _focusNode4,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode4.unfocus();
                            _focusNode5.requestFocus();
                          } else {
                            _focusNode3.requestFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                          border: OutlineInputBorder(),
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor1),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a digit';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _digit5Controller,
                        focusNode: _focusNode5,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode5.unfocus();
                            _focusNode6.requestFocus();
                          } else {
                            _focusNode4.requestFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                          border: OutlineInputBorder(),
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor1),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a digit';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _digit6Controller,
                        focusNode: _focusNode6,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode6.unfocus();
                          } else {
                            _focusNode5.requestFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                          border: OutlineInputBorder(),
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor1),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a digit';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: isVerifying
                    ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(greyColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                        onPressed: null,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              _digit1Controller.text.isNotEmpty &&
                                      _digit2Controller.text.isNotEmpty &&
                                      _digit3Controller.text.isNotEmpty &&
                                      _digit4Controller.text.isNotEmpty &&
                                      _digit5Controller.text.isNotEmpty &&
                                      _digit6Controller.text.isNotEmpty
                                  ? primaryColor1
                                  : greyColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                        onPressed: _digit1Controller.text.isNotEmpty &&
                                _digit2Controller.text.isNotEmpty &&
                                _digit3Controller.text.isNotEmpty &&
                                _digit4Controller.text.isNotEmpty &&
                                _digit5Controller.text.isNotEmpty &&
                                _digit6Controller.text.isNotEmpty
                            ? () async {
                                String otpCode = _digit1Controller.text +
                                    _digit2Controller.text +
                                    _digit3Controller.text +
                                    _digit4Controller.text +
                                    _digit5Controller.text +
                                    _digit6Controller.text;
                                BiodataParameter param = BiodataParameter(
                                    email: widget.email, phone: widget.phone);
                                setState(() {
                                  isVerifying = true;
                                });
                                await _verifyOTP
                                    .call(
                                        paramsOne: otpCode,
                                        paramsTwo: widget.email)
                                    .then((value) {
                                  if (value is DataSuccess) {
                                    context.pushReplacement(
                                        "/auth/register/biodata",
                                        extra: param);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogWidget(
                                            urlIcon:
                                                "assets/images/logo_email_change.png",
                                            title:
                                                "OTP code wrong/already expired",
                                            subtitle:
                                                "Lorem ipsum dolor sit amet consectetur. Egestas porttitor risus enim cursus rutrum molestie tortor",
                                            textForButton: "Close",
                                            navigatorFunction: () {
                                              /* With go_route */
                                              context.pop();
                                            });
                                      },
                                    );
                                  }
                                });
                                setState(() {
                                  isVerifying = false;
                                });
                                // await _verifyOtp.call(param: otpCode).then((value) {
                                //   if (value) {
                                //     context.pushReplacement("/auth/register/biodata",
                                //         extra: param);
                                //   } else {
                                //     showDialog(
                                //       context: context,
                                //       builder: (context) {
                                //         return DialogWidget(
                                //             urlIcon:
                                //                 "assets/images/logo_email_change.png",
                                //             title: "OTP code wrong/already expired",
                                //             subtitle:
                                //                 "Lorem ipsum dolor sit amet consectetur. Egestas porttitor risus enim cursus rutrum molestie tortor",
                                //             textForButton: "Close",
                                //             navigatorFunction: () {
                                //               /* With go_route */
                                //               context.pop();
                                //             });
                                //       },
                                //     );
                                //   }
                                // });
                              }
                            : null,
                        child: Text(
                          "Verify",
                          style: text16.copyWith(color: whiteColor),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(canResend
                      ? "Don't receive the OTP code? "
                      : "Resend code in "),
                  canResend
                      ? TextButton(
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center,
                          ),
                          onPressed: isSendingOTP
                              ? null
                              : () async {
                                  setState(() {
                                    isSendingOTP = true;
                                  });
                                  await _sendOTP
                                      .call(param: widget.email)
                                      .then((value) => {
                                            if (value is DataSuccess)
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  duration: const Duration(
                                                      seconds: 2,
                                                      milliseconds: 500),
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "OTP code sent to : ${widget.email}",
                                                    style:
                                                        body1Regular.copyWith(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ))
                                              }
                                          });
                                  setState(() {
                                    isSendingOTP = false;
                                    canResend = false;
                                  });
                                },
                          child: isSendingOTP
                              ? const Center(
                                  child: SizedBox(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                    height: 10.0,
                                    width: 10.0,
                                  ),
                                )
                              : Text("Resend",
                                  style:
                                      text14.copyWith(color: secondaryColor1)),
                        )
                      : Countdown(
                          seconds: 60,
                          build: (BuildContext context, double time) => Text(
                              parseDoubleToIntegerIfNecessary(time).toString(),
                              style: text14.copyWith(color: secondaryColor1)),
                          interval: Duration(milliseconds: 1000),
                          onFinished: () {
                            setState(() {
                              canResend = true;
                            });
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
