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

class RfqListWidget extends StatefulWidget {
  const RfqListWidget(
      {super.key, required this.rfqEntities, required this.status});

  final List<RfqEntity> rfqEntities;
  final String status;

  @override
  State<RfqListWidget> createState() => _RfqListWidgetState();
}

class _RfqListWidgetState extends State<RfqListWidget> {
  @override
  void initState() {
    _getListQuotations();
    super.initState();
  }

  Future<void> _getListQuotations() async {
    BlocProvider.of<QuotationBloc>(context).add(const DisposeQuotation());
    BlocProvider.of<QuotationBloc>(context).add(const GetRFQs());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: size20px, right: size20px),
      child: Column(
        children: [
          BlocBuilder<QuotationBloc, QuotationState>(
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
              print(state.rfq!);

              return Expanded(
                child: ListView.builder(
                  itemCount: state.rfq!.length,
                  itemBuilder: (context, index) {
                    var rfq = state.rfq![index];

                    if (rfq.quotationStatus == widget.status ||
                        widget.status == "All") {
                      switch (rfq.quotationStatus!) {
                        case "Quoted":
                          return QuotationsWidget(
                              rfqEntity: rfq,
                              status: rfq.quotationStatus!,
                              fontStatusColor: orangeColor1,
                              backgroundStatusColor: orangeColor2,
                              navigationPage: () {
                                /* With go_router */
                                QuotationDetailParameter param =
                                    QuotationDetailParameter(
                                        status: 'quoted', rfqEntity: rfq);

                                context.push(
                                    "/mytradeasia/quotations/detail_quotation",
                                    extra: param);
                              });
                        case "Submitted":
                          return QuotationsWidget(
                              rfqEntity: rfq,
                              status: rfq.quotationStatus!,
                              fontStatusColor: yellowColor,
                              backgroundStatusColor: yellowColor2,
                              navigationPage: () {
                                /* With go_router */
                                QuotationDetailParameter param =
                                    QuotationDetailParameter(
                                        status: 'submitted', rfqEntity: rfq);

                                context.push(
                                    "/mytradeasia/quotations/detail_quotation",
                                    extra: param);
                              });

                        case "Rejected":
                          return QuotationsWidget(
                              rfqEntity: rfq,
                              status: rfq.quotationStatus!,
                              fontStatusColor: redColor1,
                              backgroundStatusColor: redColor2,
                              navigationPage: () {
                                /* With go_router */
                                QuotationDetailParameter param =
                                    QuotationDetailParameter(
                                        status: 'rejected', rfqEntity: rfq);

                                context.push(
                                    "/mytradeasia/quotations/detail_quotation",
                                    extra: param);
                              });
                        case "Approved":
                          return QuotationsWidget(
                              rfqEntity: rfq,
                              status: rfq.quotationStatus!,
                              fontStatusColor: greenColor1,
                              backgroundStatusColor: greenColor2,
                              navigationPage: () {
                                /* With go_router */
                                QuotationDetailParameter param =
                                    QuotationDetailParameter(
                                        status: 'approved', rfqEntity: rfq);

                                context.push(
                                    "/mytradeasia/quotations/detail_quotation",
                                    extra: param);
                              });
                        default:
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                      }
                    }
                    return const SizedBox();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
