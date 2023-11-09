import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_to_rfq_entity.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/top_products_bloc/top_products_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/top_products_bloc/top_products_event.dart';
import 'package:mytradeasia/features/presentation/state_management/top_products_bloc/top_products_state.dart';
import 'package:mytradeasia/features/presentation/widgets/cart_button.dart';
import 'package:mytradeasia/features/presentation/widgets/product_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../config/routes/parameters.dart';
import '../../../../../../config/themes/theme.dart';
import '../../../../state_management/auth_bloc/auth_state.dart';
import '../../../../widgets/banner_top_products_widget.dart';

class TopProductsScreen extends StatefulWidget {
  const TopProductsScreen({super.key});

  @override
  State<TopProductsScreen> createState() => _TopProductsScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
const String nameProd = "Dipentene";
const String url = "https://chemtradea.chemtradeasia.com/";

class _TopProductsScreenState extends State<TopProductsScreen> {
  @override
  Widget build(BuildContext context) {
    var topProductBloc = BlocProvider.of<TopProductBloc>(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return topProductBloc.add(const GetTopProduct());
        },
        edgeOffset: size20px * 3.5,
        color: primaryColor1,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: size20px),
              child: Column(
                children: [
                  const SizedBox(height: size20px - 12.0),

                  // SearchBar
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
                      return SizedBox(
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
                                    hintText: nameProd,
                                    hintStyle: body1Regular,
                                    prefixIcon: Padding(
                                      padding:
                                          const EdgeInsets.all(size20px / 1.5),
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
                      );
                    },
                  ),

                  // banner top products
                  const BannerTopProducts(),

                  // main content
                  const AllTopProductsWidget(url: url),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AllTopProductsWidget extends StatelessWidget {
  const AllTopProductsWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return BlocBuilder<TopProductBloc, TopProductState>(
              builder: (context, state) {
                if (state is TopProductLoading) {
                  return Shimmer.fromColors(
                    baseColor: greyColor3,
                    highlightColor: greyColor,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.62),
                      itemCount: 4,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => const Card(),
                    ),
                  );
                } else if (state is TopProductDone) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.6),
                    itemCount: state.topProductData!.isNotEmpty ? 8 : 0,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          /* With go_router */
                          context.pushNamed("product", pathParameters: {
                            'url': state.topProductData![index].seoUrl!
                          });

                          String docsId = _auth.currentUser!.uid.toString();
                          Map<String, dynamic> data = {
                            "productName":
                                state.topProductData![index].productname,
                            "seo_url": state.topProductData![index].seoUrl,
                            "casNumber": state.topProductData![index].casNumber,
                            "hsCode": state.topProductData![index].hsCode,
                            "productImage":
                                state.topProductData![index].productimage
                          };

                          await FirebaseFirestore.instance
                              .collection('biodata')
                              .doc(docsId)
                              .update({
                            "recentlySeen": FieldValue.arrayUnion([data])
                          });
                        },
                        child: authState.role != "Sales"
                            ? ProductCard(
                                product: ProductEntity(
                                  productname:
                                      state.topProductData![index].productname!,
                                  productimage: state
                                      .topProductData![index].productimage!,
                                  hsCode: state.topProductData![index].hsCode!,
                                  casNumber:
                                      state.topProductData![index].casNumber!,
                                ),
                                onPressed: () {
                                  List<ProductToRfq> products = [];
                                  ProductToRfq product = ProductToRfq(
                                    productName: state
                                        .topProductData![index].productname!,
                                    productImage: state
                                        .topProductData![index].productimage!,
                                    hsCode:
                                        state.topProductData![index].hsCode!,
                                    casNumber:
                                        state.topProductData![index].casNumber!,
                                  );
                                  products.add(product);

                                  RequestQuotationParameter param =
                                      RequestQuotationParameter(
                                    products: products,
                                  );
                                  context.go("/home/request_quotation",
                                      extra: param);
                                },
                              )
                            : ProductCard(
                                product: ProductEntity(
                                  productname:
                                      state.topProductData![index].productname!,
                                  productimage: state
                                      .topProductData![index].productimage!,
                                  hsCode: state.topProductData![index].hsCode!,
                                  casNumber:
                                      state.topProductData![index].casNumber!,
                                ),
                                isNotRecentSeenCard: false,
                              ),
                      );
                    },
                  );
                } else {
                  return const Text("Error");
                }
              },
            );
          },
        ));
  }
}
