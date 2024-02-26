import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/data/model/cart_models/cart_models.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic parseDoubleToIntegerIfNecessary(double input) {
  String inputString = input.toString();

  // Check if the input string ends with ".0"
  if (inputString.endsWith('.0')) {
    return int.parse(inputString.split('.').first);
  } else {
    return input;
  }
}

CartModel castProductEntityToCartModel(
    {required ProductEntity product,
    required double quantity,
    required String unit}) {
  return CartModel(
      productName: product.productname,
      productImage: product.productimage,
      hsCode: product.hsCode,
      casNumber: product.casNumber,
      seoUrl: product.seoUrl,
      quantity: quantity,
      unit: unit);
}

LatLng listDoubleToLatLng(List<double> list) {
  return LatLng(list.first, list.last);
}

List<LatLng> toListLatLng(List<List<double>> list) {
  List<LatLng> newList = [];
  for (var element in list) {
    newList.add(LatLng(element.first, element.last));
  }
  return newList;
}

Future<bool> canCallApi() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int lastCall = prefs.getInt('lastApiCall') ?? 0;
  int now = DateTime.now().millisecondsSinceEpoch;
  int oneDay = 24 * 60 * 60 * 1000; // Milliseconds in a day

  if (now - lastCall >= oneDay) {
    prefs.setInt('lastApiCall', now); // Update the last call time
    return true; // More than a day has passed since the last call
  }
  return false; // Less than a day has passed since the last call
}

Future<bool> checkIfUserExists(String userId) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference biodata = _firestore.collection('biodata');
  final DocumentSnapshot documentSnapshot = await biodata.doc(userId).get();

  return documentSnapshot.exists;
}

Future<String> getSalesforceId() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final Map<String, dynamic> firestoreData = await FirebaseFirestore.instance
      .collection('biodata')
      .doc(_auth.currentUser?.uid.toString())
      .get()
      .then((DocumentSnapshot doc) {
    return doc.data() as Map<String, dynamic>;
  });
  return firestoreData['idSF'];
}

Future<bool> checkIdSFExists() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('biodata')
      .doc(_auth.currentUser?.uid.toString())
      .get();

  if (doc.exists && doc.data() != null) {
    final Map<String, dynamic> firestoreData =
        doc.data() as Map<String, dynamic>;
    return firestoreData.containsKey('idSF') && firestoreData['idSF'] != null;
  } else {
    return false;
  }
}

Future<bool> isSSOAuth() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> userSignInMethods =
      await _auth.fetchSignInMethodsForEmail(_auth.currentUser!.email!);
  log("Sign In Method : ${userSignInMethods.toString()}");
  if (userSignInMethods.isEmpty) {
    // Using the Custom Linkedin SSO
    return true;
  }
  log("isSSO : ${userSignInMethods.first != "password"}");
  return userSignInMethods.first != "password";
}

void showGoogleSSOSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1, milliseconds: 500),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    backgroundColor: Colors.blue,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.network(
              "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-1024.png",
              width: 30,
              height: 30),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "Signed in with Google",
          style: body1Regular.copyWith(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    ),
  ));
}

void showLinkedinSSOSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1, milliseconds: 500),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    backgroundColor: Colors.blue,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.network(
              "https://cdn1.iconfinder.com/data/icons/logotypes/32/circle-linkedin-1024.png",
              width: 30,
              height: 30),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "Signed in with Linkedin",
          style: body1Regular.copyWith(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    ),
  ));
}
