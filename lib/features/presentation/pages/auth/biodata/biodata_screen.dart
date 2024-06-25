// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_account_model.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';
import 'package:mytradeasia/features/domain/usecases/sales_force_data_usecases/create_sales_force_account.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_event.dart';
import 'package:mytradeasia/features/presentation/widgets/country_picker.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_data/salesforce_data_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_data/salesforce_data_event.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_login/salesforce_login_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_login/salesforce_login_event.dart';
import 'package:mytradeasia/helper/injections_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../config/themes/theme.dart';
import '../../../widgets/dialog_sheet_widget.dart';

class BiodataScreen extends StatefulWidget {
  const BiodataScreen({super.key, required this.email, required this.phone});

  final String email;
  final String phone;

  @override
  State<BiodataScreen> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final CreateSalesForceAccount _createSalesForceAccount =
      injections<CreateSalesForceAccount>();
  final _formKey = GlobalKey<FormState>();
  // final auth = FirebaseAuth.instance;
  String countryName = '';
  String countryCode = '';

  bool _passwordVisible = false;
  bool _isSubmiting = false;

  @override
  void initState() {
    _passwordVisible = false;
    var salesforceLoginBloc = BlocProvider.of<SalesforceLoginBloc>(context);
    salesforceLoginBloc.add(const LoginSalesforce());
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyNameController.dispose();
    _countryController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? passwordValidator(String? password) {
    // Check if the password is at least 8 characters long.
    // Check if the password contains a number.
    // Check if the password contains a lowercase letter.
    // Check if the password contains an uppercase letter.
    // Check if the password contains a special character.

    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$')
        .hasMatch(password!)) {
      return "The password must be at least 8 characters long and include a number, lowercase letter, uppercase letter and special character";
    }

    // If all of the above conditions are met, the password is valid.
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    var salesforceBloc = BlocProvider.of<SalesforceDataBloc>(context);

    handleSubmit() async {
      setState(() {
        _isSubmiting = true;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final role = prefs.getString("role") ?? "";
      final tokenSF = prefs.getString("tokenSF") ?? "";
      final sfForm = SalesforceCreateAccountForm(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: widget.email,
        country: _countryController.text,
        phone: widget.phone,
        role: role,
        company: _companyNameController.text,
      );
      _createSalesForceAccount
          .call(paramsOne: tokenSF, paramsTwo: sfForm)
          .then((value) {
        if (value is DataSuccess) {
          if (_formKey.currentState!.validate()) {
            authBloc.add(RegisterWithEmail(
                UserEntity(
                  sfAccountId: value.data!.sfAccountId,
                  sfContactId: value.data!.sfContactId,
                  companyName: _companyNameController.text,
                  country: _countryController.text,
                  email: widget.email,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  password: _passwordController.text,
                  phone: widget.phone,
                  role: role,
                  countryCode: countryCode == '' ? "+62" : countryCode,
                ),
                context, () {
              log("isSubmitting before : $_isSubmiting");

              setState(() {
                _isSubmiting = false;
              });
              log("isSubmitting after : $_isSubmiting");
            }));
          } else {
            setState(() {
              _isSubmiting = false;
            });
          }
        } else {
          log("salesforce account creation failed");
        }
      });
    }

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 55,
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
                    _isSubmiting ? null : handleSubmit();
                  },
                  child: _isSubmiting
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Create Account",
                          style: text16.copyWith(color: whiteColor),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 159.0,
                    height: 65.0,
                    child: Image.asset("assets/images/logo_biru.png"),
                  ),
                ),
                const SizedBox(
                  height: 50.48,
                ),
                const Text(
                  "Input Your Account Data",
                  style: heading1,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                    "Lorem ipsum dolor sit amet consectetur. Egestas porttitor risus enim cursus rutrum molestie tortor eget.",
                    style: body1Regular.copyWith(color: fontColor2)),
                const SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //First Name
                      const Text("First Name", style: heading3),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "First Name is empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your first name",
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
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Last Name
                      const Text("Last Name", style: heading3),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: _lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Last Name is empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your last name",
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
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Company Name
                      const Text("Company Name", style: heading3),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: _companyNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Company Name is empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your company name",
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
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Country
                      const Text("Country", style: heading3),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        readOnly: true,
                        controller: _countryController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Country is empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Country",
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
                          suffixIcon: CountryPicker(
                            suffixIconMode: true,
                            onChanged: (value) {
                              setState(() {
                                countryCode = value.phoneCode!;
                                _countryController.text = value.name!;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Password
                      const Text("Password", style: heading3),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        obscureText: !_passwordVisible,
                        controller: _passwordController,
                        validator: passwordValidator,
                        decoration: InputDecoration(
                          hintText: "Enter your Password",
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
                          errorMaxLines: 3,
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
                                    height: 24.0,
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
      ),
    );
  }
}
