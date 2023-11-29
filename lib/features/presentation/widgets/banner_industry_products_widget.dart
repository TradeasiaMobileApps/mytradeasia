import 'package:flutter/material.dart';

import '../../../config/themes/theme.dart';

class BannerIndustryProducts extends StatelessWidget {
  final String industryType;
  const BannerIndustryProducts({super.key, required this.industryType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: size20px),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.all(Radius.circular(size20px - 10.0)),
            child: Image.asset(
              "assets/images/background_products.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: size20px + 17.0, horizontal: size20px),
              child: Text(
                industryType,
                style: heading1.copyWith(color: whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
