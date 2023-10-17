import 'package:flutter/material.dart';
import 'package:mytradeasia/features/presentation/pages/menu/messages/messages_detail_screen.dart';

import '../../../config/themes/theme.dart';

class SalesBubleChat extends StatelessWidget {
  const SalesBubleChat(
      {Key? key,
      required this.isFirstMessage,
      required this.message,
      this.state})
      : super(key: key);

  final bool isFirstMessage;
  final String message;
  final MessagesDetailScreenState? state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: size20px - 5.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(size20px * 5),
              ),
              child: Image.asset(
                "assets/images/profile_picture.png",
                width: size20px * 2,
                height: size20px * 2,
              ),
            ),
            const SizedBox(width: size20px / 2),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: primaryColor5,
                  borderRadius: BorderRadius.all(
                    Radius.circular(size20px / 2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 7.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: size20px - 13.0),
                          child: Text(message,
                              style: heading3, textAlign: TextAlign.start),
                        ),
                        isFirstMessage == true
                            ? Column(
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
                                          statusMsg: "Product",
                                          state: state,
                                          msg:
                                              'I would like to ask more product-related questions',
                                        ),
                                        FirstMessageWidget(
                                          urlIcon:
                                              "assets/images/icon_sample.png",
                                          statusMsg: "Sample",
                                          state: state,
                                          msg:
                                              'Can I get a sample of your product for testing?',
                                        ),
                                        FirstMessageWidget(
                                          urlIcon: "assets/images/icon_moq.png",
                                          statusMsg: "MOQ",
                                          state: state,
                                          msg:
                                              'What is the minimum order quantity of your product?',
                                        ),
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
                                          urlIcon:
                                              "assets/images/icon_price.png",
                                          statusMsg: "Price",
                                          state: state,
                                          msg:
                                              'I would like to know the price of your product',
                                        ),
                                        FirstMessageWidget(
                                          urlIcon:
                                              "assets/images/icon_payment.png",
                                          statusMsg: "Payment",
                                          state: state,
                                          msg:
                                              'What is the payment term you provide?',
                                        ),
                                        FirstMessageWidget(
                                          urlIcon:
                                              "assets/images/icon_complaint.png",
                                          statusMsg: "Complaint",
                                          state: state,
                                          msg:
                                              'I want to complaint about this product',
                                        ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstMessageWidget extends StatelessWidget {
  const FirstMessageWidget(
      {Key? key,
      required this.urlIcon,
      required this.statusMsg,
      this.state,
      required this.msg})
      : super(key: key);

  final String urlIcon;
  final String statusMsg;
  final String msg;
  final MessagesDetailScreenState? state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: size20px + 30.0,
            width: size20px + 30.0,
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(7.0),
              ),
            ),
            child: IconButton(
                onPressed: () {
                  state!.statusMsg(statusMsg, msg);
                },
                icon: Image.asset(
                  urlIcon,
                  width: size20px + 4.0,
                  height: size20px + 4.0,
                ))),
        Text(
          statusMsg,
          style: body2Medium,
        )
      ],
    );
  }
}
