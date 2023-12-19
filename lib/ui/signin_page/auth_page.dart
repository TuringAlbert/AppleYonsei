import 'package:AppleYonsei/ui/customer_page/customer_home_page.dart';
import 'package:AppleYonsei/ui/enterprise_page/enterprise_home_page.dart';
import 'package:AppleYonsei/ui/signin_page/common_signup/card_page.dart';
import 'package:AppleYonsei/ui/signin_page/enterprise_signup/enterprise_reservation_page.dart';
import 'package:AppleYonsei/ui/signin_page/login_or_register.dart';
import 'package:AppleYonsei/ui/signin_page/register_page.dart';
import 'package:AppleYonsei/ui/signin_page/signin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late bool _dataLoaded; // Variable to track whether data has been loaded

  @override
  void initState() {
    super.initState();
    _dataLoaded = false; // Initialize to false when the widget is created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is signed in
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: getUserData(snapshot.data!.uid),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                } else {
                  // Data loaded successfully, set _dataLoaded to true
                  _dataLoaded = true;

                  if (userSnapshot.hasData) {
                    // Check the value of userTypeCustomer
                    bool userTypeCustomer = userSnapshot.data!['userTypeCustomer'] ?? false;

                    // 카드 등록 여부에 따른 화면 전환
                    // if (userSnapshot.hasData) {
                    //   // Check the value of cardRegister
                    //   bool cardRegister = userSnapshot.data!['cardRegister'];
                    //   print("===================");
                    //   print(cardRegister);
                    //   if (cardRegister == false) {
                    //     return CardPage();
                    //   }
                    // }

                    if (_dataLoaded) {
                      if (userTypeCustomer) {
                        // userTypeCustomer is true, show MyHomePage
                        return CustomerMyHomePage(index: 1);
                      }
                      else {
                        //가게 정보 등록여부 확인
                        bool enterpriseDataRegister = userSnapshot.data!['enterpriseDataRegister'];
                        if (enterpriseDataRegister == false){
                          return EnterpriseReservationPage(isShrink: false);
                        }

                        else {
                          return EnterpriseMyHomePage(title: "Enterprise Home Page");
                        }
                      }
                      // Content has been loaded, show the actual content
                    }
                    else {
                      // Data is still loading, show CircularProgressIndicator
                      return CircularProgressIndicator();
                    }
                  }
                  else {
                    // User data not found, handle accordingly
                    return LoginOrRegisterPage();
                  }
                }
              },
            );
          } else {
            // User is not signed in
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }
}

