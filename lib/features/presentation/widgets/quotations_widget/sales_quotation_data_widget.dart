import 'package:flutter/material.dart';

import '../../../../config/themes/theme.dart';

class SalesQuotationData extends StatelessWidget {
  const SalesQuotationData({super.key, required this.status});
  final String status;

  static const salesQuotationData = {
    "Price": "...",
    "Quantity": "...",
    "Shipment Date": "...",
    "Incoterm": "...",
    "Payment Term": "...",
    "Validity": "...",
    "UOM": "..."
  };

  Widget dataRow(int index) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(
            top: size20px / 2, right: size20px, left: size20px),
        child: Row(
          children: [
            SizedBox(
              width: size20px * 4.0,
              child: Text(salesQuotationData.keys.toList()[index],
                  style: body2Medium.copyWith(color: greyColor2)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: size20px),
              child:
                  Text(" : ", style: body2Medium.copyWith(color: greyColor2)),
            ),
            Expanded(
              child: Text(
                salesQuotationData.values.toList()[index],
                style: body1Medium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (status == "quoted" || status == "approved") {
      return SizedBox(
        height: 203,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quotations",
              style: heading2,
            ),
            const SizedBox(
              height: size20px - 10,
            ),
            if (status == "quoted" || status == "approved") ...[
              for (int i = 0; i < salesQuotationData.length; i++) dataRow(i),
            ] else ...[
              Text(
                "Not yet available",
                style: body2Medium.copyWith(color: greyColor2),
              ),
            ]
          ],
        ),
      );
    } else {
      return status != "rejected"
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quotations",
                    style: heading2,
                  ),
                  const SizedBox(
                    height: size20px - 10,
                  ),
                  if (status == "quoted" || status == "approved") ...[
                    for (int i = 0; i < salesQuotationData.length; i++)
                      dataRow(i),
                  ] else ...[
                    Text(
                      "Not yet available",
                      style: body2Medium.copyWith(color: greyColor2),
                    ),
                  ]
                ],
              ))
          : const SizedBox();
    }
    // return SizedBox(
    //   height: 203,
    //   width: MediaQuery.of(context).size.width,
    //   child: status != "rejected"
    //       ? Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const Text(
    //               "Quotations",
    //               style: heading2,
    //             ),
    //             const SizedBox(
    //               height: size20px - 10,
    //             ),
    //             if (status == "quoted" || status == "approved") ...[
    //               for (int i = 0; i < salesQuotationData.length; i++)
    //                 dataRow(i),
    //             ] else ...[
    //               Text(
    //                 "Not yet available",
    //                 style: body2Medium.copyWith(color: greyColor2),
    //               ),
    //             ]
    //           ],
    //         )
    //       : const SizedBox(),
    // );
  }
}
