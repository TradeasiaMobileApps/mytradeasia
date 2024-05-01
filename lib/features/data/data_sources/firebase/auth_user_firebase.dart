import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:mytradeasia/features/data/model/all_product_models/all_product_model.dart';
import 'package:mytradeasia/features/data/model/user_credential_models/user_credential_model.dart';
import 'package:mytradeasia/features/data/model/user_models/user_model.dart';
import 'package:mytradeasia/features/data/model/user_sales_models/sales_login_response_model.dart';
import 'package:mytradeasia/helper/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/notification_service.dart';

class AuthUserFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  NotificationService notificationServices = NotificationService();

  late PhoneAuthCredential phoneAuthCredential;
  var verificationId = '';
  final dio = Dio();

  Future<String> postRegisterUser(UserModel userData) async {
    final dateTime = DateTime.now();

    String status = "error";

    try {
      notificationServices.requestNotificationPermission();
      String? deviceToken = await notificationServices.getDeviceToken();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? role = prefs.getString("role")?.toLowerCase();


      if (Platform.isAndroid) {
        final headers = {
          "datetime": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          "role": role,
          "device_type": "android",
        };

        final response = await dio.post("https://www.tradeasia.co/api/signup",
            data: {
              "first_name": userData.firstName,
              "last_name": userData.lastName,
              "company_name": userData.companyName,
              "country": userData.country,
              "dialing_code": userData.countryCode,
              "mobile_number": userData.phone,
              "email": userData.email,
              "password": userData.password,
              "timezone": dateTime.timeZoneName,
              "device_token": deviceToken,
              "login_type": "by_form",
              "comet_chat_user_id":
                  "${userData.firstName ?? "user"}_${dateTime.millisecondsSinceEpoch}"
                      .toLowerCase()
            },
            options: Options(headers: headers));

        log("SIGNUP RESPONSE DATA : ${{
          "first_name": userData.firstName,
          "last_name": userData.lastName,
          "company_name": userData.companyName,
          "country": userData.country,
          "dialing_code": getIntegerFromDialingCode(userData.countryCode!),
          "mobile_number": userData.phone,
          "email": userData.email,
          "password": userData.password,
          "timezone": dateTime.timeZoneName,
          "device_token": deviceToken,
          "login_type": "by_form",
          "comet_chat_user_id":
              "${userData.firstName ?? "user"}_${dateTime.millisecondsSinceEpoch}"
        }}");


        if (response.data['status']) {
          status = 'success';
        }

        // return response.statusCode.toString();
      } else {
        final headers = {
          "datetime": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          "role": role,
          "device_type": "ios",
        };

        final response = await dio.post("https://www.tradeasia.co/api/signup",
            data: {
              "first_name": userData.firstName,
              "last_name": userData.lastName,
              "company_name": userData.companyName,
              "country": userData.country,
              "dialing_code": getIntegerFromDialingCode(userData.countryCode!),
              "mobile_number": userData.phone,
              "email": userData.email,
              "password": userData.password,
              "timezone": dateTime.timeZoneName,
              "device_token": deviceToken,
              "login_type": "by_form",
              "comet_chat_user_id":
                  "${userData.firstName ?? "user"}_${dateTime.millisecondsSinceEpoch}"
                      .toLowerCase()
            },
            options: Options(headers: headers));

        if (response.data['status']) {
          status = 'success';
        }
      }
    } on DioException catch (e) {
      status = e.response!.statusCode.toString();
    }

    if (status != "success") {
      return status;
    } else {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: userData.email!, password: userData.password!);

        //TODO:Uncomment this when used

        // FirebaseAuth.instance.currentUser!
        //     .linkWithCredential(phoneAuthCredential);

        String docsId = FirebaseAuth.instance.currentUser!.uid.toString();
        Map<String, dynamic> data = userData.toMap();
        data["uid"] = docsId;
        _firestore.collection('biodata').doc(docsId).set(data);
        return 'success';
      } on FirebaseAuthException catch (e) {
        return e.code;
      }
    }
  }

  Future<String> ssoRegisterUser(UserModel userData) async {
    try {
      String docsId = FirebaseAuth.instance.currentUser!.uid.toString();
      Map<String, dynamic> data = userData.toMap();
      data["uid"] = docsId;
      FirebaseFirestore.instance.collection('biodata').doc(docsId).set(data);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", FirebaseAuth.instance.currentUser!.email!);
      await prefs.setString("userId", FirebaseAuth.instance.currentUser!.uid);
      await prefs.setBool("isLoggedIn", true);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  String getCurrentUId() => _auth.currentUser!.uid;

  Future<dynamic> postLoginUser(Map<String, String> auth) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? role = prefs.getString("role")?.toLowerCase();

      notificationServices.requestNotificationPermission();
      notificationServices.getDeviceToken().then((value) async {
        if (Platform.isAndroid) {
          final headers = {
            "datetime":
                DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
            "role": role,
            "device_type": "android",
          };

          final response = await dio.post("https://www.tradeasia.co/api/signin",
              data: {
                "email": auth["email"],
                "password": auth["password"],
                "device_token": value
              },
              options: Options(headers: headers));

          if (response.statusCode != 200) {
            return {
              'code': response.statusCode,
              'message': response.statusMessage
            };
          }
        } else {
          final headers = {
            "datetime":
                DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
            "role": role,
            "device_type": "ios",
          };

          final response = await dio.post("https://www.tradeasia.co/api/signin",
              data: {
                "email": auth["email"],
                "password": auth["password"],
                "device_token": value
              },
              options: Options(headers: headers));

          log("LOGIN RESPONSE : ${response.data}");


          if (response.statusCode != 200) {
            return {
              'code': response.statusCode,
              'message': response.statusMessage
            };
          }
        }
      });
    } on DioException catch (e) {
      return {'code': e.response?.statusCode, 'message': e.message};
    }

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

        UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
            email: auth["email"]!, password: auth["password"]!);

        await prefs.setString("email", auth["email"]!);
        await prefs.setBool("isLoggedIn", true);

        return UserCredentialModel.fromUserCredential(_userCredential);



    } on FirebaseAuthException catch (e) {
      return {'code': e.code, 'message': e.message};
    }
  }

  Future<SalesLoginResponse> postLoginSales(Map<String, String> auth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final headers = {
        "datetime":
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
        "role": "sales_associate",
        "device_type": auth['device_type'],
      };

      final response = await dio.post("https://www.tradeasia.co/api/signin",
          data: {
            "email": auth["email"],
            "password": auth["password"],
            "device_token": auth['device_token']
          },
          options: Options(headers: headers));


      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: auth["email"]!, password: auth["password"]!);

      print("FB CRED : $_userCredential");

      await prefs.setString("email", auth["email"]!);
      await prefs.setBool("isLoggedIn", true);

      return SalesLoginResponse.fromJson(response.data);
    } on DioException catch(e) {
      return SalesLoginResponse(status: false,message: e.message);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        await _auth.createUserWithEmailAndPassword(
            email: auth["email"]!, password: auth["password"]!);

        String docsId = FirebaseAuth.instance.currentUser!.uid.toString();

        UserModel userData = UserModel(email: auth['email'],password: auth['password'],role: 'Sales',companyName: "",country: "",countryCode: "",firstName: 'Sales',lastName: "",phone: "",profilePicUrl: "");
        Map<String, dynamic> data = userData.toMap();
        data["uid"] = docsId;
        _firestore.collection('biodata').doc(docsId).set(data);

        UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
            email: auth["email"]!, password: auth["password"]!);


        await prefs.setString("email", auth["email"]!);
        await prefs.setBool("isLoggedIn", true);
        return SalesLoginResponse(status: false,message: "Sales account created! Please login again");
      } else {
        return SalesLoginResponse(status: false,message: e.message);
      }
    }

  }


  Future<dynamic> googleAuth() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", userCredential.user!.email!);
      await prefs.setBool("isLoggedIn", true);
      return UserCredentialModel.fromUserCredential(userCredential);
    } on FirebaseAuthException catch (e) {
      return {'code': e.code, 'message': e.message};
    }
  }

  Future<dynamic> linkedinAuth() async {
    const url = 'https://linkedin-firebase-auth-integrator.vercel.app/token';

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      "accessToken": "AQvez430u... (your entire token)",
      "uid": "nYUzD08Ra"
    };

    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
      } else {
        return {'code': response.statusCode, 'message': 'error'};
      }
    } on FirebaseAuthException catch (e) {
      return {'code': e.code, 'message': e.message};
    }
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    print("uploadImage");
    Reference ref = _firebaseStorage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> updateProfile(Map<String, dynamic> data) async {
    print("updateProfile");
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('biodata').doc(data["uid"]);
    String imageUrl = "";
    if (data["image"] != null) {
      imageUrl = await uploadImageToStorage(data["uid"], data["image"]);
    }

    return docRef.get().then((docSnapshot) async {
      var response = "network-error";
      if (docSnapshot.exists) {
        response = await docRef.update({
          'firstName': data["firstName"],
          'lastName': data["lastName"],
          'phone': data["phone"],
          'companyName': data["companyName"],
          'profilePicUrl': imageUrl,
        }).then((_) {
          return "success";
        }).catchError((e) {
          return "error";
        });
      } else {
        response = await docRef.set(data).then((_) {
          return "success";
        }).catchError((e) {
          return "error";
        });
      }
      return response;
    });
  }

  Future<void> postLogoutUser() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }

  Stream<Map<String, dynamic>> getUserSnapshot(String uid) {
    final userSnapshot = _firestore.collection('biodata').doc(uid).get();

    return userSnapshot.asStream().map((event) {
      return UserModel.fromSnapshot(event).toMap();
    });
  }

  Future<UserCredentialModel> getUserCredentials() async {
    final userCredential = FirebaseAuth.instance.currentUser!;

    return UserCredentialModel.fromUser(userCredential);
  }

  Future<Map<String, dynamic>> getUserData() async {
    return await _firestore
        .collection('biodata')
        .doc(getCurrentUId())
        .get()
        .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
  }

  void addRecentlySeen(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('biodata')
        .doc(getCurrentUId())
        .update({
      "recentlySeen": FieldValue.arrayUnion([data])
    });
  }

  Future<List<AllProductModel>> getRecentlySeen() async {
    final Map<String, dynamic> firestoreData = await FirebaseFirestore.instance
        .collection('biodata')
        .doc(getCurrentUId())
        .get()
        .then((DocumentSnapshot doc) {
      return doc.data() as Map<String, dynamic>;
    });

    List recentlySeenData = [];
    if (firestoreData['recentlySeen'] != null) {
      recentlySeenData = firestoreData['recentlySeen'];
    }

    return recentlySeenData.map((e) {
      return AllProductModel.fromFirebase(e);
    }).toList();
  }

  void deleteRecentlySeen() async {
    // String docsId = _auth.currentUser!.uid.toString();
    await FirebaseFirestore.instance
        .collection('biodata')
        .doc(getCurrentUId())
        .update({"recentlySeen": FieldValue.delete()});
  }

  void sendResetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  void confirmPasswordReset(String code, String newPassword) async {
    await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
  }

  Future<String> phoneAuthentication(String phoneNo) async {
    try {
      Completer<String> completer = Completer();
      // var res = "";
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          phoneAuthCredential = credential;
          // await _auth.signInWithCredential(credential);
          completer.complete("verification-complete");
          print("test1");
        },
        verificationFailed: (e) {
          print("test2");
          if (e.code == "invalid-phone-number") {
            // res = "invalid-phone-number";
            completer.complete("invalid-phone-number");
          } else {
            log(e.toString());
            // res = "error";
            completer.complete("error");
          }
        },
        codeSent: (verificationId, resendToken) {
          print("test3");
          this.verificationId = verificationId;
          completer.complete("code-sent");
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId = verificationId;
        },
      );
      return completer.future;
    } catch (e) {
      log(e.toString());
      return "error";
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      // _auth.authStateChanges().
      var credentials =
          await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      ));

      return credentials.user != null ? true : false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  void deleteAccount() async {
    try {
      String docsId = _auth.currentUser!.uid.toString();
      _firestore.collection('biodata').doc(docsId).delete();
      await _auth.currentUser!.delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> updateEmail(String newEmail, String password) async {
    Completer<String> completer = Completer();
    try {
      final user = FirebaseAuth.instance.currentUser!;

      var cred =
          EmailAuthProvider.credential(email: user.email!, password: password);

      await user.reauthenticateWithCredential(cred);

      await user.updateEmail(newEmail);
      completer.complete("success");
      return completer.future;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      completer.complete(e.code);
      return completer.future;
    }
  }
}
