import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/presentation/state_management/category_bloc/category_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/category_bloc/category_event.dart';
import 'package:mytradeasia/features/presentation/widgets/banner_industry_products_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../config/routes/parameters.dart';
import '../../../../../../../config/themes/theme.dart';
import '../../../../../../../helper/injections_container.dart';
import '../../../../../../domain/entities/product_entities/product_entity.dart';
import '../../../../../../domain/entities/product_entities/product_to_rfq_entity.dart';
import '../../../../../../domain/usecases/user_usecases/add_recently_seen.dart';
import '../../../../../state_management/auth_bloc/auth_bloc.dart';
import '../../../../../state_management/auth_bloc/auth_state.dart';
import '../../../../../state_management/category_bloc/category_state.dart';
import '../../../../../state_management/product_bloc/list_product/list_product_bloc.dart';
import '../../../../../state_management/product_bloc/list_product/list_product_event.dart';
import '../../../../../state_management/product_bloc/list_product/list_product_state.dart';
import '../../../../../widgets/cart_button.dart';
import '../../../../../widgets/product_card.dart';

class ProductByIndustryScreen extends StatefulWidget {
  final int industryIndex;
  final String industryName;
  const ProductByIndustryScreen({
    super.key,
    required this.industryIndex,
    required this.industryName,
  });

  @override
  State<ProductByIndustryScreen> createState() =>
      _ProductByIndustryScreenState();
}

class _ProductByIndustryScreenState extends State<ProductByIndustryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  @override
  void initState() {
    BlocProvider.of<ListProductBloc>(context).add(const DisposeProducts());
    BlocProvider.of<CategoryBloc>(context).add(const DisposeCategoryState());
    BlocProvider.of<CategoryBloc>(context).add(const GetCategories());
    BlocProvider.of<ListProductBloc>(context).add(const GetProducts());
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      edgeOffset: size20px * 3.5,
      color: primaryColor1,
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(right: size20px, left: size20px, top: 8.0),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Column(
                children: [
                  // const SizedBox(height: size20px - 12.0),
                  SizedBox(
                    height: size20px + 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pop(context);
                          },
                          child: Image.asset(
                            "assets/images/icon_back.png",
                            width: size20px + 4,
                            height: size20px + 4,
                          ),
                        ),
                        SizedBox(
                          height: size20px + 30,
                          width: size20px * 12,
                          child: Form(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Dipentene",
                                hintStyle: body1Regular,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(size20px / 1.5),
                                  child: Image.asset(
                                    "assets/images/icon_search.png",
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: greyColor3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: secondaryColor1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        authState.role != "Sales"
                            ? Container(
                                width: size20px + 30,
                                height: size20px + 30,
                                decoration: const BoxDecoration(
                                  color: secondaryColor1,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: const CartButton(),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  BannerIndustryProducts(industryType: widget.industryName),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: size20px + 10, bottom: size20px - 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Related Products", style: text18),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(40.0))),
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Image.asset(
                                              "assets/images/icon_spacing.png",
                                              width: 25.0,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            child: Text(
                                              "Categories",
                                              style: heading2,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              BlocBuilder<CategoryBloc,
                                                  CategoryState>(
                                                builder: (context, state) {
                                                  if (state
                                                      is CategoryLoading) {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator
                                                              .adaptive(),
                                                    );
                                                  }

                                                  if (state is CategoryError) {
                                                    return const Center(
                                                      child: Column(
                                                        children: [
                                                          Icon(Icons.warning),
                                                          Text(
                                                              "Categories Data Fetch Error"),
                                                        ],
                                                      ),
                                                    );
                                                  }

                                                  if (state is CategoryDone) {
                                                    return GridView.builder(
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              crossAxisSpacing:
                                                                  size20px - 5,
                                                              mainAxisSpacing:
                                                                  size20px - 5,
                                                              childAspectRatio:
                                                                  3.5),
                                                      itemCount: state
                                                          .categoryIndustry![
                                                              widget
                                                                  .industryIndex]
                                                          .category!
                                                          .length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: thirdColor1,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        size20px /
                                                                            4)),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              state
                                                                      .categoryIndustry![
                                                                          widget
                                                                              .industryIndex]
                                                                      .category![
                                                                          index]
                                                                      .categoryName ??
                                                                  "",
                                                              style:
                                                                  body1Medium,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                  return SizedBox();
                                                },
                                              ),
                                              SizedBox(
                                                height: size20px + 35,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<
                                                                      Color>(
                                                                  primaryColor1),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.0),
                                                        ),
                                                      ),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsets>(
                                                                  EdgeInsets
                                                                      .zero)),
                                                  onPressed: () {},
                                                  child: Text(
                                                    "See Result",
                                                    style: text16.copyWith(
                                                        color: whiteColor),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: size20px * 3,
                            height: size20px + 4,
                            decoration: const BoxDecoration(
                                color: secondaryColor5,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Filter",
                                  style:
                                      text12.copyWith(color: secondaryColor1),
                                ),
                                const SizedBox(width: 2.0),
                                Image.asset("assets/images/icon_filter.png",
                                    width: size20px - 10.0,
                                    height: size20px - 10.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                      child: IndustryProducts(
                          context: context, authState: authState)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class IndustryProducts extends StatelessWidget {
  IndustryProducts({super.key, required this.context, required this.authState});

  final AddRecentlySeen _addRecentlySeen = injections<AddRecentlySeen>();
  final BuildContext context;
  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    // var industryBloc = BlocProvider.of<IndustryBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child:
          BlocBuilder<ListProductBloc, ListProductState>(builder: (_, state) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.6),
          itemCount: state is ListProductLoading ? 6 : state.products?.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            if (state is ListProductLoading) {
              return Shimmer.fromColors(
                  baseColor: greyColor3,
                  highlightColor: greyColor,
                  child: const Card());
            } else {
              return InkWell(
                onTap: () async {
                  /* With go_router */

                  context.pushNamed("product", pathParameters: {
                    'productId': state.products![index].id.toString()
                  });

                  Map<String, dynamic> data = {
                    "productName": state.products![index].productname,
                    "productId": state.products![index].id,
                    "casNumber": state.products![index].casNumber,
                    "hsCode": state.products![index].hsCode,
                    "productImage": state.products![index].productimage
                  };

                  await _addRecentlySeen(param: data);
                },
                child: authState.role != "Sales"
                    ? ProductCard(
                        product: ProductEntity(
                            productId: state.products![index].id,
                            productname: state.products![index].productname,
                            productimage: state.products![index].productimage,
                            casNumber: state.products![index].casNumber,
                            hsCode: state.products![index].hsCode),
                        onPressed: () {
                          List<ProductToRfq> products = [];
                          ProductToRfq product = ProductToRfq(
                            productId: state.products![index].id.toString(),
                            productName: state.products![index].productname!,
                            productImage: state.products![index].productimage!,
                            hsCode: state.products![index].hsCode!,
                            casNumber: state.products![index].casNumber!,
                          );
                          products.add(product);

                          RequestQuotationParameter param =
                              RequestQuotationParameter(
                            products: products,
                          );
                          context.go("/home/request_quotation", extra: param);
                        },
                      )
                    : ProductCard(
                        product: ProductEntity(
                            productId: state.products![index].id,
                            productname: state.products![index].productname,
                            productimage: state.products![index].productimage,
                            casNumber: state.products![index].casNumber,
                            hsCode: state.products![index].hsCode),
                        isNotRecentSeenCard: false,
                      ),
              );
            }
          },
        );
      }),
    );
  }
}
