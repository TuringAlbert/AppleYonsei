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
  final Function(bool) status;

  GetReservations({
    required this.documentID,
    required this.bRad,
    required this.bColor,
    required this.callback,
    required this.confAddress,
    required this.confName,
    required this.confNum,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference reservations =
        _firestore.collection('reservation_waiting');
    String currentDate = DateFormat('MM월 dd일').format(DateTime.now());

    return FutureBuilder<DocumentSnapshot>(
      future: reservations.doc(documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            if (snapshot.data == null || !snapshot.data!.exists) {
              return SizedBox.shrink();
            }

            /// if in avoid list, not show
            for (final avoid in data['avoid']) {
              if (avoid == user.uid) {
                return SizedBox.shrink();
              }
            }

            return Container(
              alignment: Alignment.topCenter,
              height: 180,
              width: 270,
              margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 50,
                            ),
                            Container(
                              height: 100,
                              width: 270,
                              // constraints: BoxConstraints(
                              //   maxWidth:
                              //       MediaQuery.of(context).size.width - 132,
                              // ),
                              color: Colors.lightGreen,
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "$currentDate ${data['time']} ",
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                  Text(
                                      "인원 : ${data['person']} 명, 노쇼 : ${data['noShow']} 회"),
                                  // Text("${data['person'] ?? 'loading...'}명"),
                                  Text("예약명 : ${data['nickname']}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 270,
                      height: 35,
                      margin: EdgeInsets.fromLTRB(5, 7, 0, 0),
                      color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              String reservation_Id = documentID;

                              await _firestore
                                  .collection('reservation_confirm')
                                  .doc(reservation_Id)
                                  .set({
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

                              await _firestore
                                  .collection('reservation_waiting')
                                  .doc(documentID)
                                  .delete();
                              status(true);

                              callback(true, documentID);
                            },
                            child: Text("수락"),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _firestore
                                  .collection('reservation_waiting')
                                  .doc(documentID)
                                  .update({
                                'avoid': [user.uid]
                              });
                              status(false);
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
            );
          } else {
            return SizedBox.shrink();
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}
