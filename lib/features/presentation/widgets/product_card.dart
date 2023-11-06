import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';
import 'package:mytradeasia/features/presentation/widgets/add_to_cart_button.dart';

import '../../../config/themes/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.product,
      this.isNotRecentSeenCard = true,
      this.onPressed});

  final ProductEntity product;
  final bool isNotRecentSeenCard;
  final Function()? onPressed;
  final String url = "https://chemtradea.chemtradeasia.com/";

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: blackColor,
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: size24px / 4, right: size24px / 4, top: size24px / 4),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(size20px / 2),
              ),
              child: SizedBox(
                height: size20px * 5.5,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: "$url${product.productimage!}",
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: AutoSizeText(
                product.productname ?? "",
                style: text14,
                maxLines: 2,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "CAS Number :",
                        style: text10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AutoSizeText(
                        product.casNumber ?? "",
                        style: text10.copyWith(color: greyColor2),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "HS Code :",
                        style: text10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AutoSizeText(
                        product.hsCode ?? "",
                        style: text10.copyWith(color: greyColor2),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isNotRecentSeenCard
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30,
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
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.zero)),
                              onPressed: onPressed,
                              child: Text(
                                "Send Inquiry",
                                style: text12.copyWith(
                                  color: whiteColor,
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: secondaryColor1,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: AddToCartButton(
                          productEntity: product,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 10,
                )
        ],
      ),
    );
  }
}
