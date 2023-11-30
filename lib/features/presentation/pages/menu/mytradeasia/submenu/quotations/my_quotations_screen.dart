import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_data/salesforce_data_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_data/salesforce_data_event.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_data/salesforce_data_state.dart';

import '../../../../../widgets/quotation_widget.dart';

class QuotationsScreen extends StatefulWidget {
  const QuotationsScreen({super.key});

  @override
  State<QuotationsScreen> createState() => _QuotationsScreenState();
}

class _QuotationsScreenState extends State<QuotationsScreen> {
  @override
  void initState() {
    BlocProvider.of<SalesforceDataBloc>(context)
        .add(GetOpportunitySalesforce('0018G00000XtspzQAB'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            indicatorColor: primaryColor1,
            tabs: [
              Tab(
                child: Text(
                  "All",
                  style: heading2,
                ),
              ),
              Tab(
                child: Text(
                  "Submitted",
                  style: heading2,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // All Quotation
            BlocBuilder<SalesforceDataBloc, SalesforceDataState>(
                builder: (context, state) {
              if (state is SalesforceOpportunityDone) {
                if (state.opportunityEntity!.records!.isEmpty) {
                  return Center(
                    child: Text(
                      "No quotations yet",
                      style: text15,
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.opportunityEntity!.records!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: size20px, right: size20px),
                              child: QuotationsWidget(
                                  opportunityData:
                                      state.opportunityEntity!.records![index],
                                  status: "Submitted",
                                  fontStatusColor: yellowColor,
                                  backgroundStatusColor: yellowColor2,
                                  navigationPage: () {
                                    /* With go_router */
                                    QuotationDetailParameter param =
                                        QuotationDetailParameter(
                                            status: 'submitted',
                                            opportunity: state
                                                .opportunityEntity!
                                                .records![index]);

                                    context.push(
                                        "/mytradeasia/quotations/detail_quotation",
                                        extra: param);

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const QuotationDetailScreen(
                                    //       status: "submitted",
                                    //     ),
                                    //   ),
                                    // )
                                  }),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.opportunityEntity!.records!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: size20px, right: size20px),
                              child: QuotationsWidget(
                                  opportunityData:
                                      state.opportunityEntity!.records![index],
                                  status: "Submitted",
                                  fontStatusColor: yellowColor,
                                  backgroundStatusColor: yellowColor2,
                                  navigationPage: () {
                                    /* With go_router */
                                    QuotationDetailParameter param =
                                        QuotationDetailParameter(
                                            status: 'submitted',
                                            opportunity: state
                                                .opportunityEntity!
                                                .records![index]);

                                    context.push(
                                        "/mytradeasia/quotations/detail_quotation",
                                        extra: param);

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const QuotationDetailScreen(
                                    //       status: "submitted",
                                    //     ),
                                    //   ),
                                    // )
                                  }),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              } else if (state is SalesforceDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Text(state.error!.message!),
                );
              }
            }),

            // Submitted Quotations
            Padding(
              padding: const EdgeInsets.only(left: size20px, right: size20px),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          height: size20px * 8,
                          margin: const EdgeInsets.only(top: size20px),
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: size20px / 2,
                                  bottom: size20px / 2,
                                  left: size20px,
                                  right: size20px),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Dimas Pradipta putraaaaaa",
                                          style: heading3.copyWith(
                                              color: secondaryColor1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: size20px),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: yellowColor2,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size20px * 5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: size20px - 9.0,
                                                vertical: 1.0),
                                            child: Text(
                                              "Submitted",
                                              style: body1Regular.copyWith(
                                                  color: yellowColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        "assets/images/icon_forward.png",
                                        width: size20px,
                                        height: size20px,
                                        color: greyColor,
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size20px / 2.0),
                                    child: DottedLine(
                                      dashColor: greyColor3,
                                      dashGapLength: 3.0,
                                      dashLength: 5.0,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(bottom: size20px / 2),
                                    child: Text(
                                      "Dipentene",
                                      style: text15,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Quantity/Unit",
                                          style: body2Medium.copyWith(
                                              color: greyColor2)),
                                      const Text("800 Tone/Tones",
                                          style: body1Medium),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: size20px - 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Incoterm",
                                            style: body2Medium.copyWith(
                                                color: greyColor2)),
                                        const Text("FOB", style: body1Medium),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Port of Destination",
                                          style: body2Medium.copyWith(
                                              color: greyColor2)),
                                      const Text("Any port in Vietnam",
                                          style: body1Medium),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesQuotationsScreen extends StatelessWidget {
  const SalesQuotationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            indicatorColor: primaryColor1,
            tabs: [
              Tab(
                child: Text(
                  "All",
                  style: heading2,
                ),
              ),
              Tab(
                child: Text(
                  "New",
                  style: heading2,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // All Quotation
            Padding(
              padding: const EdgeInsets.only(left: size20px, right: size20px),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        SalesQuotationsWidget(
                            status: "New Request",
                            fontStatusColor: secondaryColor1,
                            backgroundStatusColor: thirdColor1,
                            navigationPage: () {
                              QuotationDetailParameter param =
                                  QuotationDetailParameter(
                                      status: 'sales', isSales: true);
                              context.push(
                                  "/mytradeasia/sales_quotations/detail_quotation",
                                  extra: param);
                            }

                            // Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) =>
                            //               const QuotationDetailScreen(
                            //             status: "sales",
                            //             isSales: true,
                            //           ),
                            //         ))
                            )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // New Quotation
            Padding(
              padding: const EdgeInsets.only(left: size20px, right: size20px),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        return Container(
                          height: size20px * 8,
                          margin: const EdgeInsets.only(top: size20px),
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: size20px / 2,
                                  bottom: size20px / 2,
                                  left: size20px,
                                  right: size20px),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Dimas Pradipta Putra",
                                          style: heading3.copyWith(
                                              color: secondaryColor1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: size20px),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: yellowColor2,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size20px * 5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: size20px - 9.0,
                                                vertical: 1.0),
                                            child: Text(
                                              "Submitted",
                                              style: body1Regular.copyWith(
                                                  color: yellowColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        "assets/images/icon_forward.png",
                                        width: size20px,
                                        height: size20px,
                                        color: greyColor,
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size20px / 2.0),
                                    child: DottedLine(
                                      dashColor: greyColor3,
                                      dashGapLength: 3.0,
                                      dashLength: 5.0,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(bottom: size20px / 2),
                                    child: Text(
                                      "Dipentene",
                                      style: text15,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Quantity/Unit",
                                          style: body2Medium.copyWith(
                                              color: greyColor2)),
                                      const Text("800 Tone/Tones",
                                          style: body1Medium),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: size20px - 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Incoterm",
                                            style: body2Medium.copyWith(
                                                color: greyColor2)),
                                        const Text("FOB", style: body1Medium),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Port of Destination",
                                          style: body2Medium.copyWith(
                                              color: greyColor2)),
                                      const Text("Any port in Vietnam",
                                          style: body1Medium),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
