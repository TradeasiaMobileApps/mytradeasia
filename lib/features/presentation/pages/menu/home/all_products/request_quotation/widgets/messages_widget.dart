import 'package:flutter/material.dart';
import 'package:mytradeasia/config/themes/theme.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({super.key, required this.messagesController});
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
          height: size20px * 14.25,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
              border: Border.all(color: greyColor3)),
          child: Padding(
            padding: const EdgeInsets.only(
              left: size20px,
              right: size20px,
              top: size20px - 4.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: messagesController,
                  maxLength: 8000,
                  maxLines: 3,
                  style: body1Regular,
                  decoration: const InputDecoration(
                      hintText: "Hi, I'm interested in this product.",
                      hintStyle: body1Regular,
                      border: InputBorder.none),
                ),
                const Divider(
                  color: greyColor2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: size20px / 2.0),
                  child: Text(
                    "Or choose from these questions :",
                    style: body2Medium.copyWith(color: greyColor2),
                  ),
                ),

                // Button 1
                SizedBox(
                  height: size20px * 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll<double>(0.0),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(whiteColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side: const BorderSide(color: greyColor3),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        messagesController.text = "What is the shipping cost?";
                      },
                      child: const Text(
                        "What is the shipping cost?",
                        style: body1Regular,
                      )),
                ),

                // Button 2
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: SizedBox(
                    height: size20px * 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation:
                              const MaterialStatePropertyAll<double>(0.0),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(whiteColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: const BorderSide(color: greyColor3),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          messagesController.text =
                              "How long will it take to ship to my country?";
                        },
                        child: const Text(
                          "How long will it take to ship to my country?",
                          style: body1Regular,
                        )),
                  ),
                ),

                // Sizebox 3
                SizedBox(
                  height: size20px * 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll<double>(0.0),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(whiteColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side: const BorderSide(color: greyColor3),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // print(streamSnapshot
                        //         .data!.docs[0]
                        //     ['firstName']);
                        messagesController.text = "Can I get a sample first?";
                      },
                      child: const Text(
                        "Can I get a sample first?",
                        style: body1Regular,
                      )),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
