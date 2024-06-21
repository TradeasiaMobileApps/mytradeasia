import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_account_model.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_to_rfq_entity.dart';
import 'package:mytradeasia/features/domain/usecases/sales_force_data_usecases/create_sales_force_account.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/add_recently_seen.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_data.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_snapshot.dart';
import 'package:mytradeasia/features/presentation/pages/menu/history/tracking_document/tracking_document_screen.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_event.dart';
import 'package:mytradeasia/features/presentation/state_management/home_bloc/home_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/home_bloc/home_event.dart';
import 'package:mytradeasia/features/presentation/state_management/home_bloc/home_state.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_login/salesforce_login_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_login/salesforce_login_event.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_login/salesforce_login_state.dart';
import 'package:mytradeasia/features/presentation/state_management/top_products_bloc/top_products_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/top_products_bloc/top_products_event.dart';
import 'package:mytradeasia/features/presentation/widgets/cart_button.dart';
import 'package:mytradeasia/features/presentation/widgets/product_card.dart';
import 'package:mytradeasia/helper/helper_functions.dart';
import 'package:mytradeasia/helper/injections_container.dart';
import 'package:mytradeasia/utils/sales_force_screen.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetUserSnapshot _getUserSnapshot = injections<GetUserSnapshot>();
  final AddRecentlySeen _addRecentlySeen = injections<AddRecentlySeen>();
  final GetUserData _geUserData = injections<GetUserData>();
  final CreateSalesForceAccount _createSalesForceAccount =
      injections<CreateSalesForceAccount>();

  // final GetRecentlySeen _getRecentlySeen = injections<GetRecentlySeen>();
  final String url = "https://chemtradea.chemtradeasia.com/";
  final bool showAll = false;
  int recentSeenLimit = 4;
  Map<String, dynamic> _data = {};

  // List _recentlySeen = [];

  @override
  void initState() {
    super.initState();
    createSFId();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeDataEvent());
      BlocProvider.of<TopProductBloc>(context).add(const GetTopProduct());

      BlocProvider.of<SalesforceLoginBloc>(context)
          .add(const LoginSalesforce());

      BlocProvider.of<CartBloc>(context).add(const GetCartItems());
    });
  }

  createSFId() async {
    _data = await _geUserData();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenSF = prefs.getString("tokenSF") ?? "";

    if (!await checkIdSFExists()) {
      _createSalesForceAccount.call(
          paramsOne: tokenSF,
          paramsTwo: SalesforceCreateAccountForm(
              name: "${_data['firstname']} ${_data['lastname']}",
              phone: _data['phone'] ?? "",
              role: _data['role'].toString().toLowerCase(),
              company: _data['companyName']));
    }
  }

  void increaseRecentSeenLimit(int num) {
    int divnum = num - recentSeenLimit;
    int dovnum = num % 4;

    if (recentSeenLimit % 4 == 0 && divnum > 4) {
      setState(() {
        recentSeenLimit = recentSeenLimit + 4;
      });
    } else {
      setState(() {
        recentSeenLimit = recentSeenLimit + dovnum;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: Center(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<TopProductBloc>().add(const GetTopProduct());
                context.read<HomeBloc>().add(const GetHomeDataEvent());
              },
              color: primaryColor1,
              child: SingleChildScrollView(
                child: StreamBuilder(
                    stream: _getUserSnapshot.call(),
                    builder: (context, AsyncSnapshot streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive(
                          backgroundColor: primaryColor1,
                        );
                      }

                      if (streamSnapshot.hasError) {
                        return const CircularProgressIndicator.adaptive(
                          backgroundColor: primaryColor1,
                        );
                      }

                      if (streamSnapshot.hasData) {
                        // var docsData =
                        //     streamSnapshot.data as Map<String, dynamic>;

                        return Column(
                          children: [
                            Column(
                              children: [
                                // Appbar
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: size20px * 9,
                                  decoration: const BoxDecoration(
                                    color: primaryColor1,
                                  ),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                          width: double.infinity,
                                          child: Image.asset(
                                              "assets/images/background.png",
                                              fit: BoxFit.cover)),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: size20px * 1.5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: size20px),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Welcome Back,",
                                                        style: text12.copyWith(
                                                            color: whiteColor)),
                                                    const SizedBox(
                                                        height: size20px / 5),
                                                    SizedBox(
                                                      height: 30,
                                                      width: size20px * 10,
                                                      child: Text(
                                                        "${streamSnapshot.data['firstName'] == "" ? "new" : streamSnapshot.data['firstName']} ${streamSnapshot.data['lastName'] == "" ? "user" : streamSnapshot.data['lastName']}",
                                                        style: text16.copyWith(
                                                            color: whiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 40.0,
                                                      width: 40.0,
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              secondaryColor1,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          /* With go_router */
                                                          context.go(
                                                              "/home/notification");
                                                        },
                                                        icon: Image.asset(
                                                            "assets/images/icon_notification.png",
                                                            width: 24,
                                                            height: 24),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        width: size20px / 2),
                                                    streamSnapshot.data[
                                                                    'role'] ==
                                                                "Agent" ||
                                                            streamSnapshot.data[
                                                                    'role'] ==
                                                                "Customer"
                                                        ? Container(
                                                            height: 40.0,
                                                            width: 40.0,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  secondaryColor1,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                            ),
                                                            child:
                                                                const CartButton(),
                                                          )
                                                        : Container()
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                              height: size20px / 1.5),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: size20px * 2.5,
                                              child: Form(
                                                child: TextFormField(
                                                  readOnly: true,
                                                  onTap: () =>
                                                      /* With go_router */
                                                      context
                                                          .go("/home/search"),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: greyColor3),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                            size20px / 2),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: greyColor3),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                            size20px / 2),
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor: whiteColor,
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 15.0),
                                                      child: Image.asset(
                                                        "assets/images/icon_search.png",
                                                        width: 24.0,
                                                        height: 24.0,
                                                      ),
                                                    ),
                                                    hintText:
                                                        "What do you want to search?",
                                                    hintStyle:
                                                        body1Regular.copyWith(
                                                            color: greyColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // End of AppBar

                                // Main Content
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: size20px,
                                      vertical: size20px - 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /* 4 Menu Section */
                                      streamSnapshot.data != null
                                          ? streamSnapshot.data['role'] ==
                                                  "Sales"
                                              ? BlocBuilder<SalesforceLoginBloc,
                                                      SalesforceLoginState>(
                                                  builder: (context, state) {
                                                  if (state
                                                      is SalesforceLoginLoading) {
                                                    return Shimmer.fromColors(
                                                      baseColor: greyColor,
                                                      highlightColor:
                                                          greyColor4,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 5,
                                                                child:
                                                                    Container(
                                                                  height: 60,
                                                                  width: 160,
                                                                  decoration: const BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              10)),
                                                                      color:
                                                                          whiteColor),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 15.0),
                                                              Expanded(
                                                                flex: 5,
                                                                child:
                                                                    Container(
                                                                  height: 60,
                                                                  width: 160,
                                                                  decoration: const BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              10)),
                                                                      color:
                                                                          whiteColor),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                top: size20px *
                                                                    0.75,
                                                                bottom:
                                                                    size20px),
                                                            child: Row(
                                                              children: [
                                                                // ALL PRODUCTS
                                                                Expanded(
                                                                  flex: 5,
                                                                  child:
                                                                      Container(
                                                                    height: 60,
                                                                    width: 160,
                                                                    decoration: const BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                10)),
                                                                        color:
                                                                            whiteColor),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }

                                                  if (state
                                                      is SalesforceLoginDone) {
                                                    return MenuGridWidgetSales(
                                                      accessToken: state
                                                          .loginEntity!
                                                          .accessToken!,
                                                    );
                                                  }

                                                  return Container();
                                                })
                                              : const MenuGridWidget()
                                          : Container(),
                                      /* End 4 Menu Section */

                                      /* Top Product Section */
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Our Top Products",
                                              style: text18),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: secondaryColor5,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size20px * 5),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                var topProductBloc =
                                                    BlocProvider.of<
                                                            TopProductBloc>(
                                                        context);

                                                topProductBloc
                                                    .add(const GetTopProduct());

                                                /* With go_router */
                                                context
                                                    .go("/home/top_products");
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            size20px / 2,
                                                        vertical: size20px / 5),
                                                child: Text(
                                                  "See More",
                                                  style: text12.copyWith(
                                                      color: secondaryColor1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: size20px / 2,
                                            top: size20px),
                                        child: BlocBuilder<HomeBloc, HomeState>(
                                            builder: (context, state) {
                                          if (state is HomeLoading) {
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
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    const Card(),
                                              ),
                                            );
                                          } else if (state is HomeDone) {
                                            // for (var i = 0;
                                            //     i <
                                            //         state.homeData!.byIndustry!
                                            //             .detailIndustry!.length;
                                            //     i++) {
                                            //   if (i == 7) {
                                            //     print("all industry");
                                            //   } else {
                                            //     print(state
                                            //         .homeData!
                                            //         .byIndustry!
                                            //         .detailIndustry![i]
                                            //         .industryName);
                                            //   }
                                            // }

                                            return GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 15,
                                                      mainAxisSpacing: 15,
                                                      childAspectRatio: 0.6),
                                              itemCount: state.homeData!
                                                      .topProduct!.isNotEmpty
                                                  ? 4
                                                  : 0,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    context.pushNamed("product",
                                                        pathParameters: {
                                                          'productId': state
                                                              .homeData!
                                                              .topProduct![
                                                                  index]
                                                              .productId!
                                                              .toString()
                                                        });

                                                    Map<String, dynamic> data =
                                                        {
                                                      "productId": state
                                                          .homeData!
                                                          .topProduct![index]
                                                          .productId,
                                                      "productName": state
                                                          .homeData!
                                                          .topProduct![index]
                                                          .productname,
                                                      "casNumber": state
                                                          .homeData!
                                                          .topProduct![index]
                                                          .casNumber,
                                                      "hsCode": state
                                                          .homeData!
                                                          .topProduct![index]
                                                          .hsCode,
                                                      "productImage": state
                                                          .homeData!
                                                          .topProduct![index]
                                                          .productimage
                                                    };

                                                    await _addRecentlySeen(
                                                        param: data);
                                                  },
                                                  //product cards

                                                  child: streamSnapshot
                                                              .data['role'] !=
                                                          "Sales"
                                                      ? ProductCard(
                                                          product:
                                                              ProductEntity(
                                                            productId: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .productId,
                                                            productname: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .productname,
                                                            productimage: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .productimage!,
                                                            hsCode: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .hsCode!,
                                                            casNumber: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .casNumber!,
                                                          ),
                                                          onPressed: () {
                                                            List<ProductToRfq>
                                                                products = [];
                                                            ProductToRfq
                                                                product =
                                                                ProductToRfq(
                                                              productId: state
                                                                  .homeData!
                                                                  .topProduct![
                                                                      index]
                                                                  .productId!,
                                                              productName: state
                                                                  .homeData!
                                                                  .topProduct![
                                                                      index]
                                                                  .productname!,
                                                              productImage: state
                                                                  .homeData!
                                                                  .topProduct![
                                                                      index]
                                                                  .productimage!,
                                                              hsCode: state
                                                                  .homeData!
                                                                  .topProduct![
                                                                      index]
                                                                  .hsCode!,
                                                              casNumber: state
                                                                  .homeData!
                                                                  .topProduct![
                                                                      index]
                                                                  .casNumber!,
                                                            );
                                                            products
                                                                .add(product);

                                                            RequestQuotationParameter
                                                                param =
                                                                RequestQuotationParameter(
                                                              products:
                                                                  products,
                                                            );
                                                            context.go(
                                                                "/home/request_quotation",
                                                                extra: param);
                                                          })
                                                      : ProductCard(
                                                          product:
                                                              ProductEntity(
                                                            productId: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .productId,
                                                            productname: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .productname,
                                                            productimage: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .productimage!,
                                                            hsCode: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .hsCode!,
                                                            casNumber: state
                                                                .homeData!
                                                                .topProduct![
                                                                    index]
                                                                .casNumber!,
                                                          ),
                                                          isNotRecentSeenCard:
                                                              false,
                                                        ),
                                                );
                                              },
                                            );
                                          } else {
                                            return Center(
                                              child: Text(
                                                "Error",
                                                style: heading1.copyWith(
                                                    color: redColor1),
                                              ),
                                            );
                                          }
                                        }),
                                      ),
                                      /* End Top Product Section */

                                      /* Industry Section */
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size20px),
                                          child:
                                              Text("Industry", style: text18)),
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                                    .size
                                                    .height <
                                                600
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.24,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: BlocBuilder<HomeBloc, HomeState>(
                                          builder: (context, state) {
                                            if (state is HomeLoading) {
                                              return const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              );
                                            } else if (state is HomeDone) {
                                              return GridView(
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                clipBehavior: Clip.none,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                        crossAxisSpacing: 5,
                                                        mainAxisSpacing: 5,
                                                        childAspectRatio: 0.9),
                                                children: [
                                                  for (var i = 0;
                                                      i <
                                                          state
                                                              .homeData!
                                                              .byIndustry!
                                                              .detailIndustry!
                                                              .length;
                                                      i++)
                                                    i == 7
                                                        ? TopIndustryWidget(
                                                            icon:
                                                                "assets/images/icon_all_industry.png",
                                                            onPressed: () {
                                                              context.go(
                                                                  "/home/all_industry");
                                                            },
                                                            topIndustryName:
                                                                "All Industries")
                                                        : TopIndustryWidget(
                                                            icon: state
                                                                .homeData!
                                                                .byIndustry!
                                                                .detailIndustry![
                                                                    i]
                                                                .industryImage!,
                                                            onPressed: () {
                                                              ProductsIndustryParameter
                                                                  param =
                                                                  ProductsIndustryParameter(
                                                                      index: i,
                                                                      industryName: state
                                                                          .homeData!
                                                                          .byIndustry!
                                                                          .detailIndustry![
                                                                              i]
                                                                          .industryName!);

                                                              context.push(
                                                                  "/home/all_industry/products_industry",
                                                                  extra: param);
                                                            },
                                                            topIndustryName: state
                                                                .homeData!
                                                                .byIndustry!
                                                                .detailIndustry![
                                                                    i]
                                                                .industryName!)
                                                ],
                                              );
                                            } else {
                                              return Center(
                                                child: Text(
                                                  "Error",
                                                  style: heading1.copyWith(
                                                      color: redColor1),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      /* End Industry Section */

                                      /* Last seen Section */
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text("Last Seen Products",
                                            style: text18),
                                      ),
                                      BlocBuilder<HomeBloc, HomeState>(
                                        builder: (context, state) {
                                          if (state is HomeLoading) {
                                            return const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive());
                                          } else if (state
                                                      .homeData!.recentlySeen ==
                                                  null ||
                                              state.homeData!.recentlySeen!
                                                  .isEmpty) {
                                            return const Center(
                                                child:
                                                    Text("Tidak ada product"));
                                          } else {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: size20px),
                                                  child: GridView.builder(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            crossAxisSpacing:
                                                                15,
                                                            mainAxisSpacing: 15,
                                                            childAspectRatio:
                                                                0.7),
                                                    itemCount: state
                                                                .homeData!
                                                                .recentlySeen!
                                                                .length <
                                                            4
                                                        ? state
                                                            .homeData!
                                                            .recentlySeen!
                                                            .length
                                                        : recentSeenLimit,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ProductCard(
                                                        product: ProductEntity(
                                                          productname: state
                                                              .homeData!
                                                              .recentlySeen![
                                                                  index]
                                                              .productname,
                                                          productimage: state
                                                              .homeData!
                                                              .recentlySeen![
                                                                  index]
                                                              .productimage,
                                                          casNumber: state
                                                              .homeData!
                                                              .recentlySeen![
                                                                  index]
                                                              .casNumber,
                                                          hsCode: state
                                                              .homeData!
                                                              .recentlySeen![
                                                                  index]
                                                              .hsCode,
                                                        ),
                                                        isNotRecentSeenCard:
                                                            false,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                /* Button See More */
                                                state.homeData!.recentlySeen!
                                                                .length >
                                                            4 &&
                                                        recentSeenLimit <
                                                            state
                                                                .homeData!
                                                                .recentlySeen!
                                                                .length
                                                    ? Center(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                secondaryColor5,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        size20px *
                                                                            5),
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              increaseRecentSeenLimit(
                                                                  state
                                                                      .homeData!
                                                                      .recentlySeen!
                                                                      .length);
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      size20px /
                                                                          2,
                                                                  vertical:
                                                                      size20px /
                                                                          5),
                                                              child: Text(
                                                                "Load More",
                                                                style: text12
                                                                    .copyWith(
                                                                        color:
                                                                            secondaryColor1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                /* End Button See More */
                                              ],
                                            );
                                          }
                                          /* End Lastseen Section */
                                        },
                                      )
                                    ],
                                  ),
                                )
                                // End of Main Content
                              ],
                            ),
                          ],
                        );
                      }
                      return Container();
                    }),
              ),
            ),
          ),
        ));
  }
}

