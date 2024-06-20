import 'package:flutter/material.dart';

import '../../../../../config/themes/theme.dart';
import '../../dialog_sheet_widget.dart';

class SalesNavbar extends StatelessWidget {
  const SalesNavbar({
    Key? key,
  }) : super(key: key);

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
                showDialog(
                  context: context,
                  builder: (context) => DialogWidgetYesNo(
                    urlIcon: "assets/images/trashcan_image.png",
                    title: "Are You Sure?",
                    subtitle:
                        "Lorem ipsum dolor sit amet consectetur. Egestas porttitor risus enim cursus rutrum molestie tortor",
                    textForButtonNo: "No",
                    textForButtonYes: "Yes",
                    navigatorFunctionNo: () {
                      Navigator.pop(context);
                    },
                    navigatorFunctionYes: () {},
                  ),
                );
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
                  print("check");
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
              onPressed: () {
                print("Reply QUot");
              },
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
                "Reply Quotation",
                style: text16.copyWith(color: whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
