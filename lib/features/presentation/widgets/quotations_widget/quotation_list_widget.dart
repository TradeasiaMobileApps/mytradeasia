import 'package:flutter/material.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';

import '../../../../config/themes/theme.dart';

class QuotationListWidget extends StatelessWidget {
  const QuotationListWidget({super.key, required this.rfqEntities});

  final List<RfqEntity> rfqEntities;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: size20px, right: size20px),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: rfqEntities.length,
              itemBuilder: (context, index) {
                var rfq = rfqEntities[index];
                switch (rfq.quotationStatus) {
                  case value:
                    break;
                  default:
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
