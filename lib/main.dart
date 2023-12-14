import 'dart:ui' as ui;
import 'dart:html';

import 'package:flutter/material.dart';





import 'package:AppleYonsei/ui/customer_page/customer_profile_page/customer_profile_page.dart';
import 'package:AppleYonsei/ui/signin_page/auth_page.dart';
import 'package:AppleYonsei/ui/signin_page/common_signup/card_page.dart';
import 'package:flutter/material.dart';
import 'package:AppleYonsei/ui/customer_page/customer_home_page.dart';
import 'package:AppleYonsei/ui/signin_page/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
//

void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppleYonseiApp());
}

class AppleYonseiApp extends StatelessWidget {
  const AppleYonseiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group Reservation App for Yonseian',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routes: routes,
      // home: CardPage(),
      home: AuthPage(),
      // home : HomePage(),
      // home: const LoginPage(isShrink: false),
      // home: const MyHomePage(title: 'Apple Yonsei Group Reservation'),
    );
  }
}

