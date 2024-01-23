import 'package:flutter/material.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';
import 'package:mytradeasia/features/presentation/widgets/quotations_widget/navbar/approved_navbar.dart';
import 'package:mytradeasia/features/presentation/widgets/quotations_widget/navbar/quoted_navbar.dart';
import 'package:mytradeasia/features/presentation/widgets/quotations_widget/quotation_detail_banner_widget.dart';
import 'package:mytradeasia/features/presentation/widgets/quotations_widget/sales_quotation_data_widget.dart';

import '../../../../../../../config/themes/theme.dart';
import '../../../../../widgets/quotations_widget/navbar/rejected_navbar.dart';
import '../../../../../widgets/quotations_widget/navbar/sales_navbar.dart';
import '../../../../../widgets/quotations_widget/navbar/submitted_navbar.dart';

class QuotationDetailScreen extends StatelessWidget {
  const QuotationDetailScreen(
      {super.key, required this.status, this.isSales, required this.rfqEntity});

  final String status;
  final RfqEntity rfqEntity;
  final bool? isSales;

  // static const quotationData = {
  //   "First Name": "Dimas",
  //   "Last Name": "Pradipta",
  //   "Phone Number": "(+62) 885691410815",
  //   "Country": "Bangladesh",
  //   "Company Name": "Tradeasia International",
  //   "Product Name": "DIpentene",
  //   "Quantity": "800",
  //   "Unit": "Tone",
  //   "Incoterm": "FOB",
  //   "Port of Destination": "Any port in Vietnam",
  //   "Message": "...",
  // };

  // static const salesQuotationData = {
  //   "Price": "...",
  //   "Quantity": "...",
  //   "Shipment Date": "...",
  //   "Incoterm": "...",
  //   "Payment Term": "...",
  //   "Validity": "...",
  //   "UOM": "..."
  // };

  Widget dataRow(int index) {
    return Row(
      children: [
        SizedBox(
          width: size20px * 4.0,
          child: Text(rfqEntity.toRfqMap().keys.toList()[index],
              style: body2Medium.copyWith(color: greyColor2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: size20px),
          child: Text(" : ", style: body2Medium.copyWith(color: greyColor2)),
        ),
        Expanded(
          child: Text(
            rfqEntity.toRfqMap().values.toList()[index],
            style: body1Medium,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget editBtn;
    Widget salesQuote;
    Widget detailBanner;
    Widget bottomNav;
    switch (status) {
      case 'rejected':
        editBtn = IconButton(
            onPressed: null,
            icon: Image.asset(
              "assets/images/icon_edit_inactive.png",
              width: size20px + 4,
              color: greyColor2,
            ));
        salesQuote = SalesQuotationData(
          status: status,
        );
        detailBanner = const QuotationDetailBanner(
            status: "Rejected",
            fontColor: redColor1,
            backgroundColor: redColor2);
        bottomNav = const RejectedNavbar();
        break;
      case 'approved':
        editBtn = IconButton(
            onPressed: null,
            icon: Image.asset(
              "assets/images/icon_edit_inactive.png",
              width: size20px + 4,
              color: greyColor2,
            ));
        salesQuote = SalesQuotationData(
          status: status,
        );
        detailBanner = const QuotationDetailBanner(
            status: "Approved",
            fontColor: greenColor1,
            backgroundColor: greenColor2);
        bottomNav = const ApprovedNavbar();
        break;
      case 'submitted':
        editBtn = IconButton(
          onPressed: () {
            print("edit");
          },
          icon: Image.asset(
            "assets/images/icon_edit_active.png",
            width: size20px + 4,
          ),
        );
        salesQuote = SalesQuotationData(
          status: status,
        );
        detailBanner = const QuotationDetailBanner(
            status: "Submitted",
            fontColor: yellowColor,
            backgroundColor: yellowColor2);
        bottomNav = const SubmittedNavbar();
        break;
      case 'quoted':
        editBtn = IconButton(
          onPressed: () {
            print("edit");
          },
          icon: Image.asset(
            "assets/images/icon_edit_active.png",
            width: size20px + 4,
          ),
        );
        detailBanner = const QuotationDetailBanner(
            status: "Quoted",
            fontColor: orangeColor1,
            backgroundColor: orangeColor2);
        bottomNav = const QuotedNavbar();
        salesQuote = SalesQuotationData(
          status: status,
          quoteId: rfqEntity.quoteId,
        );
        break;
      default:
        editBtn = SizedBox();
        salesQuote = SalesQuotationData(
          status: status,
        );
        detailBanner = Container();
        bottomNav = const SalesNavbar();
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "Quotations",
          style: heading2,
        ),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          enableFeedback: false,
          icon: Image.asset(
            "assets/images/icon_back.png",
            width: size20px + 4.0,
            height: size20px + 4.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [editBtn],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: size20px, vertical: size20px - 8.0),
        child: bottomNav,
      ),
      body: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        // padding: const EdgeInsets.symmetric(horizontal: size20px),
        child: Column(
          children: [
            detailBanner,
            // status
            for (int i = 0; i < rfqEntity.toRfqMap().length; i++)
              Padding(
                padding: const EdgeInsets.only(
                    top: size20px / 2, right: size20px, left: size20px),
                child: dataRow(i),
              ),
            const Divider(thickness: 10),
            // quotations
            salesQuote,
          ],
        ),
      ),

      // bottom navbar
    );
  }
}
