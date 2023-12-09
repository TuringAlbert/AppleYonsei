import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class GetReservations extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String businessCode;
  late String confAddress;
  late String confName;
  late String confNum;
  final user = FirebaseAuth.instance.currentUser!;

  final String documentID;
  final double bRad;
  final int bColor;
  final Function(bool, dynamic) callback;

  GetReservations({
    required this.documentID,
    required this.bRad,
    required this.bColor,
    required this.callback,
    required this.confAddress,
    required this.confName,
    required this.confNum,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference reservations = _firestore.collection('reservation_waiting');
    String currentDate = DateFormat('MM월 dd일').format(DateTime.now());

    return FutureBuilder<DocumentSnapshot>(
      future: reservations.doc(documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

            if (snapshot.data == null || !snapshot.data!.exists) {
              return SizedBox.shrink();
            }

            return Container(
              alignment: Alignment.topCenter,
              height: 180,
              width: 300,
              margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 50,
                          ),
                          Container(
                            height: 80,
                            width: 220,
                            color: Colors.blue,
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "$currentDate ${data['time']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: double.nan,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(1, 0, 3, 0),
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: Colors.amberAccent,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        "예약 대기",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 4,
                                ),
                                Text("인원 : ${data['confNum']} 명"),
                                Text("예약명 : ${data['confName']}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Center(
                            child: Container(
                              width: 270,
                              height: 35,
                              margin: EdgeInsets.fromLTRB(5, 7, 0, 0),
                              color: Colors.yellow,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      String reservation_Id = documentID;

                                      await _firestore.collection('reservation_confirm').doc(reservation_Id).set({
                                        'person': data['person'],
                                        'user': data['user'],
                                        'noShow': data['noShow'],
                                        'nickname': data['nickname'],
                                        'prefer': data['prefer'],
                                        'time': data['time'],
                                        'location': data['location'],
                                        "pending_status": true,
                                        "confirm_status": true,
                                        "button_status": true,
                                        "confirmedStoreAddress": confAddress,
                                        "confirmedStoreName": confName,
                                        "confirmedStoreNum": confNum,
                                        "Enter_uid": user.uid,
                                        "customer_uid": data['customer_uid'],
                                        "reservation_Id": reservation_Id,
                                      });

                                      await _firestore.collection('reservation_waiting')
                                          .doc(documentID)
                                          .delete();
                                      callback(true, documentID);
                                    },
                                    child: Text("수락"),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      callback(true, documentID);
                                    },
                                    child: Text("제거"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}







// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';
//
// class GetReservations extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   late String businessCode;
//   late String confAddress;
//   late String confName;
//   late String confNum;
//   final user = FirebaseAuth.instance.currentUser!;
//
//   final String documentID;
//   final double bRad;
//   final int bColor;
//   final Function(bool, dynamic) callback;
//
//
//   GetReservations({
//     required this.documentID,
//     required this.bRad,
//     required this.bColor,
//     required this.callback,
//     required this.confAddress,
//     required this.confName,
//     required this.confNum,
//
//   });
//
//   // Future<void> initNotifications() async {
//   //   // request permission from user
//   //   await _FirebaseMessaging.requestPermission();
//   //   // fetch FCM Token
//   //   final fCMToken = await _FirebaseMessaging.getToken();
//   //   // Print Token
//   //   print('Token:  + $fCMToken');
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference reservations =
//     _firestore.collection('reservation_waiting');
//
//     return FutureBuilder<DocumentSnapshot>(
//       future: reservations.doc(documentID).get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData) {
//             ////    PRINT SNAPSHOT    /////
//             // print(snapshot);
//
//             if (snapshot.data == null || !snapshot.data!.exists) {
//               // Document doesn't exist
//               return SizedBox.shrink();
//             }
//             Map<String, dynamic> data =
//             snapshot.data!.data() as Map<String, dynamic>;
//
//             return Container(
//               margin: const EdgeInsets.all(2.0),
//               decoration: BoxDecoration(
//                 color: Color(bColor),
//                 borderRadius: BorderRadius.circular(bRad),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(Icons.calendar_month, size: 50,),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text("${data['time'] ?? 'loading...'} 시"),
//                       Text("${data['person'] ?? 'loading...'}명"),
//                       Text('${data['user'] ?? 'loading...'}'),
//                       Text("노쇼 : ${data['noShow'] ?? 'loading...'} 회"),
//                     ],
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       String reservation_Id = documentID;
//
//                       await _firestore.collection('reservation_confirm').doc(reservation_Id).set({
//                         'person': data['person'],
//                         'user': data['user'],
//                         'noShow': data['noShow'],
//                         'nickname': data['nickname'],
//                         'prefer': data['prefer'],
//                         'time': data['time'],
//                         'location': data['location'],
//                         "pending_status": true,
//                         "confirm_status": true,
//                         "button_status": true,
//                         "confirmedStoreAddress": confAddress,
//                         "confirmedStoreName": confName,
//                         "confirmedStoreNum": confNum,
//                         "Enter_uid" : user.uid,
//                         "customer_uid" : data['customer_uid'],
//                         "reservation_Id" : reservation_Id,
//                       });
//
//                       await _firestore.collection('reservation_waiting')
//                           .doc(documentID)
//                           .delete();
//                       callback(true, documentID);
//                     },
//                     child: Text("수락"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       callback(true, documentID);
//                     },
//                     child: Text("제거"),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             // If snapshot has no data, return an empty Container
//             return Container();
//           }
//         }
//         return Text('');
//       },
//     );
//   }
// }