class TopIndustryWidget extends StatelessWidget {
  const TopIndustryWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.topIndustryName,
  });

  final String icon;
  final String topIndustryName;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              ),
              topIndustryName == "All Industries"
                  ? Image.asset(
                      icon,
                      color: primaryColor1,
                      width: size24px,
                      height: size24px,
                    )
                  : Image.network(
                      icon,
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
              topIndustryName,
              style: text10,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class MenuGridWidget extends StatelessWidget {
  const MenuGridWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // RFQ & Tracking Doc menu baris 1
        Row(
          children: [
            // RFQ
            Expanded(
              flex: 5,
              child: InkWell(
                onTap: () {
                  /* With go_router */
                  RequestQuotationParameter param = RequestQuotationParameter(
                    products: [],
                  );
                  context.go("/home/request_quotation", extra: param);
                },
                child: Container(
                  height: 60,
                  width: 160,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [rfqMuda, rfqTua]),
                  ),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 12.0, bottom: 12.0),
                      child: Text("Request for \nQuotation",
                          style: text12.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w600)),
                    ),
                    Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Image.asset(
                          "assets/images/icon_target.png",
                          color: whiteColor,
                          width: size20px * 3,
                        )),
                  ]),
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            // TRACKINGDOC
            Expanded(
              flex: 5,
              child: InkWell(
                onTap: () {
                  /* With go_router */
                  context.push("/history/tracking_document");
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return const TrackingDocumentScreen();
                  //   },
                  // ));
                },
                child: Container(
                  height: 60,
                  width: 160,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [trackingDocMuda, trackingDocTua]),
                  ),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 12.0, bottom: 12.0),
                      child: Text("Tracking \nDocument",
                          style: text12.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w600)),
                    ),
                    Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Image.asset(
                          "assets/images/icon_docs.png",
                          color: whiteColor,
                          width: size20px * 3,
                        )),
                  ]),
                ),
              ),
            )
          ],
        ),
        // Tracking Ship & All Products menu baris 1
        Padding(
          padding:
              const EdgeInsets.only(top: size20px * 0.75, bottom: size20px),
          child: Row(
            children: [
              // TRACKINGSHIP
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () {
                    /* With go_router */
                    context.push("/history/tracking_shipment");

                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return const TrackingShipmentScreen();
                    //   },
                    // ));
                  },
                  child: Container(
                    height: 60,
                    width: 160,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [trackingShipMuda, trackingShipTua]),
                    ),
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 12.0, bottom: 12.0),
                        child: Text("Tracking \nShipment",
                            style: text12.copyWith(
                                color: whiteColor,
                                fontWeight: FontWeight.w600)),
                      ),
                      Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Image.asset(
                            "assets/images/icon_boat.png",
                            color: whiteColor,
                            width: size20px * 3,
                          )),
                    ]),
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              // ALL PRODUCTS
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () {
                    context.go("/home/all_products");
                  },
                  child: Container(
                    height: 60,
                    width: 160,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [allProductsMuda, allProductsTua]),
                    ),
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 12.0, bottom: 12.0),
                        child: Text("All \nProducts",
                            style: text12.copyWith(
                                color: whiteColor,
                                fontWeight: FontWeight.w600)),
                      ),
                      Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Image.asset(
                            "assets/images/icon_box.png",
                            color: whiteColor,
                            width: size20px * 3,
                          )),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class MenuGridWidgetSales extends StatelessWidget {
  const MenuGridWidgetSales({Key? key, required this.accessToken})
      : super(key: key);

  final String accessToken;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Tracking Doc menu baris 1
        Row(
          children: [
            // TRACKINGSHIP
            Expanded(
              flex: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      // return const TrackingShipmentScreen();
                      // return const ShipGoScreen();
                      return SalesForceLoginScreen(
                        token: accessToken,
                      );
                    },
                  ));

                  // log(accessTokenData);
                },
                child: Container(
                  height: 60,
                  width: 160,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [trackingShipMuda, trackingShipTua]),
                  ),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 12.0, bottom: 12.0),
                      child: Text("Tracking \nShipment",
                          style: text12.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w600)),
                    ),
                    Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Image.asset(
                          "assets/images/icon_boat.png",
                          color: whiteColor,
                          width: size20px * 3,
                        )),
                  ]),
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            // TRACKINGDOC
            Expanded(
              flex: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const TrackingDocumentScreen();
                    },
                  ));
                },
                child: Container(
                  height: 60,
                  width: 160,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [trackingDocMuda, trackingDocTua]),
                  ),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 12.0, bottom: 12.0),
                      child: Text("Tracking \nDocument",
                          style: text12.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w600)),
                    ),
                    Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Image.asset(
                          "assets/images/icon_docs.png",
                          color: whiteColor,
                          width: size20px * 3,
                        )),
                  ]),
                ),
              ),
            )
          ],
        ),
        // Tracking Ship & All Products menu baris 2
        Padding(
          padding:
              const EdgeInsets.only(top: size20px * 0.75, bottom: size20px),
          child: Row(
            children: [
              // ALL PRODUCTS
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () {
                    context.go("/home/all_products");
                  },
                  child: Container(
                    height: 60,
                    width: 160,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [allProductsMuda, allProductsTua]),
                    ),
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 12.0, bottom: 12.0),
                        child: Text("All \nProducts",
                            style: text12.copyWith(
                                color: whiteColor,
                                fontWeight: FontWeight.w600)),
                      ),
                      Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Image.asset(
                            "assets/images/icon_box.png",
                            color: whiteColor,
                            width: size20px * 3,
                          )),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
