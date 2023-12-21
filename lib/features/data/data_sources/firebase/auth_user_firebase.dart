import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytradeasia/features/data/model/all_product_models/all_product_model.dart';
import 'package:mytradeasia/features/data/model/user_credential_models/user_credential_model.dart';
import 'package:mytradeasia/features/data/model/user_models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUserFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  AuthCredential? _credential;

  late PhoneAuthCredential phoneAuthCredential;
  var verificationId = '';
  final dio = Dio();

  Future<String> postRegisterUser(UserModel userData) async {
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
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: auth["email"]!, password: auth["password"]!);
      _credential = EmailAuthProvider.credential(
          email: auth["email"]!, password: auth["password"]!);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", auth["email"]!);
      await prefs.setBool("isLoggedIn", true);

      return UserCredentialModel.fromUserCredential(_userCredential);
    } on FirebaseAuthException catch (e) {
      return {'code': e.code, 'message': e.message};
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
    final url = 'https://linkedin-firebase-auth-integrator.vercel.app/token';

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

  Future<String> updateEmail(String newEmail) async {
    Completer<String> completer = Completer();
    try {
      final user = FirebaseAuth.instance.currentUser!;
      // await user.sendEmailVerification()
      log("CREDENTIAL : $_credential");
      log("METHOD : ${_credential?.signInMethod}");

      if (_credential != null) {
        await user.reauthenticateWithCredential(_credential!);
      }

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
