import 'package:flutter/material.dart';

import '../../../../../config/themes/theme.dart';

class RejectedNavbar extends StatelessWidget {
  const RejectedNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size20px * 9.75,
      height: size20px * 2.75,
      child: ElevatedButton(
        onPressed: () {
          print("rejected");
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(primaryColor1),
          elevation: WidgetStateProperty.all<double>(0.0),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          )),
        ),
        child: Text(
          "Make another RFQ",
          style: text16.copyWith(color: whiteColor),
        ),
      ),
    );
  }
}
