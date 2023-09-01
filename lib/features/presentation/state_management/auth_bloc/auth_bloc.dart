import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../widget/dialog_sheet_widget.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthLoadingState()) {
    on<LoginWithEmail>((event, emit) async {
      BuildContext context = event.context;
      try {
        // TODO: implement event handler
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("email", event.email);
        // await prefs.setString("phoneNumber", event);
        await prefs.setBool("isLoggedIn", true);

        print(userCredential);

        // emit(AuthLoggedInState(userCredential.user));
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          showDialog(
            context: context,
            builder: (context) => DialogWidget(
                urlIcon: "assets/images/logo_delete_account.png",
                title: "Wrong Email",
                subtitle: "No user found for that email.",
                textForButton: "Go back",
                navigatorFunction: () {
                  context.pop(context);
                }),
          );
        } else if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) => DialogWidget(
                urlIcon: "assets/images/logo_delete_account.png",
                title: "Wrong Password",
                subtitle: "Wrong password provided for that user.",
                textForButton: "Go back",
                navigatorFunction: () {
                  context.pop(context);
                }),
          );
        }
      }
    });
    on<RegisterWithEmail>((event, emit) async {
      // TODO: implement event handler
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: event.email, password: event.password);

        emit(AuthLoggedInState(userCredential.user));

        String docsId = FirebaseAuth.instance.currentUser!.uid.toString();
        Map<String, dynamic> data = {
          'role': event.role,
          "companyName": event.companyName,
          "country": event.country,
          "firstName": event.firstName,
          "lastName": event.lastName,
          "password": event.password,
          "uid": docsId,
        };
        FirebaseFirestore.instance.collection('biodata').doc(docsId).set(data);
      } on FirebaseAuthException catch (e) {
        // if (e.code == "email-already-in-use") {
        //   showDialog(
        //     context: context,
        //     builder: (context) => DialogWidget(
        //         urlIcon: "assets/images/logo_delete_account.png",
        //         title: "Email already in use",
        //         subtitle: "Try another email for registration",
        //         textForButton: "Go back",
        //         navigatorFunction: () {
        //           Navigator.pop(context);
        //         }),
        //   );
        // }
        emit(AuthErrorState(e));
      }
    });
    on<LogOut>((event, emit) {
      // TODO: implement event handler
    });
  }
}
