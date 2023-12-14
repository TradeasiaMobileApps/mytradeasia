import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/otp_usecases/send_otp.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_snapshot.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_event.dart';
import 'package:mytradeasia/features/presentation/widgets/dialog_sheet_widget.dart';
import 'package:mytradeasia/features/presentation/widgets/mytradeasia_widget.dart';
import 'package:mytradeasia/helper/helper_functions.dart';
import 'package:mytradeasia/helper/injections_container.dart';

class MyTradeAsiaScreen extends StatefulWidget {
  const MyTradeAsiaScreen({super.key});

  @override
  State<MyTradeAsiaScreen> createState() => _MyTradeAsiaScreenState();
}

class _MyTradeAsiaScreenState extends State<MyTradeAsiaScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final GetUserSnapshot _getUserSnapshot = injections<GetUserSnapshot>();
  final SendOTP _sendOTP = injections<SendOTP>();
  final _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      key: _scaffoldMessengerKey,
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Tradeasia",
          style: heading2,
        ),
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder(
              stream: _getUserSnapshot.call(),
              builder: (context, AsyncSnapshot streamSnapshot) {
                return streamSnapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator.adaptive(
                        backgroundColor: primaryColor1,
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            // Header
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: size20px + 10.0),
                              child: Row(
                                children: [
                                  // Image
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: size20px),
                                      child: Image.asset(
                                        "assets/images/profile_picture.png",
                                        width: size20px * 3.6,
                                      )),
                                  // First, Last, Company Name
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height: size20px * 3,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${streamSnapshot.data['firstName'] == "" ? "new" : streamSnapshot.data['firstName']} ${streamSnapshot.data['lastName'] == "" ? "user" : streamSnapshot.data['lastName']}",
                                                  style: text16,
                                                ),
                                                Text(
                                                  streamSnapshot.data[
                                                          'companyName'] ??
                                                      "",
                                                  style: text15.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: greyColor2),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            // personal data menu
                            MyTradeAsiaWidget(
                                nama: "Personal data",
                                urlIcon: "assets/images/icon_profile.png",
                                onPressedFunction: () {
                                  context.go("/mytradeasia/personal_data");
                                }),

                            // change password menu
                            FutureBuilder(
                                future: isSSOAuth(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  }

                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (snapshot.data == true) {
                                    return Container();
                                  }
                                  return MyTradeAsiaWidget(
                                    nama: "Change Password",
                                    urlIcon: "assets/images/icon_password.png",
                                    onPressedFunction: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible:
                                            false, // Prevents the dialog from closing on tap outside
                                        builder: (context) => const Center(
                                            child:
                                                CircularProgressIndicator()), // Loading indicator
                                      );

                                      try {
                                        var result = await _sendOTP.call(
                                            param: _auth.currentUser!.email!);
                                        // Navigator.of(context).pop();

                                        if (result is DataSuccess) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration: const Duration(
                                                  seconds: 2,
                                                  milliseconds: 500),
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                "OTP code sent to : ${_auth.currentUser!.email!}",
                                                style: body1Regular.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          );
                                          context.go(
                                              "/mytradeasia/change_password_otp",
                                              extra: _auth.currentUser!.email!);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration: const Duration(
                                                  seconds: 2,
                                                  milliseconds: 500),
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "Failed to send OTP. Please try again.",
                                                style: body1Regular.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        // Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Error occurred: $e"),
                                          ),
                                        );
                                      } finally {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      }
                                    },
                                  );
                                }),

                            // settings menu
                            MyTradeAsiaWidget(
                              nama: "Settings",
                              urlIcon: "assets/images/icon_setting.png",
                              onPressedFunction: () =>
                                  context.go("/mytradeasia/settings"),
                            ),

                            // language menu
                            MyTradeAsiaWidget(
                                nama: "Language",
                                urlIcon: "assets/images/icon_language.png",
                                onPressedFunction: () {
                                  context.go("/mytradeasia/language");
                                }),

                            // my cart menu
                            streamSnapshot.data['role'] == "Sales"
                                ? Container()
                                : MyTradeAsiaWidget(
                                    nama: "My Cart",
                                    urlIcon: "assets/images/icon_mycart.png",
                                    onPressedFunction: () {
                                      context.push("/mytradeasia/cart");
                                    }),

                            // quotations menu
                            MyTradeAsiaWidget(
                                nama: "Quotations",
                                urlIcon: "assets/images/icon_quotation.png",
                                onPressedFunction: () {
                                  if (streamSnapshot.data['role'] == "Sales") {
                                    context.go("/mytradeasia/sales_quotations");
                                  } else {
                                    context.go("/mytradeasia/quotations");
                                  }
                                }),

                            // contact us menu
                            MyTradeAsiaWidget(
                              nama: "Contact Us",
                              urlIcon: "assets/images/icon_cs.png",
                              onPressedFunction: () {
                                context.go("/mytradeasia/contact_us");
                              },
                            ),

                            // faq menu
                            MyTradeAsiaWidget(
                              nama: "FAQs",
                              urlIcon: "assets/images/icon_faq.png",
                              onPressedFunction: () {
                                context.go("/mytradeasia/faq");
                              },
                            ),

                            // Version menu
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: size20px * 0.75, left: 10),
                                      child: Image.asset(
                                        "assets/images/icon_version.png",
                                        width: size20px * 2,
                                      ),
                                    ),
                                    const Text(
                                      "Version",
                                      style: text12,
                                    ),
                                    const Spacer(),
                                    const Padding(
                                      padding: EdgeInsets.only(right: size20px),
                                      child: Text(
                                        "V 1.0.0",
                                        style: text12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // sign out button
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: size20px + 10.0, bottom: size20px),
                              child: SizedBox(
                                height: 55.0,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor1),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogWidgetYesNo(
                                            urlIcon:
                                                "assets/images/logo_logout.png",
                                            title:
                                                "Are you sure want to log out?",
                                            subtitle:
                                                'You need to insert Email and Password again',
                                            textForButtonYes: "Yes",
                                            textForButtonNo: "No",
                                            navigatorFunctionNo: () =>
                                                Navigator.pop(context),
                                            navigatorFunctionYes: () {
                                              // providerOut.logout(context);
                                              authBloc.add(const LogOut());

                                              /* With go_route */
                                              context.go("/auth");
                                            });
                                      },
                                    );
                                  },
                                  child: const Text("Logout"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
        ),
      ),
    );
  }
}
