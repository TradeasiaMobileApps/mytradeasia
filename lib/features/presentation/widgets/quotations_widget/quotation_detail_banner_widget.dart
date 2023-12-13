import 'package:flutter/material.dart';

import '../../../../config/themes/theme.dart';

class QuotationDetailBanner extends StatelessWidget {
  const QuotationDetailBanner(
      {super.key,
      required this.status,
      required this.fontColor,
      required this.backgroundColor});
  final String status;
  final Color fontColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size20px - 5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: body1Regular.copyWith(color: fontColor),
          ),
          Text(
            "Lorem ipsum dolor sit amet consectetur.",
            style: body2Light.copyWith(color: fontColor),
          ),
        ],
      ),
    );
  }
}
