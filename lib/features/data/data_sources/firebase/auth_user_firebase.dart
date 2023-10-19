import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytradeasia/features/data/model/user_credential_models/user_credential_model.dart';
import 'package:mytradeasia/features/data/model/user_models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUserFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late PhoneAuthCredential phoneAuthCredential;
  var verificationId = '';

  Future<String> postRegisterUser(UserModel userData) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userData.email!, password: userData.password!);

      FirebaseAuth.instance.currentUser!
          .linkWithCredential(phoneAuthCredential);

      String docsId = FirebaseAuth.instance.currentUser!.uid.toString();
      Map<String, dynamic> data = userData.toMap();
      data["uid"] = docsId;
      FirebaseFirestore.instance.collection('biodata').doc(docsId).set(data);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  String getCurrentUId() => _auth.currentUser!.uid;

  Future<dynamic> postLoginUser(Map<String, String> auth) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: auth["email"]!, password: auth["password"]!);

      // final t = await _auth.signInWithPhoneNumber(phoneNumber)

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", auth["email"]!);
      await prefs.setBool("isLoggedIn", true);

      return UserCredentialModel.fromUserCredential(userCredential);
    } on FirebaseAuthException catch (e) {
      return {'code': e.code, 'message': e.message};
    }
  }

  Future<String> updateProfile(Map<String, dynamic> data) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('biodata').doc(getCurrentUId());

    return docRef.get().then((docSnapshot) async {
      var response = "network-error";
      if (docSnapshot.exists) {
        response = await docRef.update({
          'firstName': data["firstName"],
          'lastName': data["lastName"],
          'phone': data["phone"],
          'companyName': data["companyName"],
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

  Future<List> getRecentlySeen() async {
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

    return recentlySeenData;
  }

  Future<String> phoneAuthentication(String phoneNo) async {
    try {
      Completer<String> completer = Completer();
      // var res = "";
      await FirebaseAuth.instance.verifyPhoneNumber(
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
}
