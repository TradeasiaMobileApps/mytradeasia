import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_to_rfq_entity.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/add_recently_seen.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_event.dart';
import 'package:mytradeasia/features/presentation/state_management/industry_bloc/industry_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/industry_bloc/industry_event.dart';
import 'package:mytradeasia/features/presentation/state_management/industry_bloc/industry_state.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/list_product/list_product_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/list_product/list_product_event.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/list_product/list_product_state.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/search_product/search_product_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/search_product/search_product_event.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/search_product/search_product_state.dart';
import 'package:mytradeasia/features/presentation/widgets/cart_button.dart';
import 'package:mytradeasia/features/presentation/widgets/product_card.dart';
import 'package:mytradeasia/helper/injections_container.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../config/routes/parameters.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final TextEditingController _searchProductController =
      TextEditingController();
  final AddRecentlySeen _addRecentlySeen = injections<AddRecentlySeen>();
  Timer? debouncerTime;

  Future<void> _getListProducts() async {
    BlocProvider.of<ListProductBloc>(context).add(const GetProducts());
  }

  @override
  void initState() {
    BlocProvider.of<ListProductBloc>(context).add(const DisposeProducts());
    BlocProvider.of<ListProductBloc>(context).add(const GetProducts());
    BlocProvider.of<CartBloc>(context).add(const GetCartItems());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<CartBloc>(context).add(const GetCartItems());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchProductController.dispose();
    debouncerTime?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String url = "https://chemtradea.chemtradeasia.com/";
    var industryBloc = BlocProvider.of<IndustryBloc>(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getListProducts,
        color: primaryColor1,
        edgeOffset: size20px * 3,
        child: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Padding(
                padding: const EdgeInsets.only(
                    right: size20px, left: size20px, top: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pop(context);
                          },
                          child: Image.asset(
                            "assets/images/icon_back.png",
                            width: 24.0,
                            height: 24.0,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Form(
                              child: TextFormField(
                                controller: _searchProductController,
                                onChanged: ((value) {
                                  if (debouncerTime?.isActive ?? false) {
                                    debouncerTime?.cancel();
                                  }

                                  debouncerTime = Timer(
                                      const Duration(milliseconds: 700), () {
                                    BlocProvider.of<SearchProductBloc>(context)
                                        .add(SearchProduct(
                                            _searchProductController.text));

                                    // Provider.of<SearchProductProvider>(context,
                                    //         listen: false)
                                    //     .getListProduct(
                                    //         _searchProductController.text);
                                  });
                                }),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: greyColor3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(size20px / 2),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: greyColor3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(size20px / 2),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: whiteColor,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 15.0),
                                    child: Image.asset(
                                      "assets/images/icon_search.png",
                                      width: 24.0,
                                      height: 24.0,
                                    ),
                                  ),
                                  hintText: "What do you want to search",
                                  hintStyle:
                                      body1Regular.copyWith(color: greyColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        authState.role != "Sales"
                            ? Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: secondaryColor1,
                                    borderRadius: BorderRadius.circular(7)),
                                child: const CartButton(),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: size20px + 10, bottom: size20px - 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("All Products", style: text18),
                          InkWell(
                            onTap: () {
                              industryBloc.add(const GetIndustry());

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
                                                "Industries",
                                                style: heading2,
                                              ),
                                            ),
                                            BlocBuilder<IndustryBloc,
                                                    IndustryState>(
                                                builder: (context, state) {
                                              if (state is IndustryError) {
                                                return Container();
                                              } else if (state
                                                  is IndustryDone) {
                                                return Column(
                                                  children: [
                                                    GridView.builder(
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
                                                          .industry!
                                                          .detailIndustry
                                                          ?.length,
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
                                                                      .industry!
                                                                      .detailIndustry![
                                                                          index]
                                                                      .industryName ??
                                                                  "",
                                                              style:
                                                                  body1Medium,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: size20px + 35,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
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
                                                            padding: MaterialStateProperty
                                                                .all<EdgeInsets>(
                                                                    EdgeInsets
                                                                        .zero)),
                                                        onPressed: () {},
                                                        child: Text(
                                                          "See Result",
                                                          style: text16.copyWith(
                                                              color:
                                                                  whiteColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(),
                                                );
                                              }
                                            })
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

                    // GRID All Product
                    Expanded(
                      child: BlocBuilder<SearchProductBloc, SearchProductState>(
                        builder: (context, searchState) {
                          return BlocBuilder<ListProductBloc, ListProductState>(
                              builder: (_, state) {
                            return _searchProductController.text.isEmpty
                                /* All product */
                                ? GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 15,
                                            childAspectRatio: 0.6),
                                    itemCount: state is ListProductLoading
                                        ? 6
                                        : state.products?.length,
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

                                            // context.pushNamed("product",
                                            //     pathParameters: {
                                            //       'url': state.products![index]
                                            //               .seoUrl ??
                                            //           "/images/product/alum.webp"
                                            //     });

                                            // Map<String, dynamic> data = {
                                            //   "productId":
                                            //       state.products![index].id,
                                            //   "productName": state
                                            //       .products![index].productname,
                                            //   "casNumber": state
                                            //       .products![index].casNumber,
                                            //   "hsCode":
                                            //       state.products![index].hsCode,
                                            //   "productImage": state
                                            //       .products![index].productimage
                                            // };

                                            // await _addRecentlySeen(param: data);
                                          },
                                          child: authState.role != "Sales"
                                              ? ProductCard(
                                                  product: ProductEntity(
                                                      productname: state
                                                          .products![index]
                                                          .productname,
                                                      productimage: state
                                                          .products![index]
                                                          .productimage,
                                                      casNumber: state
                                                          .products![index]
                                                          .casNumber,
                                                      hsCode: state
                                                          .products![index]
                                                          .hsCode),
                                                  onPressed: () {
                                                    List<ProductToRfq>
                                                        products = [];
                                                    ProductToRfq product =
                                                        ProductToRfq(
                                                      productName: state
                                                          .products![index]
                                                          .productname!,
                                                      productImage: state
                                                          .products![index]
                                                          .productimage!,
                                                      hsCode: state
                                                          .products![index]
                                                          .hsCode!,
                                                      casNumber: state
                                                          .products![index]
                                                          .casNumber!,
                                                    );
                                                    products.add(product);

                                                    RequestQuotationParameter
                                                        param =
                                                        RequestQuotationParameter(
                                                      products: products,
                                                    );
                                                    context.go(
                                                        "/home/request_quotation",
                                                        extra: param);
                                                  },
                                                )
                                              : ProductCard(
                                                  product: ProductEntity(
                                                      productname: state
                                                          .products![index]
                                                          .productname,
                                                      productimage: state
                                                          .products![index]
                                                          .productimage,
                                                      casNumber: state
                                                          .products![index]
                                                          .casNumber,
                                                      hsCode: state
                                                          .products![index]
                                                          .hsCode),
                                                  isNotRecentSeenCard: false,
                                                ),
                                        );
                                      }
                                    },
                                  )
                                // Search Provider
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 15,
                                            childAspectRatio: 0.6),
                                    itemCount: searchState
                                            is SearchProductLoading
                                        ? 4
                                        : searchState.searchProducts!.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      if (searchState is SearchProductLoading) {
                                        return Shimmer.fromColors(
                                            baseColor: greyColor3,
                                            highlightColor: greyColor,
                                            child: const Card());
                                      } else if (searchState
                                          .searchProducts!.isEmpty) {
                                        return const Center(
                                          child: Text("No Product Found"),
                                        );
                                      } else {
                                        return InkWell(
                                            onTap: () async {
                                              // context.pushNamed("product",
                                              //     pathParameters: {
                                              //       'url': searchState
                                              //               .searchProducts![
                                              //                   index]
                                              //               .seoUrl ??
                                              //           "/en/acrylic-acid"
                                              //     });

                                              // Map<String, dynamic> data = {
                                              //   "productName": searchState
                                              //       .searchProducts![index]
                                              //       .productname,

                                              //   "casNumber": searchState
                                              //       .searchProducts![index]
                                              //       .casNumber,
                                              //   "hsCode": searchState
                                              //       .searchProducts![index]
                                              //       .hsCode,
                                              //   "productImage": searchState
                                              //       .searchProducts![index]
                                              //       .productimage
                                              // };
                                              // await _addRecentlySeen(
                                              //     param: data);
                                            },
                                            child: ProductCard(
                                              product: ProductEntity(
                                                productname: searchState
                                                    .searchProducts![index]
                                                    .productname!,
                                                productimage: searchState
                                                    .searchProducts![index]
                                                    .productimage!,
                                                casNumber: searchState
                                                    .searchProducts![index]
                                                    .casNumber!,
                                                hsCode: searchState
                                                    .searchProducts![index]
                                                    .hsCode!,
                                              ),
                                              onPressed: () {
                                                List<ProductToRfq> products =
                                                    [];
                                                ProductToRfq product =
                                                    ProductToRfq(
                                                  productName: searchState
                                                      .searchProducts![index]
                                                      .productname!,
                                                  productImage: searchState
                                                      .searchProducts![index]
                                                      .productimage!,
                                                  hsCode: searchState
                                                      .searchProducts![index]
                                                      .hsCode!,
                                                  casNumber: searchState
                                                      .searchProducts![index]
                                                      .casNumber!,
                                                );
                                                products.add(product);

                                                RequestQuotationParameter
                                                    param =
                                                    RequestQuotationParameter(
                                                  products: products,
                                                );
                                                context.go(
                                                    "/home/request_quotation",
                                                    extra: param);
                                              },
                                            ));
                                      }
                                    },
                                  );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
