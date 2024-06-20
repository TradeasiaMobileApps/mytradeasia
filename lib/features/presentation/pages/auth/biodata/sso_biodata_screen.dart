// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_account_model.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_event.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_data/salesforce_data_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_data/salesforce_data_event.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_login/salesforce_login_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_login/salesforce_login_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../config/themes/theme.dart';
import '../../../widgets/dialog_sheet_widget.dart';
import 'package:country_picker/country_picker.dart';

class SSOBiodataScreen extends StatefulWidget {
  const SSOBiodataScreen({super.key});

  @override
  State<SSOBiodataScreen> createState() => _SSOBiodataScreenState();
}

class _SSOBiodataScreenState extends State<SSOBiodataScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final UserCredentialEntity _userCredential =
  //     injections<UserCredentialEntity>();
  final auth = FirebaseAuth.instance;
  String countryName = '';

  @override
  void initState() {
    if (auth.currentUser!.displayName != null) {
      _firstNameController.text =
          auth.currentUser!.displayName!.split(" ").first;
      _lastNameController.text = auth.currentUser!.displayName!.split(" ").last;
    }
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    var salesforceBloc = BlocProvider.of<SalesforceDataBloc>(context);

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
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final role = prefs.getString("role") ?? "";
                    final tokenSF = prefs.getString("tokenSF") ?? "";

                    if (_formKey.currentState!.validate()) {
                      authBloc.add(SSORegisterWithEmail(
                        UserEntity(
                          companyName: _companyNameController.text,
                          country: _countryController.text,
                          email: auth.currentUser!.email,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          role: role,
                        ),
                        context,
                      ));

                      salesforceBloc.add(CreateSFAccount(
                          token: tokenSF,
                          salesforceCreateAccountForm: SalesforceCreateAccountForm(
                              name:
                                  "${_firstNameController.text} ${_lastNameController.text}",
                              phone: "",
                              role: role,
                              company: _companyNameController.text)));

                      await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return DialogWidget(
                              urlIcon:
                                  "assets/images/icon_sukses_reset_password.png",
                              title: "Successful Registration",
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
                  },
                  child: Text(
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
                  "Input Your Account Data SSO",
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                favorite: <String>['ID'],
                                //Optional. Shows phone code before the country name.
                                showPhoneCode: false,
                                onSelect: (Country country) {
                                  // countryName = country.displayName;
                                  print(country.countryCode);
                                  _countryController.text = country.name;
                                },
                                // Optional. Sets the theme for the country list picker.
                                countryListTheme: CountryListThemeData(
                                  // Optional. Sets the border radius for the bottomsheet.
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  // Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  // Optional. Styles the text in the search field
                                  searchTextStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            },
                            icon: Image.asset("assets/images/icon_forward.png",
                                width: 24.0, height: 24.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
