import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/dropdown_models/dropdown_uom_model.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/cart_entities.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_incoterm_entity.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_uom_entity.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_to_rfq_entity.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_event.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_state.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_event.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_state.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_uom_bloc/dropdown_uom_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_uom_bloc/dropdown_uom_event.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_uom_bloc/dropdown_uom_state.dart';
import 'package:mytradeasia/features/presentation/widgets/cart_message_widget.dart';
import 'package:mytradeasia/features/presentation/widgets/text_editing_widget.dart';

import '../../../../../../config/themes/theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _quantityController = TextEditingController();
  DropdownUomEntity? _selectedValueUnit;
  String? _incotermValue;
  final TextEditingController _portOfDischargeController =
      TextEditingController();
  final TextEditingController _messagesController = TextEditingController();

  getDropdownData() {
    BlocProvider.of<DropdownUomBloc>(context).add(const GetUomEvent());
    BlocProvider.of<DropdownIncotermBloc>(context)
        .add(const GetIncotermEvent());
  }

  void editCartItemBottomSheet({required CartEntity product}) async {
    _quantityController.text = product.quantity.toString();
    //TODO: should have been DropdownUomEntity but data from the getUom is a DropdownUomModel form so it can't be compared and it emits error on DropdownButtonFormField widget
    _selectedValueUnit =
        DropdownUomModel(id: product.uomId, uomName: product.unitName!);
    _incotermValue = product.incoterm!;
    _portOfDischargeController.text = product.pod!;
    _messagesController.text = product.note!;

    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
                left: size20px, right: size20px, top: size20px),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/icon_spacing.png",
                      width: 25.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: size20px),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: size20px * 5,
                              width: size20px * 5,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(size20px / 4)),
                                child: CachedNetworkImage(
                                  imageUrl: product.productImage!,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(width: size20px),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: size20px * 2.5,
                                  child: Text(
                                    product.productName ?? "",
                                    style: heading2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: size20px / 2),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "CAS Number",
                                          style: body1Medium,
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          product.casNumber ?? "",
                                          style: body1Regular.copyWith(
                                              color: greyColor2),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "HS Code",
                                          style: body1Medium,
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          product.hsCode ?? "",
                                          style: body1Regular.copyWith(
                                              color: greyColor2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: size20px * 2, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Quantity",
                                      style: text14,
                                    ),
                                    const SizedBox(height: size24px / 3),
                                    SizedBox(
                                      width: size20px * 8.0,
                                      height: size20px + 30,
                                      child: TextEditingWidget(
                                        controller: _quantityController,
                                        hintText: "Quantity",
                                        readOnly: false,
                                        inputType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                flex: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Unit",
                                      style: text14,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: greyColor3),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      width: size20px * 8.0,
                                      height: size20px + 28,
                                      // TexteditingController here
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: size20px - 14,
                                        ),
                                        child: BlocBuilder<DropdownUomBloc,
                                            DropdownUomState>(
                                          builder: (context, state) {
                                            List<DropdownMenuItem> uom = [];
                                            if (state is DropdownUomSuccess) {
                                              for (var i = 0;
                                                  i < state.dropdownUom!.length;
                                                  i++) {
                                                uom.add(DropdownMenuItem(
                                                  value: state.dropdownUom![i],
                                                  child: AutoSizeText(
                                                    state.dropdownUom![i]
                                                        .uomName,
                                                    // style: TextStyle(fontSize: 7),
                                                    minFontSize: 10,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ));
                                              }
                                            }

                                            return DropdownButtonFormField(
                                              icon: Image.asset(
                                                  "assets/images/icon_bottom.png"),
                                              hint: Text(
                                                "Unit",
                                                style: body1Regular.copyWith(
                                                    color: greyColor),
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              style: body1Regular,
                                              items: uom,
                                              value: _selectedValueUnit,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValueUnit = value;
                                                });
                                              },
                                            );
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
                        Padding(
                          padding: const EdgeInsets.only(
                              top: size20px, bottom: size20px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Incoterm",
                                      style: text14,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: greyColor3),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      width: size20px * 8.0,
                                      height: size20px + 28,
                                      // TexteditingController here
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: size20px - 14,
                                        ),
                                        child: BlocBuilder<DropdownIncotermBloc,
                                            DropdownIncotermState>(
                                          builder: (context, state) {
                                            List<DropdownMenuItem> incoterm =
                                                [];
                                            if (state
                                                is DropdownIncotermSuccess) {
                                              for (var i = 0;
                                                  i <
                                                      state.dropdownIncoterm!
                                                          .length;
                                                  i++) {
                                                incoterm.add(DropdownMenuItem(
                                                  value: state
                                                      .dropdownIncoterm![i]
                                                      .incotermName,
                                                  child: AutoSizeText(
                                                    state.dropdownIncoterm![i]
                                                        .incotermName,
                                                    // style: TextStyle(fontSize: 7),
                                                    minFontSize: 10,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ));
                                              }
                                            }
                                            return DropdownButtonFormField(
                                              icon: Image.asset(
                                                  "assets/images/icon_bottom.png"),
                                              hint: Text(
                                                "Incoterm",
                                                style: body1Regular.copyWith(
                                                    color: greyColor),
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              style: body1Regular,
                                              items: incoterm,
                                              value: _incotermValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _incotermValue = value;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                flex: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "POD",
                                      style: text14,
                                    ),
                                    const SizedBox(height: size24px / 3),
                                    SizedBox(
                                      width: size20px * 8.0,
                                      height: size20px + 30,
                                      child: TextEditingWidget(
                                        controller: _portOfDischargeController,
                                        hintText: "Port Of Discharge",
                                        readOnly: false,
                                        inputType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CartMessagesWidget(
                            messagesController: _messagesController),
                        // MessagesWidget(messagesController: _messagesController),
                        SizedBox(
                          height: size20px * 2.75,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
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
                                updateCart(
                                    product: CartEntity(
                                  id: product.id,
                                  cartId: product.cartId,
                                  userid: product.userid,
                                  productId: product.productId,
                                  uomId: _selectedValueUnit!.id,
                                  quantity: int.parse(_quantityController.text),
                                  incoterm: _incotermValue,
                                  pod: _portOfDischargeController.text,
                                  note: _messagesController.text,
                                ));
                              },
                              child: Text("Add to Cart",
                                  style: text16.copyWith(color: whiteColor))),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void updateCart({required CartEntity product}) {
    if (_selectedValueUnit == null ||
        _quantityController.text == "" ||
        _incotermValue == null ||
        _portOfDischargeController.text == "") {
      const snackbar = SnackBar(
        content: Text(
          "Please fill in the fields",
          textAlign: TextAlign.center,
        ),
        backgroundColor: redColor1,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      final quantity = int.tryParse(_quantityController.text);
      if (quantity == null) {
        const snackbar = SnackBar(
          content: Text(
            "Use \".\" for decimal numbers",
            textAlign: TextAlign.center,
          ),
          backgroundColor: redColor1,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        if (quantity <= 0) {
          const snackbar = SnackBar(
            content: Text(
              "Quantity must be greater than zero",
              textAlign: TextAlign.center,
            ),
            backgroundColor: redColor1,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } else {
          BlocProvider.of<CartBloc>(context).add(UpdateCartItem(product));

          BlocProvider.of<CartBloc>(context).add(const GetCartItems());

          setState(() {
            _quantityController.text = '';
            _messagesController.text = '';
            _incotermValue = null;
            _messagesController.text = '';
            _selectedValueUnit = null;
          });
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(const GetCartItems());
    getDropdownData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is CartDoneState) {
        if (state.cartItems != null && state.cartItems!.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "My Cart",
                style: heading2,
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  "assets/images/icon_back.png",
                  width: 24.0,
                  height: 24.0,
                ),
              ),
              elevation: 0.0,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Checkbox(
                        value:
                            state.cartItems!.every((item) => item.isChecked!),
                        activeColor: primaryColor1,
                        side:
                            const BorderSide(color: primaryColor1, width: 2.0),
                        onChanged: (dynamic value) {
                          setState(() {
                            for (var item in state.cartItems!) {
                              item.isChecked = value;
                            }
                          });
                        },
                      ),
                      const Text(
                        "Choose All",
                        style: body1Regular,
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(RemoveFromCart());
                          BlocProvider.of<CartBloc>(context)
                              .add(const GetCartItems());
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: thirdColor1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(size20px))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: size20px / 2,
                                vertical: size20px / 4),
                            child: Text(
                              "Delete",
                              style:
                                  body1Regular.copyWith(color: secondaryColor1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: size20px),
                    ],
                  ),
                ),
                const SizedBox(height: size20px / 4.0),

                /* Cart */
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.cartItems!.length,
                    itemBuilder: (context, index) {
                      CartEntity item = state.cartItems![index];
                      return InkWell(
                        onTap: () => editCartItemBottomSheet(product: item),
                        child: SizedBox(
                          height: size20px * 7,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Checkbox(
                                value: item.isChecked,
                                activeColor: primaryColor1,
                                side: const BorderSide(
                                    color: primaryColor1, width: 2.0),
                                onChanged: (bool? value) {
                                  setState(() {
                                    state.cartItems![index].isChecked = value;
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: size20px + 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl: item.productImage ?? "",
                                    width: size20px * 4.5,
                                    height: size20px * 4.5 + 5,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 1, top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: size20px - 15.0),
                                        child: Text(
                                            item.productName!.length > 26
                                                ? "${item.productName!.substring(0, 25)}. . ."
                                                : item.productName!,
                                            style: heading3),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("HS Code :",
                                                  style: body2Medium),
                                              Text(item.hsCode ?? "",
                                                  style: body2Medium.copyWith(
                                                      color: greyColor2)),
                                            ],
                                          ),
                                          const SizedBox(
                                              width: size20px + 10.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("CAS Number :",
                                                  style: body2Medium),
                                              Text(item.casNumber ?? "",
                                                  style: body2Medium.copyWith(
                                                      color: greyColor2)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Flexible(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Quantity :",
                                                style: body2Medium),
                                            Text(
                                                "${item.quantity!} ${item.unitName}",
                                                style: body2Medium.copyWith(
                                                    color: greyColor2)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: size20px, vertical: size20px - 8.0),
                child: state.cartItems!.any((item) => item.isChecked!)
                    ? ActiveButton(
                        titleButton: "Send Inquiry",
                        cartData: state.cartItems!,
                      )
                    : const InactiveButton(
                        titleButton: "Send Inquiry",
                      )),
          );
        } else {
          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "My Cart",
                  style: heading2,
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "assets/images/icon_back.png",
                    width: 24.0,
                    height: 24.0,
                  ),
                ),
                elevation: 0.0,
              ),
              body: const Center(
                child: Text(
                  "No product in cart yet",
                  style: heading2,
                ),
              ));
        }
      } else if (state is CartLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "My Cart",
                style: heading2,
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  "assets/images/icon_back.png",
                  width: 24.0,
                  height: 24.0,
                ),
              ),
              elevation: 0.0,
            ),
            body: const Center(
              child: Text(
                "No product in cart yet",
                style: heading2,
              ),
            ));
      }
    });
  }
}

class InactiveButton extends StatelessWidget {
  const InactiveButton({super.key, required this.titleButton});

  final String titleButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(greyColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
        onPressed: null,
        child: Text(
          titleButton,
          style: text16.copyWith(color: whiteColor),
        ),
      ),
    );
  }
}

class ActiveButton extends StatelessWidget {
  const ActiveButton(
      {super.key, required this.titleButton, required this.cartData});

  final String titleButton;
  final List<CartEntity> cartData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor1),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
        onPressed: (() {
          final List<ProductToRfq> selectedItem = [];
          for (var item in cartData) {
            if (item.isChecked!) {
              ProductToRfq data = ProductToRfq(
                productId: item.productId.toString(),
                productName: item.productName!,
                productImage: item.productImage!,
                hsCode: item.hsCode!,
                casNumber: item.casNumber!,
                quantity: item.quantity,
                unit: item.unitName,
              );
              selectedItem.add(data);
            }
          }

          RequestQuotationParameter param = RequestQuotationParameter(
            products: selectedItem,
          );

          context.push("/mytradeasia/cart/multiple_request_quotation",
              extra: param);
        }),
        child: Text(
          titleButton,
          style: text16.copyWith(color: whiteColor),
        ),
      ),
    );
  }
}
