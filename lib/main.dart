import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytradeasia/firebase_options.dart';
import 'package:mytradeasia/modelview/provider/db_manager.dart';
import 'package:mytradeasia/modelview/provider/list_product_provider.dart';
import 'package:mytradeasia/view/auth/register_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
          create: (context) => DbManager(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListProductProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MyTradeasia',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Poppins",
        ),
        home: const RegisterScreen(),
      ),
    );
  }
}
