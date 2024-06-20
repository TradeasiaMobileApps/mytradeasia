import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/domain/usecases/rfq_usecases/approve_quote.dart';
import 'package:mytradeasia/features/domain/usecases/rfq_usecases/reject_quote.dart';
import 'package:mytradeasia/helper/injections_container.dart';

import '../../../../../config/themes/theme.dart';

class QuotedNavbar extends StatelessWidget {
  const QuotedNavbar({super.key, required this.rfqId});
  final int rfqId;
  static ApproveQuote aprroveQuote = ApproveQuote(injections());
  static RejectQuote rejectQuote = RejectQuote(injections());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: size20px * 2.75,
            height: size20px * 2.75,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(redColor2),
                elevation: WidgetStateProperty.all<double>(0.0),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        side: const BorderSide(color: redColor1))),
              ),
              onPressed: () {
                rejectQuote.call(param: rfqId);
                context.pop();
              },
              child: const Icon(
                Icons.close,
                color: redColor1,
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: size20px * 0.75),
          child: SizedBox(
              width: size20px * 2.75,
              height: size20px * 2.75,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(greenColor2),
                  elevation: WidgetStateProperty.all<double>(0.0),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          side: const BorderSide(color: greenColor1))),
                ),
                onPressed: () {
                  aprroveQuote.call(param: rfqId);
                  context.pop();
                },
                child: const Icon(
                  Icons.check,
                  color: greenColor1,
                ),
              )),
        ),
        Expanded(
          child: SizedBox(
            width: size20px * 9.75,
            height: size20px * 2.75,
            child: ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(primaryColor1),
                elevation: WidgetStateProperty.all<double>(0.0),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                )),
              ),
              child: Text(
                "Make Offer",
                style: text16.copyWith(color: whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
