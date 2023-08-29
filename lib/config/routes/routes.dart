import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/view/auth/biodata/biodata_screen.dart';
import 'package:mytradeasia/view/auth/choose_role/role_user_screen.dart';
import 'package:mytradeasia/view/auth/login/forgot_password/forgot_password_screen.dart';
import 'package:mytradeasia/view/auth/login/forgot_password/reset_password_screen.dart';
import 'package:mytradeasia/view/auth/login/login_screen.dart';
import 'package:mytradeasia/view/auth/register/register_screen.dart';
import 'package:mytradeasia/view/menu/history/history_screen.dart';
import 'package:mytradeasia/view/menu/history/tracking_document/tracking_document_detail.dart';
import 'package:mytradeasia/view/menu/history/tracking_document/tracking_document_screen.dart';
import 'package:mytradeasia/view/menu/history/tracking_shipment/tracking_shipment_detail_screen.dart';
import 'package:mytradeasia/view/menu/history/tracking_shipment/tracking_shipment_screen.dart';
import 'package:mytradeasia/view/menu/home/all_products/industry/all_industry_screen.dart';
import 'package:mytradeasia/view/menu/home/all_products/products/all_products_screen.dart';
import 'package:mytradeasia/view/menu/home/all_products/products/products_detail_screen.dart';
import 'package:mytradeasia/view/menu/home/all_products/products/rfq_submitted_screen.dart';
import 'package:mytradeasia/view/menu/home/all_products/request_quotation_screen.dart';
import 'package:mytradeasia/view/menu/home/cart/cart_screen.dart';
import 'package:mytradeasia/view/menu/home/home_screen.dart';
import 'package:mytradeasia/view/menu/home/notification/notification_screen.dart';
import 'package:mytradeasia/view/menu/home/search/search_product_screen.dart';
import 'package:mytradeasia/view/menu/home/top_products/top_products_screen.dart';
import 'package:mytradeasia/view/menu/messages/messages_screen.dart';
import 'package:mytradeasia/view/menu/mytradeasia/mytradeasia_screen.dart';
import 'package:mytradeasia/view/menu/mytradeasia/submenu/quotations/my_quotations_screen.dart';
import 'package:mytradeasia/view/menu/mytradeasia/submenu/quotations/quotation_detail.dart';
import 'package:mytradeasia/view/menu/other/navigation_bar.dart';
import 'package:mytradeasia/view/menu/other/splash_page.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class Routes {
  GoRouter router =
      GoRouter(initialLocation: "/", debugLogDiagnostics: true, routes: [
    GoRoute(
        path: "/",
        builder: (context, state) => const SplashScreen(),
        redirect: (context, state) => '/'),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) =>
            NavigationBarWidget(
              child: child,
            ),
        routes: [
          GoRoute(
              path: "/home",
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const HomeScreen(), key: state.pageKey),
              routes: [
                GoRoute(
                    path: "notification",
                    builder: (context, state) => const NotificationScreen()),
                GoRoute(
                    path: "cart",
                    builder: (context, state) => const CartScreen(),
                    routes: [
                      GoRoute(
                          path: "quotations",
                          builder: (context, state) => const QuotationsScreen(),
                          routes: [
                            GoRoute(
                                path: "detail_quotation/:status/:issales",
                                name: 'detail_quotation',
                                builder: (context, state) =>
                                    QuotationDetailScreen(
                                      status: state.pathParameters['status']!,
                                      isSales: state.pathParameters[
                                                      'issales'] ==
                                                  "true" ||
                                              state.pathParameters['issales'] ==
                                                  "false"
                                          ? bool.parse(state.pathParameters[
                                              'issales']!) // a little bit hacky, need to find a better solution
                                          : false,
                                    ))
                          ])
                    ]),
                GoRoute(
                    path: "search",
                    builder: (context, state) => const SearchScreen()),
                GoRoute(
                    path: "request_quotation",
                    builder: (context, state) => const RequestQuotationScreen(),
                    routes: [
                      GoRoute(
                          path: 'submitted_rfq',
                          name: 'submitted_rfq',
                          builder: (context, state) =>
                              const SubmittedRFQScreen())
                    ]),
                GoRoute(
                    path: "tracking_document",
                    builder: (context, state) => const TrackingDocumentScreen(),
                    routes: [
                      GoRoute(
                          path: "detail",
                          name: "detail_tracking_document",
                          builder: (context, state) {
                            TrackingDocumentParameter param =
                                state.extra as TrackingDocumentParameter;
                            return TrackingDocumentDetail(
                                product: param.product,
                                indexProducts: param.indexProducts);
                          })
                    ]),
                GoRoute(
                    path: "tracking_shipment",
                    builder: (context, state) => const TrackingShipmentScreen(),
                    routes: [
                      GoRoute(
                          path: "detail",
                          name: "detail_tracking_shipment",
                          builder: (context, state) {
                            TrackingShipmentParameter param =
                                state.extra as TrackingShipmentParameter;
                            return TrackingShipmentDetailScreen(
                                product: param.product,
                                indexProducts: param.indexProducts);
                          })
                    ]),
                GoRoute(
                    path: "all_products",
                    builder: (context, state) => const AllProductsScreen(),
                    routes: [
                      GoRoute(
                          path: "product/:url",
                          name: 'product',
                          builder: (context, state) {
                            return ProductsDetailScreen(
                                urlProduct: state.pathParameters['url']!);
                          })
                    ]),
                GoRoute(
                    path: "top_products",
                    builder: (context, state) => const TopProductsScreen()),
                GoRoute(
                    path: "all_industry",
                    builder: (context, state) => const AllIndustryScreen()),
              ]),
          GoRoute(
              path: "/message",
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const MessageScreen(), key: state.pageKey)),
          GoRoute(
              path: "/history",
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const HistoryScreen(), key: state.pageKey)),
          GoRoute(
              path: "/mytradeasia",
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const MyTradeAsiaScreen(), key: state.pageKey))
        ]),
    GoRoute(
        path: "/auth",
        name: "choose_role",
        builder: (context, state) => const RoleUserScreen(),
        routes: [
          GoRoute(
              path: "login",
              builder: (context, state) => const LoginScreen(),
              routes: [
                GoRoute(
                    path: "forgot_password",
                    builder: (context, state) => const ForgotPasswordScreen()),
                // TODO : add email parameter (reset_password/:email) that will be passed to ResetPasswordScreen(email : state.pathParameters['email])
                GoRoute(
                    path: "reset_password",
                    builder: (context, state) => const ResetPasswordScreen())
              ]),
          GoRoute(
              path: "register",
              builder: (context, state) => const RegisterScreen(),
              routes: [
                GoRoute(
                    path: "biodata",
                    builder: (context, state) => const BiodataScreen())
              ]),
        ]),
  ]);
}
