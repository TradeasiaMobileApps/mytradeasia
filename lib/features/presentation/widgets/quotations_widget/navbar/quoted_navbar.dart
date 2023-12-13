import 'package:flutter/material.dart';

import '../../../../../config/themes/theme.dart';

class QuotedNavbar extends StatelessWidget {
  const QuotedNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: size20px * 2.75,
            height: size20px * 2.75,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(redColor2),
                elevation: MaterialStateProperty.all<double>(0.0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        side: const BorderSide(color: redColor1))),
              ),
              onPressed: () {},
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
                      MaterialStateProperty.all<Color>(greenColor2),
                  elevation: MaterialStateProperty.all<double>(0.0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          side: const BorderSide(color: greenColor1))),
                ),
                onPressed: () {},
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
                    MaterialStateProperty.all<Color>(primaryColor1),
                elevation: MaterialStateProperty.all<double>(0.0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
