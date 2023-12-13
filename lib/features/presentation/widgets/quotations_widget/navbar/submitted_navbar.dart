import 'package:flutter/material.dart';

import '../../../../../config/themes/theme.dart';

class SubmittedNavbar extends StatelessWidget {
  const SubmittedNavbar({
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
                backgroundColor:
                    MaterialStateProperty.all<Color>(inactivatedBtn),
                elevation: MaterialStateProperty.all<double>(0.0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        side: const BorderSide(color: greyColor))),
              ),
              onPressed: null,
              child: const Icon(
                Icons.close,
                color: greyColor,
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
                      MaterialStateProperty.all<Color>(inactivatedBtn),
                  elevation: MaterialStateProperty.all<double>(0.0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          side: const BorderSide(color: greyColor))),
                ),
                onPressed: null,
                child: const Icon(
                  Icons.check,
                  color: greyColor,
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
                backgroundColor: MaterialStateProperty.all<Color>(greyColor),
                elevation: MaterialStateProperty.all<double>(0.0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                )),
              ),
              child: Text(
                "Chat Now",
                style: text16.copyWith(color: whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
