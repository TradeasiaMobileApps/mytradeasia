import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mytradeasia/utils/theme.dart';
import 'package:mytradeasia/view/auth/login/login_screen.dart';

class QuotationsScreen extends StatelessWidget {
  const QuotationsScreen({super.key});

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
            Padding(
              padding: const EdgeInsets.only(left: size20px, right: size20px),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Quotations(
                          status: "Submitted",
                          fontStatusColor: yellowColor,
                          backgroundStatusColor: yellowColor2,
                          navigationPage: () => const LoginScreen(),
                        ),
                        Quotations(
                          status: "Approved",
                          fontStatusColor: greenColor1,
                          backgroundStatusColor: greenColor2,
                          navigationPage: () => const LoginScreen(),
                        ),
                        Quotations(
                          status: "Rejected",
                          fontStatusColor: redColor1,
                          backgroundStatusColor: redColor2,
                          navigationPage: () => const LoginScreen(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

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

class Quotations extends StatelessWidget {
  const Quotations(
      {Key? key,
      required this.status,
      required this.fontStatusColor,
      required this.backgroundStatusColor,
      required this.navigationPage})
      : super(key: key);

  final String status;
  final Color fontStatusColor;
  final Color backgroundStatusColor;
  final Function() navigationPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigationPage,
      child: Container(
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
                        style: heading3.copyWith(color: secondaryColor1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: size20px),
                      child: Container(
                        decoration: BoxDecoration(
                            color: backgroundStatusColor,
                            borderRadius: BorderRadius.circular(size20px * 5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: size20px - 9.0, vertical: 1.0),
                          child: Text(
                            status,
                            style:
                                body1Regular.copyWith(color: fontStatusColor),
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
                  padding: EdgeInsets.symmetric(vertical: size20px / 2.0),
                  child: DottedLine(
                    dashColor: greyColor3,
                    dashGapLength: 3.0,
                    dashLength: 5.0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: size20px / 2),
                  child: Text(
                    "Dipentene",
                    style: text15,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quantity/Unit",
                        style: body2Medium.copyWith(color: greyColor2)),
                    const Text("800 Tone/Tones", style: body1Medium),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: size20px - 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Incoterm",
                          style: body2Medium.copyWith(color: greyColor2)),
                      const Text("FOB", style: body1Medium),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Port of Destination",
                        style: body2Medium.copyWith(color: greyColor2)),
                    const Text("Any port in Vietnam", style: body1Medium),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
