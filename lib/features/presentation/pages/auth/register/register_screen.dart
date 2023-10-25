import 'dart:developer';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/phone_authentication.dart';
import 'package:mytradeasia/helper/helper_functions.dart';
import 'package:mytradeasia/helper/injections_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../config/routes/parameters.dart';
import '../../../../../config/themes/theme.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  String countryNum = '+62';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final PhoneAuthentication _phoneAuthentication =
      injections<PhoneAuthentication>();

  final dio = Dio();

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

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

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(size20px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 159.0,
                      height: 65.0,
                      child: Image.asset("assets/images/logo_biru.png"),
                    ),
                  ),
                  const SizedBox(height: 50.48),
                  const Text("Sign Up Here", style: heading1),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet consectetur. Quam non commodo nulla ac condimentum ornare turpis.",
                    style: body1Regular.copyWith(color: fontColor2),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),

                        //Email
                        const Text(
                          "Email",
                          style: heading3,
                        ),
                        const SizedBox(height: 8),

                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (emailValidator) {
                            if (emailValidator!.isEmpty) {
                              return "Email is empty";
                            }
                            return null;
                          },
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
                        const SizedBox(
                          height: 15,
                        ),

                        // Phone Number
                        const Text(
                          "Phone Number",
                          style: heading3,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: greyColor3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: CountryCodePicker(
                                  onChanged: (element) =>
                                      countryNum = element.dialCode.toString(),
                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                  initialSelection: 'ID',
                                  favorite: const ['ID', 'UK'],
                                  // optional. Shows only country name and flag
                                  showCountryOnly: false,
                                  showFlag: true,
                                  hideMainText: true,
                                  // optional. Shows only country name and flag when popup is closed.
                                  showOnlyCountryWhenClosed: false,
                                  // optional. aligns the flag and the Text left
                                  // alignLeft: false,
                                  padding: EdgeInsets.only(left: 5),
                                ),
                              ),
                              // InkWell(
                              //   onTap: () => Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             const LanguagesScreen(),
                              //       )),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       border: Border.all(color: greyColor3),
                              //       borderRadius: const BorderRadius.all(
                              //         Radius.circular(7.0),
                              //       ),
                              //     ),
                              //     width: 60,
                              //     height: 50,
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(size20px / 2),
                              //       child: Image.asset(
                              //         "assets/images/logo_indonesia.png",
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                            const SizedBox(
                              width: size20px / 2,
                            ),
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _phoneNumberController,
                                decoration: InputDecoration(
                                  hintText: "Enter your phone number",
                                  hintStyle: body1Regular.copyWith(
                                      color: greyColor,
                                      fontWeight: FontWeight.w400),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  border: const OutlineInputBorder(),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: greyColor3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0))),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: secondaryColor1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                          checkColor: primaryColor1,
                          activeColor: Colors.transparent,
                          side: const BorderSide(
                              color: primaryColor1, width: 2.0),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: RichText(
                          text: TextSpan(
                              text: "I've read, understood and agree to the ",
                              style: body1Medium,
                              children: [
                                TextSpan(
                                  text: "Privacy Policy",
                                  style:
                                      text12.copyWith(color: secondaryColor1),
                                ),
                                const TextSpan(
                                  text: " and ",
                                  style: text12,
                                ),
                                TextSpan(
                                  text: "Terms and Conditions",
                                  style:
                                      text12.copyWith(color: secondaryColor1),
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55.0,
                    child: isChecked == true &&
                            _emailController.text.isNotEmpty &&
                            _phoneNumberController.text.isNotEmpty
                        ? ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor1),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              List<String> userSignInMethods =
                                  await _auth.fetchSignInMethodsForEmail(
                                      _emailController.text);
                              if (userSignInMethods.first != "password") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "Account already signed up with SSO",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(milliseconds: 1500),
                                  backgroundColor: Colors.redAccent,
                                ));
                              } else {
                                OtpVerificationParameter param =
                                    OtpVerificationParameter(
                                        phone: _phoneNumberController.text,
                                        email: _emailController.text);
                                //TODO: captcha OTP
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return const LoadingOverlay();
                                //   },
                                // );
                                await _phoneAuthentication
                                    .call(
                                        param:
                                            "$countryNum${_phoneNumberController.text}")
                                    .then((value) {
                                  if (value == "invalid-phone-number") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Invalid Phone Number"),
                                      duration: Duration(milliseconds: 300),
                                    ));
                                  } else if (value ==
                                      "verification-completed") {
                                    context.go("/auth/register/otp-register",
                                        extra: param);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("There seem to be an error"),
                                      duration: Duration(milliseconds: 300),
                                    ));
                                  }
                                });
                                context.go("/auth/register/otp-register",
                                    extra: param);
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: text16.copyWith(color: whiteColor),
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
                              "Sign Up",
                              style: text16.copyWith(color: whiteColor),
                            ),
                          ),
                  ),
                  const SizedBox(height: size20px),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: greyColor3,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 31.0),
                        child: Text("or sign up with", style: body1Regular),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: greyColor3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: size20px),
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
                              log("User Cred : ${userCred.user!.uid}");
                              log("User Cred : ${userCred.user!.email}");
                              log("User Cred : ${userCred.user!.displayName?.split(" ")}");
                              log("User Cred : ${userCred.user!.toString()}");

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
                      const SizedBox(width: 16.0),
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
                                    side:
                                        const BorderSide(color: primaryColor1)),
                              ),
                            ),
                            child: Image.asset(
                              "assets/images/logo_linkedin.png",
                              width: size20px + 10,
                            ),
                            onPressed: () {
                              setState(() {
                                user = null;
                                logoutUser = true;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (final BuildContext context) =>
                                      LinkedInUserWidget(
                                    appBar: AppBar(
                                      title: const Text('OAuth User'),
                                    ),
                                    destroySession: logoutUser,
                                    redirectUrl:
                                        "http://localhost:8080/callback",
                                    clientId: "77pv0j45iro4cd",
                                    clientSecret: "LQKSW66VfAIrulyQ",
                                    projection: const [
                                      ProjectionParameters.id,
                                      ProjectionParameters.localizedFirstName,
                                      ProjectionParameters.localizedLastName,
                                      ProjectionParameters.firstName,
                                      ProjectionParameters.lastName,
                                      ProjectionParameters.profilePicture,
                                    ],
                                    onError: (final UserFailedAction e) {
                                      print('Error: ${e.toString()}');
                                      print(
                                          'Error: ${e.stackTrace.toString()}');
                                    },
                                    onGetUserProfile: (final UserSucceededAction
                                        linkedInUser) async {
                                      print(
                                        'Access token ${linkedInUser.token.accessToken?.accessToken}',
                                      );

                                      print(
                                          'User : ${linkedInUser.user.toJson()}');

                                      user = UserObject(
                                        firstName: linkedInUser.user.givenName,
                                        lastName: linkedInUser.user.familyName,
                                        email: linkedInUser.user.email,
                                        profileImageUrl:
                                            linkedInUser.user.picture,
                                      );

                                      final url =
                                          'https://linkedin-firebase-auth-integrator.vercel.app/token';

                                      final headers = {
                                        'Content-Type': 'application/json',
                                      };

                                      final body = {
                                        "accessToken": linkedInUser
                                            .token.accessToken?.accessToken,
                                        "uid": linkedInUser.user.sub
                                      };

                                      try {
                                        final response = await dio.post(
                                          url,
                                          data: body,
                                          options: Options(headers: headers),
                                        );
                                        if (response.statusCode == 200) {
                                          log("Success : ${response.data}");
                                          final userCredential =
                                              await FirebaseAuth.instance
                                                  .signInWithCustomToken(
                                                      response.data[
                                                          'firebaseToken']);
                                          log("User Credential : ${userCredential.user.toString()}");
                                          FirebaseAuth.instance
                                              .authStateChanges()
                                              .listen((User? user) async {
                                            if (user != null) {
                                              await user.updateEmail(
                                                  linkedInUser.user.email!);
                                              await user.updateDisplayName(
                                                  linkedInUser.user.name!);
                                            }
                                          });
                                          log("Name : ${FirebaseAuth.instance.currentUser?.displayName}");
                                          bool userExists =
                                              await checkIfUserExists(
                                                  userCredential.user!.uid);
                                          if (userExists) {
                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.setString("email",
                                                userCredential.user!.email!);
                                            await prefs.setString("userId",
                                                userCredential.user!.uid);
                                            await prefs.setBool(
                                                "isLoggedIn", true);
                                            showLinkedinSSOSnackbar(context);
                                            context.go("/home");
                                          } else {
                                            context.pushReplacement(
                                                "/auth/register/sso-biodata");
                                          }
                                        } else {
                                          log("Error ${response.statusCode} : ${response.data}");
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        log("Firebase Error : ${e.message}");
                                      }

                                      setState(() {
                                        logoutUser = false;
                                      });

                                      Navigator.pop(context);
                                    },
                                  ),
                                  fullscreenDialog: true,
                                ),
                              );
                              // const snackbar = SnackBar(
                              //   content:
                              //       Text("Linkedin is not available right now"),
                              //   backgroundColor: yellowColor,
                              // );
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(snackbar);
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
                        "Have an account?",
                        style: body1Medium,
                      ),
                      TextButton(
                        onPressed: () {
                          /* With go_route */
                          context.go("/auth/login");

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return const LoginScreen();
                          //     },
                          //   ),
                          // );
                        },
                        child: Text("Sign in here",
                            style:
                                body1Medium.copyWith(color: secondaryColor1)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // if (valueLoading.isLoading)
            //   SizedBox(
            //     width: double.infinity,
            //     height: MediaQuery.of(context).size.height,
            //     child: const LoadingOverlay(),
            //   ),
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
