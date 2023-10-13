import 'package:flutter/material.dart';
import 'package:mytradeasia/features/presentation/widgets/sender_bubble_chat_widget.dart';

import '../../../config/themes/theme.dart';

class UserBubleChat extends StatelessWidget {
  const UserBubleChat(
      {Key? key,
      required this.message,
      this.isSeen = false,
      required this.isFirstMessage})
      : super(key: key);

  final bool isFirstMessage;
  final String message;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: size20px - 5.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 242.0,
              decoration: const BoxDecoration(
                color: primaryColor1,
                borderRadius: BorderRadius.all(
                  Radius.circular(size20px / 2),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.end,
                      style: body1Regular.copyWith(color: whiteColor),
                    ),
                    isFirstMessage == true
                        ? const Column(
                            children: [
                              // first row
                              Padding(
                                padding: EdgeInsets.only(
                                    top: size20px, bottom: size20px / 2.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FirstMessageWidget(
                                      urlIcon:
                                          "assets/images/icon_products_message.png",
                                      namaMessage: "Product",
                                    ),
                                    FirstMessageWidget(
                                        urlIcon:
                                            "assets/images/icon_sample.png",
                                        namaMessage: "Sample"),
                                    FirstMessageWidget(
                                        urlIcon: "assets/images/icon_moq.png",
                                        namaMessage: "MOQ"),
                                  ],
                                ),
                              ),
                              // second row
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: size20px + 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FirstMessageWidget(
                                        urlIcon: "assets/images/icon_price.png",
                                        namaMessage: "Price"),
                                    FirstMessageWidget(
                                        urlIcon:
                                            "assets/images/icon_payment.png",
                                        namaMessage: "Payment"),
                                    FirstMessageWidget(
                                        urlIcon:
                                            "assets/images/icon_complaint.png",
                                        namaMessage: "Complaint"),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            isSeen == true
                ? const Text("Delivered", style: body2Medium)
                : const Text("Seen", style: body2Medium)
          ],
        ),
      ),
    );
  }
}
