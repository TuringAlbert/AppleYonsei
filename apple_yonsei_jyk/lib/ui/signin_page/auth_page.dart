import 'package:AppleYonsei/home_page.dart';
import 'package:AppleYonsei/ui/signin_page/login_or_register.dart';
import 'package:AppleYonsei/ui/signin_page/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});


  @override

  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return MyHomePage(title: "Apple Yonsei Group Reservation");
          }
          else {
            return LoginOrRegisterPage();
          }
        }
      ),

    );
  }
}