import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_event.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_state.dart';
import 'package:mytradeasia/features/presentation/widgets/text_editing_widget.dart';
import 'package:mytradeasia/helper/helper_functions.dart';

class AddToCartButton extends StatefulWidget {
  final ProductEntity productEntity;
  const AddToCartButton({Key? key, required this.productEntity})
      : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  final TextEditingController _quantityController = TextEditingController();
  String? _selectedValueUnit;

  Future<dynamic> addToCartBottomSheet({required ProductEntity product}) {
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
          padding: const EdgeInsets.only(
              left: size20px, right: size20px, top: size20px),
          child: SizedBox(
            height: size20px * 17,
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
                                imageUrl:
                                    chemtradeasiaUrl + product.productimage!,
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: size20px * 2.5,
                                child: Text(
                                  product.productname ?? "",
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
                            top: size20px * 2, bottom: size20px * 1.5),
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
                                        left: size20px,
                                      ),
                                      child: DropdownButtonFormField(
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
                                        items: const [
                                          DropdownMenuItem(
                                            value: 'Tonne',
                                            child: Text('Tonne',
                                                style: body1Regular),
                                          ),
                                          DropdownMenuItem(
                                            value: '20” FCL',
                                            child: Text('20” FCL',
                                                style: body1Regular),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Litres',
                                            child: Text('Litres',
                                                style: body1Regular),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Kilogram (Kg)',
                                            child: Text('Kilogram (Kg)',
                                                style: body1Regular),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Metric Tonne (MT)',
                                            child: Text('Metric Tonne (MT)',
                                                style: body1Regular),
                                          ),
                                        ],
                                        value: _selectedValueUnit,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedValueUnit = value;
                                          });
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
                      SizedBox(
                        height: size20px * 2.75,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  primaryColor1),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_selectedValueUnit == null ||
                                  _quantityController.text == "") {
                                const snackbar = SnackBar(
                                  content: Text(
                                    "Please fill in the quantity and unit fields",
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
                                      "Use \".\" for decimal numbers",
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
                                    BlocProvider.of<CartBloc>(context).add(
                                        AddToCart(castProductEntityToCartModel(
                                            product: product,
                                            quantity: double.parse(
                                                _quantityController.text),
                                            unit: _selectedValueUnit!)));

                                    BlocProvider.of<CartBloc>(context)
                                        .add(const GetCartItems());

                                    setState(() {
                                      _quantityController.text = '';
                                      _selectedValueUnit = null;
                                    });
                                    Navigator.pop(context);
                                  }
                                }
                              }
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
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<CartBloc>(context).add(GetCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, cartState) {
      if (cartState is CartDoneState) {
        // Check if product already exist in cart
        bool chosen = false;
        for (var item in cartState.cartItems!) {
          if (item.productName == widget.productEntity.productname!) {
            chosen = true;
          }
        }

        if (chosen) {
          return IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              size: 15,
              color: Colors.white,
            ),
          );
        } else {
          return IconButton(
            onPressed: () {
              addToCartBottomSheet(
                product: widget.productEntity,
              );
            },
            icon: Image.asset(
              "assets/images/icon_cart.png",
            ),
          );
        }
      } else {
        return Container();
      }
    });
  }
}
