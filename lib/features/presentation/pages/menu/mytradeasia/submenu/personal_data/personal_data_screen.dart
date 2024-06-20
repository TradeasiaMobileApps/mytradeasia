import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/otp_usecases/send_otp.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_snapshot.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/update_profile.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:mytradeasia/helper/helper_functions.dart';
import 'package:mytradeasia/helper/injections_container.dart';

import '../../../../../widgets/dialog_sheet_widget.dart';
import '../../../../../widgets/text_editing_widget.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String countryNum = '+62';
  Map<String, dynamic> user = {};

  Uint8List? _imageFile;
  String? profilePicUrl;
  final ImagePicker _picker = ImagePicker();

  final GetUserSnapshot _getUserSnapshot = injections<GetUserSnapshot>();
  final UpdateProfile _updateProfile = injections<UpdateProfile>();
  final SendOTP _sendOTP = injections<SendOTP>();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateMyProfile(
      String uid, Map<String, dynamic> user, Uint8List? image) {
    if (_firstNameController.text != "" ||
        _lastNameController.text != "" ||
        _companyNameController.text != "" ||
        _phoneNumberController.text != "" ||
        _imageFile != null) {
      Map<String, dynamic> data = {
        'firstName': _firstNameController.text != ""
            ? _firstNameController.text
            : user["firstName"],
        'lastName': _lastNameController.text != ""
            ? _lastNameController.text
            : user["lastName"],
        'companyName': _companyNameController.text != ""
            ? _companyNameController.text
            : user["company"],
        'phone': _phoneNumberController.text != ""
            ? countryNum + _phoneNumberController.text
            : user["phone"],
        'uid': uid,
        'image': image,
      };

      _updateProfile.call(param: data).then((value) {
        if (value == "success") {
          showDialog(
            context: context,
            builder: (context) {
              return DialogWidget(
                  urlIcon: "assets/images/logo_email_change.png",
                  title: "Personal Data has been Change",
                  subtitle:
                      "Lorem ipsum dolor sit amet consectetur. Egestas porttitor risus enim cursus rutrum molestie tortor",
                  textForButton: "Back to My Tradeasia",
                  navigatorFunction: () {
                    /* With go_route */
                    context.go("/home");
                    context.pop();
                  });
            },
          );
        }
        if (value == "error") {
          showDialog(
            context: context,
            builder: (context) {
              return DialogWidget(
                  urlIcon: "assets/images/logo_email_change.png",
                  title: "Error",
                  subtitle: "Something went wrong",
                  textForButton: "Back to My Tradeasia",
                  navigatorFunction: () {
                    /* With go_route */
                    // context.go("/home");
                    context.pop();
                  });
            },
          );
        }
      });
    }
  }

  void _takeImage() {
    XFile? imagePicked;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                InkWell(
                  onTap: () async {
                    imagePicked =
                        await _picker.pickImage(source: ImageSource.camera);
                    _imageFile = await imagePicked!.readAsBytes();
                    setState(() {});
                  },
                  child: const SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Icon(Icons.photo_camera),
                        Text(' Take picture from Camera '),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () async {
                    imagePicked =
                        await _picker.pickImage(source: ImageSource.gallery);
                    // print(_imageFile);
                    _imageFile = await imagePicked!.readAsBytes();
                    setState(() {});
                  },
                  child: const SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Icon(Icons.photo_library),
                        Text(' Browse from gallery '),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
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
        title: const Text(
          "Personal Data",
          style: text18,
        ),
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StreamBuilder<Object>(
                  stream: _getUserSnapshot.call(),
                  builder: (context, AsyncSnapshot streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      user = {
                        "firstName": streamSnapshot.data["firstName"],
                        "lastName": streamSnapshot.data["lastName"],
                        "phone": streamSnapshot.data["phone"] ?? "",
                        "company": streamSnapshot.data["companyName"],
                      };
                      // print(streamSnapshot.data["profilePicUrl"]);
                      return Column(
                        children: [
                          // Photo Profile
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: size20px + 8.0),
                            child: Center(
                              child: Stack(
                                children: [
                                  if (_imageFile == null)
                                    streamSnapshot.data["profilePicUrl"] ==
                                                null ||
                                            streamSnapshot
                                                    .data["profilePicUrl"] ==
                                                ""
                                        ? Container(
                                            decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: greyColor3),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            padding: const EdgeInsets.all(2),
                                            child: Image.asset(
                                              "assets/images/profile_picture.png",
                                              width: size20px * 3.6,
                                            ),
                                          )
                                        : Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: greyColor3),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            margin: const EdgeInsets.only(right: 3),
                                            child: CachedNetworkImage(
                                              imageUrl: streamSnapshot
                                                  .data["profilePicUrl"],
                                              width: size20px * 3.6,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ))
                                  else
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: greyColor3),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        padding: const EdgeInsets.all(2),
                                        child: Image(
                                          image: MemoryImage(_imageFile!),
                                          width: size20px * 3.6,
                                        )),
                                  Positioned.fill(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        onTap: () {
                                          _takeImage();
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: primaryColor1,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Icon(
                                        Icons.camera_alt_rounded,
                                        color: whiteColor,
                                        size: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          streamSnapshot.hasData
                              ? Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      // FIRST NAME + LAST NAME
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "First Name",
                                                  style: text14,
                                                ),
                                                const SizedBox(
                                                    height: size24px / 3),
                                                TextEditingWidget(
                                                    readOnly: false,
                                                    controller:
                                                        _firstNameController,
                                                    hintText: streamSnapshot
                                                            .hasData
                                                        ? streamSnapshot
                                                            .data["firstName"]
                                                        : ""),
                                              ],
                                            ),
                                          ),
                                          Expanded(flex: 1, child: Container()),
                                          Expanded(
                                            flex: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Last Name",
                                                  style: text14,
                                                ),
                                                const SizedBox(height: 8.0),
                                                TextEditingWidget(
                                                    readOnly: false,
                                                    controller:
                                                        _lastNameController,
                                                    hintText: streamSnapshot
                                                            .hasData
                                                        ? streamSnapshot
                                                            .data["lastName"]
                                                        : ""),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // PHONE NUMBER + Flag
                                      FutureBuilder(
                                          future: isSSOAuth(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Container();
                                            }

                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }

                                            if (snapshot.data == true) {
                                              return Container();
                                            }
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: size20px - 5.0,
                                                      bottom: size20px - 12.0),
                                                  child: Text(
                                                    "Phone Number",
                                                    style: text14,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 50,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          7),
                                                                ),
                                                                border: Border.all(
                                                                    color:
                                                                        greyColor3)),
                                                        child:
                                                            CountryCodePicker(
                                                          onChanged: (element) =>
                                                              countryNum = element
                                                                  .dialCode
                                                                  .toString(),
                                                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                          initialSelection:
                                                              streamSnapshot
                                                                          .data[
                                                                      "countryCode"] ??
                                                                  "ID",
                                                          favorite: const [
                                                            'ID',
                                                            'UK'
                                                          ],
                                                          // optional. Shows only country name and flag
                                                          showCountryOnly:
                                                              false,
                                                          showFlag: true,
                                                          hideMainText: true,
                                                          // optional. Shows only country name and flag when popup is closed.
                                                          showOnlyCountryWhenClosed:
                                                              false,
                                                          // optional. aligns the flag and the Text left
                                                          // alignLeft: false,
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  left: 5),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15.0),
                                                    Expanded(
                                                      flex: 5,
                                                      child: SizedBox(
                                                          width: size20px * 8.0,
                                                          height: size20px + 30,
                                                          child: TextFormField(
                                                              readOnly: false,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller:
                                                                  _phoneNumberController,
                                                              decoration:
                                                                  InputDecoration(
                                                                      hintText: streamSnapshot.data["phone"] !=
                                                                              ""
                                                                          ? streamSnapshot.data["phone"]
                                                                              .toString()
                                                                              .substring(
                                                                                  2)
                                                                          : "",
                                                                      hintStyle: body1Regular.copyWith(
                                                                          color:
                                                                              greyColor),
                                                                      contentPadding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              20.0),
                                                                      enabledBorder: const OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color:
                                                                                  greyColor3),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(7.0))),
                                                                      focusedBorder: const OutlineInputBorder(
                                                                          borderSide: BorderSide(color: greyColor3),
                                                                          borderRadius: BorderRadius.all(
                                                                            Radius.circular(7.0),
                                                                          ))))),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }),

                                      // COMPANY NAME
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: size20px - 5.0,
                                                bottom: size20px - 12.0),
                                            child: Text(
                                              "Company Name",
                                              style: text14,
                                            ),
                                          ),
                                          TextEditingWidget(
                                              readOnly: false,
                                              controller:
                                                  _companyNameController,
                                              hintText: streamSnapshot.hasData
                                                  ? streamSnapshot
                                                      .data["companyName"]
                                                  : ""),
                                        ],
                                      ),
                                      // Email with suffix
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: size20px - 5.0,
                                                bottom: size20px - 12.0),
                                            child: Text(
                                              "Email",
                                              style: text14,
                                            ),
                                          ),
                                          // EMAIL NAMEFIELD TEXT
                                          SizedBox(
                                            height: 50.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: FutureBuilder(
                                              future: isSSOAuth(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Container();
                                                }

                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                }

                                                if (snapshot.data == true) {
                                                  // Using SSO
                                                  return TextEditingWidget(
                                                      readOnly: true,
                                                      controller:
                                                          _emailController,
                                                      hintText: state.user !=
                                                              null
                                                          ? state.user!.email!
                                                          : _auth.currentUser!
                                                              .email!);
                                                }
                                                return TextEditingWithIconSuffix(
                                                  readOnly: true,
                                                  controller: _emailController,
                                                  hintText: state.user != null
                                                      ? state.user!.email!
                                                      : _auth
                                                          .currentUser!.email!,
                                                  imageUrl:
                                                      "assets/images/icon_forward.png",
                                                  navigationPage: () async {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible:
                                                          false, // Prevents the dialog from closing on tap outside
                                                      builder: (context) =>
                                                          const Center(
                                                              child:
                                                                  CircularProgressIndicator()), // Loading indicator
                                                    );

                                                    try {
                                                      var result =
                                                          await _sendOTP.call(
                                                              param: _auth
                                                                  .currentUser!
                                                                  .email!);

                                                      if (result
                                                          is DataSuccess) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 2,
                                                                    milliseconds:
                                                                        500),
                                                            backgroundColor:
                                                                Colors.green,
                                                            content: Text(
                                                              "OTP code sent to : ${_auth.currentUser!.email!}",
                                                              style: body1Regular.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        );
                                                        context.go(
                                                            "/mytradeasia/personal_data/change_email_otp",
                                                            extra: _auth
                                                                .currentUser!
                                                                .email!);
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 2,
                                                                    milliseconds:
                                                                        500),
                                                            backgroundColor:
                                                                Colors.red,
                                                            content: Text(
                                                              "Failed to send OTP. Please try again.",
                                                              style: body1Regular.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    } catch (e) {
                                                      // Navigator.of(context).pop();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Error occurred: $e"),
                                                        ),
                                                      );
                                                    } finally {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Container(
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
                  // print(state.user!.email);
                  _updateMyProfile(state.user!.uid!, user, _imageFile);
                },
                child: Text(
                  "Edit Personal Data",
                  style: text16.copyWith(color: whiteColor),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
