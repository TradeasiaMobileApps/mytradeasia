import 'package:flutter/material.dart';
import 'package:mytradeasia/features/domain/entities/quote_entities/quote_entity.dart';
import 'package:mytradeasia/features/domain/usecases/quote_usecases/get_quote_usecase.dart';

import '../../../../config/themes/theme.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../helper/injections_container.dart';

class SalesQuotationData extends StatelessWidget {
  const SalesQuotationData({super.key, required this.status, this.quoteId});
  final String status;
  final int? quoteId;

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
            //TODO:change this into using quote data fetched from remote
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
    final GetQuote getQuoteData = injections<GetQuote>();

    if (status == "quoted" || status == "approved") {
      return FutureBuilder<DataState<QuoteEntity>>(
        future: getQuoteData.call(param: quoteId!),
        builder: (context, snapshot) {
          //TODO:add loading effect before fetching data
          var quoteData = snapshot.data;
          // print(quoteData!.error!.message);
          return quoteData is DataSuccess
              ? SizedBox(
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
                      for (int i = 0; i < salesQuotationData.length; i++)
                        dataRow(i),
                    ],
                  ),
                )
              : const Center(
                  child: Text("Error on retrieving quotation data"),
                );
        },
      );
    } else {
      return Text(
        "Not yet available",
        style: body2Medium.copyWith(color: greyColor2),
      );
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
