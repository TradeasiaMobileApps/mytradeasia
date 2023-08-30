import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/config/themes/theme.dart';

class TrackingDocumentScreen extends StatelessWidget {
  const TrackingDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String productName = "Dipentene";
    return Scaffold(
      backgroundColor: whiteColor,
      // Appbar
      appBar: AppBar(
        title: const Text(
          "Tracking Document",
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
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: InkWell(
                      onTap: () {
                        TrackingDocumentParameter parameter =
                            TrackingDocumentParameter(
                                product: productName, indexProducts: index + 1);

                        context.goNamed("detail_tracking_document",
                            extra: parameter);

                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return TrackingDocumentDetail(
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
                                            Radius.circular(size20px / 2.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              "Shipped",
                                              style: body1Regular.copyWith(
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
                                            Radius.circular(size20px / 2.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              "Pending",
                                              style: body1Regular.copyWith(
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
                                const SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    // shipments
                                    Expanded(
                                      child: Container(
                                        height: 62.0,
                                        width: 140,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
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
                                  style:
                                      body2Medium.copyWith(color: greyColor2),
                                )
                              ],
                            ),
                          ),
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
    );
  }
}
