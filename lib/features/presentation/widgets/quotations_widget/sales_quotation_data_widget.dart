import 'package:flutter/material.dart';

import '../../../../config/themes/theme.dart';

class SalesQuotationData extends StatelessWidget {
  const SalesQuotationData({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size20px * 5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quotations",
            style: heading2,
          ),
          const SizedBox(
            height: size20px + 2,
          ),
          Text(
            "Not yet available",
            style: body2Medium.copyWith(color: greyColor2),
          ),
        ],
      ),
    );
  }
}
