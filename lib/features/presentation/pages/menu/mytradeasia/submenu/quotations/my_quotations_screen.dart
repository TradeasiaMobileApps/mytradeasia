import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/presentation/state_management/quotations_bloc/quotations_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/quotations_bloc/quotations_event.dart';
import 'package:mytradeasia/features/presentation/widgets/quotations_widget/rfq_list_widget.dart';

import '../../../../../../../utils/static_data.dart';

class QuotationsScreen extends StatefulWidget {
  const QuotationsScreen({super.key});

  @override
  State<QuotationsScreen> createState() => _QuotationsScreenState();
}

class _QuotationsScreenState extends State<QuotationsScreen> {
  late QuotationBloc _quotationBloc;

  @override
  void initState() {
    _quotationBloc = BlocProvider.of<QuotationBloc>(context);
    _getListQuotations();
    super.initState();
  }

  @override
  void dispose() {
    _quotationBloc.add(const DisposeQuotation());
    super.dispose();
  }

  Future<void> _getListQuotations() async {
    _quotationBloc.add(const DisposeQuotation());
    _quotationBloc.add(const GetRFQs());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
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
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: primaryColor1,
            tabs: [
              Tab(
                child: Text(
                  "Submitted",
                  style: heading2,
                ),
              ),
              Tab(
                child: Text(
                  "Quoted",
                  style: heading2,
                ),
              ),
              Tab(
                child: Text(
                  "Approved",
                  style: heading2,
                ),
              ),
              Tab(
                child: Text(
                  "Rejected",
                  style: heading2,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Submitted Quotations
            RfqListWidget(rfqEntities: rfqEntities, status: "Submitted"),

            // Quoted quotations
            RfqListWidget(rfqEntities: rfqEntities, status: "Quoted"),

            // Approved quotations
            RfqListWidget(rfqEntities: rfqEntities, status: "Approved"),

            // Rejected quotations
            RfqListWidget(rfqEntities: rfqEntities, status: "Rejected"),
          ],
        ),
      ),
    );
  }
}
