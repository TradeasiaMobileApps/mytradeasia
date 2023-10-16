import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/features/data/model/searates_model/searates_bl_model.dart';
import 'package:mytradeasia/features/domain/entities/searates_entities/searates_bl_entity.dart';
import 'package:mytradeasia/features/presentation/state_management/dhl_shipment_bloc/dhl_shipment_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dhl_shipment_bloc/dhl_shipment_event.dart';
import 'package:mytradeasia/features/presentation/state_management/dhl_shipment_bloc/dhl_shipment_state.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/presentation/state_management/searates_bloc/searates_bl/searates_bl_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/searates_bloc/searates_bl/searates_bl_event.dart';
import 'package:mytradeasia/features/presentation/state_management/searates_bloc/searates_bl/searates_bl_state.dart';
import 'package:mytradeasia/helper/helper_functions.dart';

class TrackingShipmentScreen extends StatefulWidget {
  const TrackingShipmentScreen({super.key});

  @override
  State<TrackingShipmentScreen> createState() => _TrackingShipmentScreenState();
}

class _TrackingShipmentScreenState extends State<TrackingShipmentScreen> {
  @override
  void initState() {
    fetchSearatesAPI();
    super.initState();
  }

  void fetchSearatesAPI() async {
    // if (await canCallApi()) {
    //   BlocProvider.of<SearatesBLBloc>(context)
    //       .add(TrackByBLNumber("COAU7885072330"));
    // } else {
    //   print("You can only call the API once a day.");
    // }
    BlocProvider.of<SearatesBLBloc>(context)
        .add(TrackByBLNumber("COAU7885072330"));
  }

  @override
  Widget build(BuildContext context) {
    const String productName = "Dipentene";
    return Scaffold(
      backgroundColor: whiteColor,
      // Appbar
      appBar: AppBar(
        title: const Text(
          "Tracking Shipment",
          style: heading2,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/images/icon_back.png",
            width: 24.0,
            height: 24.0,
          ),
        ),
        elevation: 0.0,
        backgroundColor: whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<SearatesBLBloc, SearatesBLState>(
                builder: (context, state) {
                  // const data = state.data;

                  if (state is SearatesBLLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is SearatesBLDone) {
                    log("BL DATA ${state.data!.toJson()}");

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.data!.data!.containers!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: InkWell(
                            onTap: () {
                              TrackingShipmentParameter parameter =
                                  TrackingShipmentParameter(data: state.data!);

                              context.pushNamed("detail_tracking_shipment",
                                  extra: parameter);

                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) {
                              //     return TrackingShipmentDetailScreen(
                              //       product: productName,
                              //       indexProducts: index + 1,
                              //     );
                              //   },
                              // ));
                            },
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 5.0,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 218.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            productName,
                                            style: heading2,
                                          ),
                                          const Spacer(),
                                          if (index.isEven)
                                            Container(
                                              height: size20px + 4,
                                              decoration: const BoxDecoration(
                                                color: greenColor2,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size20px / 2.0),
                                                ),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    "Shipped",
                                                    style:
                                                        body1Regular.copyWith(
                                                            color: greenColor1),
                                                  ),
                                                ),
                                              ),
                                            )
                                          else
                                            Container(
                                              height: size20px + 4,
                                              decoration: const BoxDecoration(
                                                color: redColor2,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size20px / 2.0),
                                                ),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    "Pending",
                                                    style:
                                                        body1Regular.copyWith(
                                                            color: redColor1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          const SizedBox(width: 16.0),
                                          Image.asset(
                                            "assets/images/icon_forward.png",
                                            width: 24.0,
                                            height: 24.0,
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          // shipments
                                          Expanded(
                                            child: Container(
                                              height: 62.0,
                                              width: 140,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  color: blueColor),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/icon_docs_full.png",
                                                    width: 24.0,
                                                    height: 24.0,
                                                  ),
                                                  const SizedBox(
                                                    width: 11.0,
                                                  ),
                                                  const Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Shipments",
                                                        style: body1Regular,
                                                      ),
                                                      Text(
                                                        "5 BKG",
                                                        style: heading2,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16.0),
                                          // containers
                                          Expanded(
                                            child: Container(
                                              height: 62.0,
                                              width: 140,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  color: blueColor),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/icon_container.png",
                                                    width: 24.0,
                                                    height: 24.0,
                                                  ),
                                                  const SizedBox(
                                                    width: 11.0,
                                                  ),
                                                  const Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Containers",
                                                        style: body1Regular,
                                                      ),
                                                      Text(
                                                        "10 TEU",
                                                        style: heading2,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: size20px / 2),
                                          child: Image.asset(
                                              "assets/images/shipping_indicator_length.png")),
                                      Text(
                                        "Lorem ipsum dolor sit amet consectetur. In est",
                                        style: body2Medium.copyWith(
                                            color: greyColor2),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: Text("${state.error}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
