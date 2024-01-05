import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';

import '../../../../config/themes/theme.dart';

class QuotationsWidget extends StatelessWidget {
  const QuotationsWidget(
      {Key? key,
      required this.status,
      required this.fontStatusColor,
      required this.backgroundStatusColor,
      required this.navigationPage,
      this.rfqEntity = const RfqEntity(
        rfqId: 0,
        custId: 0,
        company: "Tradeasia",
        country: "Indonesia",
        firstname: "M Akmal",
        incoterm: "FOB",
        lastname: "Rama",
        message: "ok",
        phone: "0811111111",
        portOfDestination: "Bandung",
        products: RfqProduct(productName: "Dipentene", quantity: 2, unit: "kg"),
        quotationStatus: "",
        salesId: 0,
      )})
      : super(key: key);

  final RfqEntity rfqEntity;
  final String status;
  final Color fontStatusColor;
  final Color backgroundStatusColor;
  final Function() navigationPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigationPage,
      child: Container(
        height: size20px * 9,
        margin: const EdgeInsets.only(top: size20px),
        child: Card(
          elevation: 3,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.only(
                top: size20px / 2,
                bottom: size20px / 2,
                left: size20px,
                right: size20px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        rfqEntity.firstname!,
                        style: heading3.copyWith(color: secondaryColor1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: size20px),
                      child: Container(
                        decoration: BoxDecoration(
                            color: backgroundStatusColor,
                            borderRadius: BorderRadius.circular(size20px * 5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: size20px - 9.0, vertical: 1.0),
                          child: Text(
                            status,
                            style:
                                body1Regular.copyWith(color: fontStatusColor),
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/icon_forward.png",
                      width: size20px,
                      height: size20px,
                      color: greyColor,
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: size20px / 2.0),
                  child: DottedLine(
                    dashColor: greyColor3,
                    dashGapLength: 3.0,
                    dashLength: 5.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size20px / 2),
                  child: Text(
                    rfqEntity.products!.productName!,
                    style: text15,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quantity/Unit",
                        style: body2Medium.copyWith(color: greyColor2)),
                    Text(rfqEntity.products!.unit!, style: body1Medium),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: size20px - 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Incoterm",
                          style: body2Medium.copyWith(color: greyColor2)),
                      Text(rfqEntity.incoterm!, style: body1Medium),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Port of Destination",
                        style: body2Medium.copyWith(color: greyColor2)),
                    Text(rfqEntity.portOfDestination!, style: body1Medium),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SalesQuotationsWidget extends StatelessWidget {
  const SalesQuotationsWidget(
      {Key? key,
      required this.status,
      required this.fontStatusColor,
      required this.backgroundStatusColor,
      required this.navigationPage})
      : super(key: key);

  final String status;
  final Color fontStatusColor;
  final Color backgroundStatusColor;
  final Function() navigationPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigationPage,
      child: Container(
        height: size20px * 8,
        margin: const EdgeInsets.only(top: size20px),
        child: Card(
          elevation: 3,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.only(
                top: size20px / 2,
                bottom: size20px / 2,
                left: size20px,
                right: size20px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Dimas Pradipta putra",
                        style: heading3.copyWith(color: secondaryColor1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: size20px),
                      child: Container(
                        decoration: BoxDecoration(
                            color: backgroundStatusColor,
                            borderRadius: BorderRadius.circular(size20px * 5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: size20px - 9.0, vertical: 1.0),
                          child: Text(
                            status,
                            style:
                                body1Regular.copyWith(color: fontStatusColor),
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/icon_forward.png",
                      width: size20px,
                      height: size20px,
                      color: greyColor,
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: size20px / 2.0),
                  child: DottedLine(
                    dashColor: greyColor3,
                    dashGapLength: 3.0,
                    dashLength: 5.0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: size20px / 2),
                  child: Text(
                    "Dipentene",
                    style: text15,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quantity/Unit",
                        style: body2Medium.copyWith(color: greyColor2)),
                    const Text("800 Tone/Tones", style: body1Medium),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: size20px - 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Incoterm",
                          style: body2Medium.copyWith(color: greyColor2)),
                      const Text("FOB", style: body1Medium),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Port of Destination",
                        style: body2Medium.copyWith(color: greyColor2)),
                    const Text("Any port in Vietnam", style: body1Medium),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
