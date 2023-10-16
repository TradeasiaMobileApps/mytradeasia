import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytradeasia/features/data/model/searates_model/searates_bl_model.dart';
import 'package:mytradeasia/features/data/model/searates_model/searates_route_model.dart';
import 'package:mytradeasia/features/domain/entities/searates_entities/searates_bl_entity.dart';

class SearatesService {
  final dio = Dio();
  final String apiKey = "7CX5-1IW6-E2DL-3S8V-KNOF";

  Future<Response<SearatesRouteModel>> getRoute(
      {required String number,
      required String type,
      required String sealine}) async {
    String apiKey = "7CX5-1IW6-E2DL-3S8V-KNOF"; // Your API key
    String number = "COAU7885072330";
    String sealine = "COSU";

    String apiUrl = "https://tracking.searates.com/route";
    final response = await dio.get(
      apiUrl,
      queryParameters: {
        'number': number,
        'type': 'BL',
        'sealine': sealine,
        'api_key': apiKey,
      },
    );

    log("ROUTE DATA : ${response.data}");
    final data = response.data;
    return Response<SearatesRouteModel>(
        requestOptions: response.requestOptions,
        statusCode: response.statusCode,
        statusMessage: response.data['status'],
        data: SearatesRouteModel.fromJson(data));
  }

  Future<Response<SearatesBLModel>> trackByBL(String number) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    String userId = _auth.currentUser!.uid.toString();
    CollectionReference searates =
        FirebaseFirestore.instance.collection('searates');
    DocumentSnapshot docSnapshot = await searates.doc(userId).get();

    int now = DateTime.now().millisecondsSinceEpoch;

    if (docSnapshot.exists) {
      Map<String, dynamic> userData =
          docSnapshot.data() as Map<String, dynamic>;
      int lastCall =
          DateTime.parse(userData['lastApiCall']).millisecondsSinceEpoch;
      int twelveHours = 12 * 60 * 60 * 1000;

      if (now - lastCall >= twelveHours) {
        final response = await dio.get(
            "https://tracking.searates.com/reference?number=$number&api_key=$apiKey");
        await searates.doc(userId).update({
          'lastApiCall': DateTime.now().toString(),
          'data': response.data,
        });

        return Response<SearatesBLModel>(
            requestOptions: response.requestOptions,
            statusCode: response.statusCode,
            statusMessage: response.data['status'],
            data: SearatesBLModel.fromJson(response.data));
      } else {
        Map<String, dynamic> data = userData['data'];
        return Response<SearatesBLModel>(
            requestOptions: RequestOptions(),
            statusCode: 200,
            statusMessage: "success",
            data: SearatesBLModel.fromJson(data));
      }
    } else {
      final response = await dio.get(
          "https://tracking.searates.com/reference?number=$number&api_key=$apiKey");
      await searates.doc(userId).set({
        'lastApiCall': DateTime.now().toString(),
        'data': response.data,
      });
      return Response<SearatesBLModel>(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: "success",
          data: SearatesBLModel.fromJson(response.data));
    }
  }
}
