import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/data/model/dropdown_models/dropdown_uom_model.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_to_rfq_entity.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_state.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_uom_bloc/dropdown_uom_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_uom_bloc/dropdown_uom_event.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_uom_bloc/dropdown_uom_state.dart';
import 'package:mytradeasia/features/presentation/widgets/cart_message_widget.dart';
import 'package:mytradeasia/features/presentation/widgets/text_editing_widget.dart';

class MultipleRfqProducts extends StatefulWidget {
  const MultipleRfqProducts({
    super.key,
    this.products = const [],
  });
  final List<ProductToRfq> products;

  @override
  State<MultipleRfqProducts> createState() => _MultipleRfqProductsState();
}

class _MultipleRfqProductsState extends State<MultipleRfqProducts> {
  DropdownUomModel? _selectedValueUnit;
  String? _incotermValue = "";
  final TextEditingController _portOfDischargeController =
      TextEditingController();
  final TextEditingController _messagesController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    getUomData();
    super.initState();
  }

  getUomData() {
    BlocProvider.of<DropdownUomBloc>(context).add(const GetUomEvent());
  }

  @override
  Widget build(BuildContext context) {
    return widget.products.isNotEmpty
        ? SizedBox(
            height: widget.products.length > 1 ? 250 : 150,
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => editCartItemBottomSheet(
                        product: widget.products[index]),
                    child: SizedBox(
                      height: size20px * 5.5,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: size20px + 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                                imageUrl: widget.products[index].productImage,
                                width: size20px * 4.5,
                                height: size20px * 4.5 + 5,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: size20px - 15.0),
                                  child: Text(
                                    widget.products[index].productName.length >
                                            31
                                        ? "${widget.products[index].productName.substring(0, 31)}..."
                                        : widget.products[index].productName,
                                    style: heading3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("HS Code :",
                                            style: body2Medium),
                                        Text(widget.products[index].hsCode,
                                            style: body2Medium.copyWith(
                                                color: greyColor2)),
                                      ],
                                    ),
                                    const SizedBox(width: size20px + 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("CAS Number :",
                                            style: body2Medium),
                                        Text(widget.products[index].hsCode,
                                            style: body2Medium.copyWith(
                                                color: greyColor2)),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Quantity :",
                                        style: body2Medium),
                                    Text(
                                        widget.products[index].quantity ==
                                                    null ||
                                                widget.products[index].unit ==
                                                    null
                                            ? "Not yet added"
                                            : "${widget.products[index].quantity!} ${widget.products[index].unit}",
                                        style: body2Medium.copyWith(
                                            color: greyColor2)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : ClipOval(
            child: Material(
              color: primaryColor1, // button color
              child: InkWell(
                // splashColor: Colors
                //     .red, // inkwell color
                child: const SizedBox(
                    width: 46,
                    height: 46,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
                onTap: () {
                  context.goNamed("all_products");
                },
              ),
            ),
          );
  }

  void editCartItemBottomSheet({required ProductToRfq product}) async {
    _selectedValueUnit =
        DropdownUomModel(id: product.uomId!, uomName: product.unit!);
    _incotermValue = product.incoterm!;
    _portOfDischargeController.text = product.pod!;
    _messagesController.text = product.note!;
    _quantityController.text = product.quantity.toString();

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
                                  imageUrl: product.productImage,
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
                                    product.productName,
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
                                          product.casNumber,
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
                                          product.hsCode,
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
                                if (_selectedValueUnit == null &&
                                    _quantityController.text == "" &&
                                    _incotermValue == "" &&
                                    _portOfDischargeController.text == "" &&
                                    _quantityController.text == "") {
                                  const snackbar = SnackBar(
                                    content: Text(
                                      "Please fill in the empty fields",
                                      textAlign: TextAlign.center,
                                    ),
                                    backgroundColor: redColor1,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                } else {
                                  final quantity =
                                      double.tryParse(_quantityController.text);
                                  if (quantity == null) {
                                    const snackbar = SnackBar(
                                      content: Text(
                                        "Please enter a valid number (Use \".\" for decimal numbers)",
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: redColor1,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  } else {
                                    if (quantity <= 0) {
                                      const snackbar = SnackBar(
                                        content: Text(
                                          "Quantity must be greater than zero",
                                          textAlign: TextAlign.center,
                                        ),
                                        backgroundColor: redColor1,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    } else {
                                      Navigator.pop(context);
                                      setState(() {
                                        product.quantity =
                                            int.parse(_quantityController.text);
                                        product.unit =
                                            _selectedValueUnit?.uomName ?? "";
                                        product.incoterm = _incotermValue;
                                        product.quantity = quantity.toInt();
                                        product.unit =
                                            _selectedValueUnit!.uomName;
                                        product.uomId = _selectedValueUnit!.id;
                                        product.pod =
                                            _portOfDischargeController.text;
                                        product.note = _messagesController.text;
                                      });
                                    }
                                  }
                                }
                              },
                              child: Text("Save",
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
}
