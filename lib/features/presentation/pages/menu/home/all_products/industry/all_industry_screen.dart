import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/features/presentation/state_management/industry_bloc/industry_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/industry_bloc/industry_event.dart';
import 'package:mytradeasia/features/presentation/state_management/industry_bloc/industry_state.dart';
import 'package:mytradeasia/config/themes/theme.dart';

class AllIndustryScreen extends StatefulWidget {
  const AllIndustryScreen({super.key});

  @override
  State<AllIndustryScreen> createState() => _AllIndustryScreenState();
}

class _AllIndustryScreenState extends State<AllIndustryScreen> {
  @override
  void initState() {
    BlocProvider.of<IndustryBloc>(context).add(const GetIndustry());
    super.initState();
  }

  ///function to get industry name
  String? extractWord(String input) {
    final RegExp regex = RegExp(r"/en/industry/([^/]+)/?");
    final Match match = regex.firstMatch(input)!;
    return match.group(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
            BlocProvider.of<IndustryBloc>(context).add(const DisposeState());
          },
          icon: Image.asset(
            "assets/images/icon_back.png",
            width: 24.0,
            height: 24.0,
          ),
        ),
        title: const Text(
          "All Industries",
          style: heading2,
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<IndustryBloc, IndustryState>(
                  builder: (context, state) {
                if (state is IndustryLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                        backgroundColor: primaryColor1),
                  );
                }
                if (state is IndustryError) {
                  return const Center(
                    child: Text("An error occurred"),
                  );
                }

                if (state.industry!.detailIndustry!.isEmpty) {
                  return const Center(child: Text("No Data Found"));
                }

                // state.industry!.detailIndustry!.forEach((e) {
                //   print(extractWord(e.industryUrl!));
                // });

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: state.industry!.detailIndustry!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8),
                  itemBuilder: (context, index) {
                    var photoItem =
                        state.industry!.detailIndustry![index].industryImage!;
                    return InkWell(
                      onTap: () {
                        ProductsIndustryParameter param =
                            ProductsIndustryParameter(
                                index: index,
                                industryName: state.industry!
                                    .detailIndustry![index].industryName!);

                        context.go("/home/all_industry/products_industry",
                            extra: param);

                        // showModalBottomSheet<dynamic>(
                        //   isScrollControlled: true,
                        //   shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.vertical(
                        //           top: Radius.circular(40.0))),
                        //   context: context,
                        //   builder: (context) {
                        //     return Wrap(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.all(20.0),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Center(
                        //                 child: Image.asset(
                        //                   "assets/images/icon_spacing.png",
                        //                   width: 25.0,
                        //                 ),
                        //               ),
                        //               const Padding(
                        //                 padding: EdgeInsets.symmetric(
                        //                     vertical: size20px),
                        //                 child: Center(
                        //                   child: Text(
                        //                     "Categories",
                        //                     style: heading2,
                        //                   ),
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height:
                        //                     MediaQuery.of(context).size.width,
                        //                 width:
                        //                     MediaQuery.of(context).size.width,
                        //                 child: ListView.builder(
                        //                   itemCount: state
                        //                       .industry!
                        //                       .detailIndustry![index]
                        //                       .category!
                        //                       .length,
                        //                   shrinkWrap: true,
                        //                   physics:
                        //                       const BouncingScrollPhysics(),
                        //                   itemBuilder:
                        //                       (context, indexCategory) {
                        //                     return Padding(
                        //                       padding: const EdgeInsets.only(
                        //                           bottom: size24px / 4),
                        //                       child: Container(
                        //                         width: MediaQuery.of(context)
                        //                             .size
                        //                             .width,
                        //                         height: size20px * 2.5,
                        //                         decoration: BoxDecoration(
                        //                             color: indexCategory.isEven
                        //                                 ? thirdColor1
                        //                                 : whiteColor),
                        //                         child: Padding(
                        //                           padding:
                        //                               const EdgeInsets.only(
                        //                                   left: 20.0,
                        //                                   top: 16.0),
                        //                           child: Text(
                        //                             state
                        //                                     .industry!
                        //                                     .detailIndustry![
                        //                                         index]
                        //                                     .category![
                        //                                         indexCategory]
                        //                                     .categoryName ??
                        //                                 "",
                        //                             style: body1Medium,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     );
                        //                   },
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     );
                        //   },
                        // );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: thirdColor1,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                              ),
                              Image.network(
                                photoItem,
                                fit: BoxFit.fill,
                                width: 24,
                                height: size24px,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Text(
                              state.industry!.detailIndustry![index]
                                      .industryName ??
                                  "",
                              style: text10.copyWith(color: fontColor1),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
