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

  Widget dataRow(int index, QuoteEntity quoteEntity) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(
            top: size20px / 2, right: size20px, left: size20px),
        child: Row(
          children: [
            SizedBox(
              width: size20px * 4.0,
              child: Text(quoteEntity.toQuoteMap().keys.toList()[index],
                  style: body2Medium.copyWith(color: greyColor2)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: size20px),
              child:
                  Text(" : ", style: body2Medium.copyWith(color: greyColor2)),
            ),
            Expanded(
              child: Text(
                quoteEntity.toQuoteMap().values.toList()[index],
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
          var quoteData = snapshot.data;
          // print(quoteData!.error!.message);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive(
              backgroundColor: primaryColor1,
            );
          }
          if (snapshot.hasData) {
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
                          dataRow(i, quoteData!.data!),
                      ],
                    ),
                  )
                : const Center(
                    child: Text("Error on retrieving quotation data"),
                  );
          }
          return SizedBox();
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
