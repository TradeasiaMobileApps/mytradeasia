import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mytradeasia/config/routes/routes.dart';
import 'package:mytradeasia/features/data/data_sources/remote/detail_product_service.dart';
import 'package:mytradeasia/firebase_options.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/all_industry_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/auth_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/detail_product_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/dhl_shipment_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/faq_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/list_product_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/loading_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/obsecure_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/sales_force_data_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/sales_force_detail_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/sales_force_login_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/search_product_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/see_more_provider.dart';
import 'package:mytradeasia/features/presentation/state_management/provider/top_products_provider.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ListProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoadingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ObscureTextProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllIndustryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FaqProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DetailProductProvider(service: DetailProductService()),
        ),
        ChangeNotifierProvider(
          create: (context) => SeeMoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DhlShipmentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SalesforceLoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SalesforceDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SalesforceDetailProvider(),
        ),
      ],
      child: StreamProvider<InternetConnectionStatus>(
        initialData: InternetConnectionStatus.connected,
        create: ((context) => InternetConnectionChecker().onStatusChange),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'MyTradeasia',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: whiteColor),
            primaryColor: whiteColor,
            bottomNavigationBarTheme:
                const BottomNavigationBarThemeData(backgroundColor: whiteColor),
            scaffoldBackgroundColor: whiteColor,
            fontFamily: "Poppins",
          ),
          routerConfig: Routes().router,
          // home: const SplashScreen(),
        ),
      ),
    );
  }
}
