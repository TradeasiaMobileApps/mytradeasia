import 'package:flutter/material.dart';
import 'package:mytradeasia/config/themes/theme.dart';

class CartMessagesWidget extends StatelessWidget {
  const CartMessagesWidget({super.key, required this.messagesController});
  final TextEditingController messagesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:
              EdgeInsets.only(top: size20px - 5.0, bottom: size20px - 12.0),
          child: Text(
            "Messages",
            style: text14,
          ),
        ),
        Container(
          height: size20px * 6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
              border: Border.all(color: greyColor3)),
          margin: EdgeInsets.only(bottom: size20px - 5),
          child: Padding(
            padding: const EdgeInsets.only(
              left: size20px,
              right: size20px,
              top: size20px - 4.0,
            ),
            child: TextFormField(
              controller: messagesController,
              maxLength: 8000,
              maxLines: 3,
              style: body1Regular,
              decoration: const InputDecoration(
                  hintText: "Hi, I'm interested in this product.",
                  hintStyle: body1Regular,
                  border: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }
}
