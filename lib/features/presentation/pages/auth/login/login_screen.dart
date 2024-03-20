import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:linkedin_login/linkedin_login.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_event.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:mytradeasia/helper/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';

import '../../../../../config/themes/theme.dart';
import '../../../widgets/loading_overlay_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _connection = true;

  final dio = Dio();

  UserObject? user;
  bool logoutUser = false;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  final _linkedInConfig = LinkedInConfig(
    clientId: '77pv0j45iro4cd',
    clientSecret: 'LQKSW66VfAIrulyQ',
    redirectUrl: 'http://localhost:8080/callback',
    scope: ['openid', 'profile', 'email'],
  );
  LinkedInUser? linkedInUser;

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
    _phoneNumberController.dispose();
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
                          controller: _phoneNumberController,
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
                  // forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          /* With go_route */
                          context.go("/auth/login/forgot_password");
                        },
                        child: Text(
                          "Forgot Password?",
                          style: body1Regular.copyWith(color: secondaryColor1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55.0,
                    child: _emailController.text.isNotEmpty &&
                            _phoneNumberController.text.isNotEmpty
                        ? BlocBuilder<AuthBloc, AuthState>(
                            builder: (_, state) => ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryColor1),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _connection = !_connection;
                                  });
                                  authBloc.add(LoginWithEmail(
                                      _emailController.text,
                                      _phoneNumberController.text,
                                      context));
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
                                  MaterialStateProperty.all<Color>(greyColor),
                              shape: MaterialStateProperty.all<
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: size20px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(thickness: 2, color: greyColor3),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 31.0),
                          child: Text("or sign in with", style: body1Regular),
                        ),
                        Expanded(
                          child: Divider(thickness: 2, color: greyColor3),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 160.0,
                          height: 55.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(whiteColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  side: const BorderSide(color: primaryColor1),
                                ),
                              ),
                            ),
                            child: Image.asset(
                              "assets/images/logo_google.png",
                              width: size20px + 4,
                            ),
                            onPressed: () async {
                              UserCredential userCred =
                                  await signInWithGoogle();

                              bool userExists =
                                  await checkIfUserExists(userCred.user!.uid);
                              if (userExists) {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString(
                                    "email", userCred.user!.email!);
                                await prefs.setString(
                                    "userId", userCred.user!.uid);
                                await prefs.setBool("isLoggedIn", true);
                                showGoogleSSOSnackbar(context);
                                context.go("/home");
                              } else {
                                context.pushReplacement(
                                    "/auth/register/sso-biodata");
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: size20px - 4.0),
                      Expanded(
                        child: SizedBox(
                          width: size20px * 8,
                          height: 55.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(whiteColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  side: const BorderSide(color: primaryColor1),
                                ),
                              ),
                            ),
                            child: Image.asset(
                              "assets/images/logo_linkedin.png",
                              width: size20px + 10,
                            ),
                            onPressed: () {
                              SignInWithLinkedIn.signIn(
                                context,
                                config: _linkedInConfig,
                                onGetUserProfile: (tokenData, user) async {
                                  log('Auth token data: ${tokenData.toJson()}');
                                  log('LinkedIn User: ${user.toJson()}');
                                  setState(() => linkedInUser = user);
                                  final url =
                                      'https://linkedin-firebase-auth-integrator.vercel.app/token';

                                  final headers = {
                                    'Content-Type': 'application/json',
                                  };

                                  final body = {
                                    "accessToken": tokenData.accessToken,
                                    "uid": linkedInUser?.sub
                                  };

                                  log("REQ BODY : ${body}");

                                  try {
                                    final response = await dio.post(
                                      url,
                                      data: body,
                                      options: Options(headers: headers),
                                    );
                                    if (response.statusCode == 200) {
                                      log("Success : ${response.data}");
                                      final userCredential = await FirebaseAuth
                                          .instance
                                          .signInWithCustomToken(
                                              response.data['firebaseToken']);
                                      log("User Credential : ${userCredential.user.toString()}");
                                      FirebaseAuth.instance
                                          .authStateChanges()
                                          .listen((User? user) async {
                                        if (user != null) {
                                          await user.updateEmail(
                                              linkedInUser!.email!);
                                          await user.updateDisplayName(
                                              linkedInUser!.name);
                                        }
                                      });
                                      log("Name : ${FirebaseAuth.instance.currentUser?.displayName}");
                                      bool userExists = await checkIfUserExists(
                                          userCredential.user!.uid);
                                      if (userExists) {
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setString("email",
                                            userCredential.user!.email!);
                                        await prefs.setString(
                                            "userId", userCredential.user!.uid);
                                        await prefs.setBool("isLoggedIn", true);
                                        showLinkedinSSOSnackbar(context);
                                        context.go("/home");
                                      } else {
                                        context.pushReplacement(
                                            "/auth/register/sso-biodata");
                                      }
                                    } else {
                                      log("Error ${response.statusCode} : ${response.data}");
                                    }
                                  } on DioException catch (e) {
                                    log("ERROR HERE : ${e.stackTrace}");

                                    // var snackbar = SnackBar(
                                    //   content: Text("Dio Error : ${e.message}"),
                                    //   backgroundColor: yellowColor,
                                    // );
                                    // ScaffoldMessenger.of(context)
                                    //     .showSnackBar(snackbar);
                                  } on FirebaseAuthException catch (e) {
                                    log("ERROR HERE : ${e}");

                                    var snackbar = SnackBar(
                                      content:
                                          Text("Firebase Error : ${e.message}"),
                                      backgroundColor: yellowColor,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  }

                                  setState(() {
                                    logoutUser = false;
                                  });

                                  // Navigator.pop(context);
                                },
                                onSignInError: (error) {
                                  log('Error on sign in: $error');
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: size20px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have an account?",
                        style: body1Regular,
                      ),
                      TextButton(
                        onPressed: () {
                          context.go("/auth/register");
                        },
                        child: Text("Sign up here",
                            style:
                                body1Regular.copyWith(color: secondaryColor1)),
                      ),
                    ],
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
