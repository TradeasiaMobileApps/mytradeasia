import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';
import 'package:mytradeasia/features/presentation/state_management/quotations_bloc/quotations_event.dart';
import 'package:mytradeasia/features/presentation/widgets/quotations_widget/quotation_widget.dart';

import '../../../../config/routes/parameters.dart';
import '../../../../config/themes/theme.dart';
import '../../state_management/quotations_bloc/quotations_bloc.dart';
import '../../state_management/quotations_bloc/quotations_state.dart';

class SalesRfqListWidget extends StatefulWidget {
  const SalesRfqListWidget(
      {super.key, required this.rfqEntities, required this.status});

  final List<RfqEntity> rfqEntities;
  final String status;

  @override
  State<SalesRfqListWidget> createState() => _SalesRfqListWidgetState();
}

class _SalesRfqListWidgetState extends State<SalesRfqListWidget> {
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
    return RefreshIndicator(
      onRefresh: _getListQuotations,
      color: primaryColor1,
      edgeOffset: size20px * 3,
      child: Padding(
        padding: const EdgeInsets.only(left: size20px, right: size20px),
        child: Column(
          children: [
            BlocBuilder<QuotationBloc, QuotationState>(
              bloc: _quotationBloc,
              builder: (context, state) {
                if (state is InitialQuotations) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is QuotationError) {
                  return const Center(
                    child: Icon(Icons.warning),
                  );
                }

                if (state is QuotationDone) {
                  switch (widget.status) {
                    case "Submitted":
                      var rfq = state.rfq?.submitted;
                      return rfqTabWidget(rfq);
                    case "Quoted":
                      var rfq = state.rfq?.quoted;
                      return rfqTabWidget(rfq);
                    case "Rejected":
                      var rfq = state.rfq?.rejected;
                      return rfqTabWidget(rfq);
                    case "Approved":
                      var rfq = state.rfq?.approved;
                      return rfqTabWidget(rfq);
                    default:
                  }
                  // return Expanded(
                  //   child: ListView.builder(
                  //     itemCount: state.rfq!.length,
                  //     itemBuilder: (context, index) {
                  //       var rfq = state.rfq![index];

                  //       if (rfq.quotationStatus == widget.status ||
                  //           widget.status == "All") {
                  //         switch (rfq.quotationStatus!) {
                  //           case "Quoted":
                  //             return QuotationsWidget(
                  //                 rfqEntity: rfq,
                  //                 status: rfq.quotationStatus!,
                  //                 fontStatusColor: orangeColor1,
                  //                 backgroundStatusColor: orangeColor2,
                  //                 navigationPage: () {
                  //                   /* With go_router */
                  //                   QuotationDetailParameter param =
                  //                       QuotationDetailParameter(
                  //                           status: 'quoted', rfqEntity: rfq);

                  //                   context.push(
                  //                       "/mytradeasia/quotations/detail_quotation",
                  //                       extra: param);
                  //                 });
                  //           case "Pending":
                  //             return QuotationsWidget(
                  //                 rfqEntity: rfq,
                  //                 status: rfq.quotationStatus!,
                  //                 fontStatusColor: yellowColor,
                  //                 backgroundStatusColor: yellowColor2,
                  //                 navigationPage: () {
                  //                   /* With go_router */
                  //                   QuotationDetailParameter param =
                  //                       QuotationDetailParameter(
                  //                           status: 'pending', rfqEntity: rfq);

                  //                   context.push(
                  //                       "/mytradeasia/quotations/detail_quotation",
                  //                       extra: param);
                  //                 });

                  //           case "Rejected":
                  //             return QuotationsWidget(
                  //                 rfqEntity: rfq,
                  //                 status: rfq.quotationStatus!,
                  //                 fontStatusColor: redColor1,
                  //                 backgroundStatusColor: redColor2,
                  //                 navigationPage: () {
                  //                   /* With go_router */
                  //                   QuotationDetailParameter param =
                  //                       QuotationDetailParameter(
                  //                           status: 'rejected', rfqEntity: rfq);

                  //                   context.push(
                  //                       "/mytradeasia/quotations/detail_quotation",
                  //                       extra: param);
                  //                 });
                  //           case "Approved":
                  //             return QuotationsWidget(
                  //                 rfqEntity: rfq,
                  //                 status: rfq.quotationStatus!,
                  //                 fontStatusColor: greenColor1,
                  //                 backgroundStatusColor: greenColor2,
                  //                 navigationPage: () {
                  //                   /* With go_router */
                  //                   QuotationDetailParameter param =
                  //                       QuotationDetailParameter(
                  //                           status: 'approved', rfqEntity: rfq);

                  //                   context.push(
                  //                       "/mytradeasia/quotations/detail_quotation",
                  //                       extra: param);
                  //                 });
                  //           // default:
                  //           //   return const Center(
                  //           //     child: CircularProgressIndicator.adaptive(),
                  //           //   );
                  //         }
                  //       }
                  //       return const SizedBox();
                  //     },
                  //   ),
                  // );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget rfqTabWidget(List<RfqEntity>? rfq) {
    return Expanded(
      child: ListView.builder(
        itemCount: rfq?.length ?? 0,
        itemBuilder: (context, index) {
          return QuotationsWidget(
              rfqEntity: rfq![index],
              status: rfq[index].quotationStatus!,
              fontStatusColor: yellowColor,
              backgroundStatusColor: yellowColor2,
              navigationPage: () {
                /* With go_router */
                QuotationDetailParameter param = QuotationDetailParameter(
                    status: 'submitted', rfqEntity: rfq[index]);

                context.push("/mytradeasia/quotations/detail_quotation",
                    extra: param);
              });
        },
      ),
    );
  }
}
