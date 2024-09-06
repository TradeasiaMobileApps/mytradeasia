import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_to_rfq_entity.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/request_entity.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_data.dart';
import 'package:mytradeasia/features/presentation/pages/menu/home/all_products/request_quotation/widgets/multiple_rfq_products_widget.dart';

import 'package:mytradeasia/features/presentation/pages/menu/home/all_products/request_quotation/widgets/rfq_products_widget.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_event.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_state.dart';
import 'package:mytradeasia/features/presentation/widgets/dialog_sheet_widget.dart';
import 'package:mytradeasia/helper/injections_container.dart';

import '../../../../../widgets/country_picker.dart';
import '../../../../../state_management/rfq_bloc/rfq_bloc.dart';
import '../../../../../state_management/rfq_bloc/rfq_event.dart';
import '../../../../../state_management/rfq_bloc/rfq_state.dart';
import '../../../../../widgets/text_editing_widget.dart';

class MultipleRfqScreen extends StatefulWidget {
  final List<ProductToRfq> products;

  const MultipleRfqScreen({
    super.key,
    this.products = const [],
  });

  @override
  State<MultipleRfqScreen> createState() => _MultipleRfqScreenState();
}

class _MultipleRfqScreenState extends State<MultipleRfqScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _portOfDetinationController =
      TextEditingController();
  final TextEditingController _messagesController =
      TextEditingController(text: "Hi, I'm interested in this product.");
  final GetUserData _geUserData = injections<GetUserData>();
  final _formKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  String? _selectedValueIncoterm;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> _data = {};

  @override
  void initState() {
    getUserData();
    getIncotermData();
    super.initState();
  }

  getUserData() async {
    _data = await _geUserData();

    _firstNameController.text = _data['firstName'] ?? '';
    _lastNameController.text = _data['lastName'] ?? '';
    _phoneNumberController.text = _data['phone'] ?? '';
    _countryController.text = _data['country'] ?? '';
    _companyNameController.text = _data['companyName'] ?? '';
  }

  getIncotermData() {
    BlocProvider.of<DropdownIncotermBloc>(context)
        .add(const GetIncotermEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _countryController.dispose();
    _companyNameController.dispose();
    _productNameController.dispose();
    _quantityController.dispose();
    _portOfDetinationController.dispose();
    _messagesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: StreamBuilder(
            stream: _firestore
                .collection('biodata')
                .where('uid', isEqualTo: _auth.currentUser!.uid.toString())
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              return streamSnapshot.connectionState == ConnectionState.waiting
                  ? SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: primaryColor1,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Image.asset(
                          "assets/images/banner.png",
                          height: size20px * 10,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: size20px),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: size20px * 3.25,
                                      bottom: size20px + 30.0),
                                  child: Image.asset(
                                    "assets/images/icon_back.png",
                                    width: size20px + 4.0,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              Text(
                                "Request for Quotation",
                                style: heading2.copyWith(color: whiteColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: size20px * 3, bottom: size20px / 2.0),
                                child: Form(
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
                                                const SizedBox(height: 8.0),
                                                SizedBox(
                                                  width: size20px * 8.0,
                                                  height: size20px + 30,
                                                  // TexteditingController here
                                                  child: TextEditingWidget(
                                                    controller:
                                                        _firstNameController,
                                                    hintText: "First Name",
                                                    readOnly: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
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
                                                SizedBox(
                                                  width: size20px * 8.0,
                                                  height: size20px + 30,
                                                  // TexteditingController here
                                                  child: TextEditingWidget(
                                                    controller:
                                                        _lastNameController,
                                                    hintText: "Last Name",
                                                    readOnly: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Phone Number
                                      Column(
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
                                              CountryPicker(
                                                readOnly: true,
                                                onChanged: (value) {
                                                  print(value);
                                                },
                                              ),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: SizedBox(
                                                  width: size20px * 8.0,
                                                  height: size20px + 30,
                                                  child: TextEditingWidget(
                                                      inputType:
                                                          TextInputType.none,
                                                      controller:
                                                          _phoneNumberController,
                                                      hintText: "Phone Number",
                                                      readOnly: true),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      // Country
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: size20px - 5.0,
                                                bottom: size20px - 12.0),
                                            child: Text(
                                              "Country",
                                              style: text14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TextEditingWithIconSuffix(
                                              readOnly: true,
                                              controller: _countryController,
                                              hintText: "Country",
                                              imageUrl:
                                                  "assets/images/icon_forward.png",
                                              navigationPage: () {},
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Company Name
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
                                          SizedBox(
                                            height: 50.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TextEditingWidget(
                                              readOnly: true,
                                              controller:
                                                  _companyNameController,
                                              hintText: "tradeasia",
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Customer Name for agent
                                      streamSnapshot.data!.docs[0]['role'] ==
                                              "Agent"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: size20px - 5.0,
                                                      bottom: size20px - 12.0),
                                                  child: Text(
                                                    "End Customer Name",
                                                    style: text14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50.0,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: TextEditingWidget(
                                                    readOnly: true,
                                                    controller:
                                                        _productNameController,
                                                    hintText: "",
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: size20px - 5.0,
                                                bottom: size20px - 12.0),
                                            child: Text(
                                              "Products",
                                              style: text14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                        ],
                                      ),
                                      //products

                                      MultipleRfqProducts(
                                        quantityController: _quantityController,
                                        products: widget.products,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: size20px, vertical: size20px - 7.0),
        child: SizedBox(
          height: size20px * 2.5,
          child: BlocBuilder<RfqBloc, RfqState>(
            builder: (context, state) {
              if (state is RfqLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is RfqError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogWidget(
                          urlIcon: "assets/images/logo_email_change.png",
                          title: "Submit Request Error",
                          subtitle: "${state.error!.message}",
                          textForButton: "Close",
                          navigatorFunction: () {
                            BlocProvider.of<RfqBloc>(context).add(DisposeRfq());
                            context.pop();
                          });
                    },
                  );
                });
              }
              return ElevatedButton(
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
                    /* With go_router */

                    if (widget.products.isEmpty) {
                      const snackbar = SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(
                          "The products still empty",
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: redColor1,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } else {
                      if (_formKey.currentState!.validate()) {
                        for (var e in widget.products) {
                          BlocProvider.of<RfqBloc>(context).add(SubmitRfqEvent(
                            RequestEntity(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              companyName: _companyNameController.text,
                              country: _countryController.text,
                              mobileNumber: _phoneNumberController.text,
                              productId: int.parse(e.productId),
                            ),
                          ));
                        }
                        if (state is RfqSuccess) {
                          context.pushNamed("submitted_rfq");
                        }
                      }
                    }
                  },
                  child: Text(
                    "Send",
                    style: text16.copyWith(color: whiteColor),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
