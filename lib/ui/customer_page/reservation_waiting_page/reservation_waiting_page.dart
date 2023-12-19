import 'dart:async';

import 'package:AppleYonsei/ui/customer_page/reservation_waiting_page/model/naver_map_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:AppleYonsei/ui/customer_page/customer_profile_page/login_overlay_widget.dart';
import 'package:AppleYonsei/ui/customer_page/common/animated_scale_screen_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationWaitingPage extends StatefulWidget {
  const ReservationWaitingPage({Key? key}) : super(key: key);

  @override
  _ReservationWaitingPageState createState() => _ReservationWaitingPageState();
}

class _ReservationWaitingPageState extends State<ReservationWaitingPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  late Timer _timer;
  int _selectedIndex = 0;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  // List to hold data from Firebase
  List<Map<String, dynamic>> reservationData = [];
  List<Map<String, dynamic>> reservationWaitingData = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('예약 확정'),
            ),
            body: Column(
              children: [
                // Add a simple ListTile
                ListTile(
                  contentPadding: EdgeInsets.all(10),
                  tileColor: Colors.amber,
                  title: Text(
                    "예약대기 내역",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Use ListView.builder to dynamically create ListTiles
                Expanded(
                  child: ListView.builder(
                    itemCount: reservationWaitingData.length,
                    itemBuilder: (context, index) {
                      var dataWaiting = reservationWaitingData[index];
                      return Container(
                        margin: EdgeInsets.fromLTRB(
                            10, 5, 10, 5), // Set top and bottom padding
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.orange)),
                        child: ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text(dataWaiting['prefer'] +
                              " 관련 " +
                              dataWaiting["location"] +
                              "지역 식당을 찾고 있어요!"),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("장소 : " + dataWaiting['location']),
                                      VerticalDivider(thickness: 1),
                                      Text("시간 : " + dataWaiting['time']),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("인원 : " +
                                          dataWaiting['person'] +
                                          " 명"),
                                      VerticalDivider(thickness: 1),
                                      Text("선호 메뉴 : " + dataWaiting['prefer']),
                                      VerticalDivider(thickness: 1),
                                      Text("비선호 메뉴 : " +
                                          dataWaiting['unprefer']),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  ElevatedButton(
                                      onPressed: () {
                                        //예약 취소하기
                                        _cancelReservation(dataWaiting['user']);
                                      },
                                      child: const Text(
                                        "예약 취소",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                        foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                        minimumSize:
                                        MaterialStateProperty.all(Size(50, 50)),
                                      ))
                                  // Add more subtitles as needed
                                ],
                              ),

                            ],
                          ),
                          onTap: () {
                            // Add your onTap logic here
                          },
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  tileColor: Colors.amber,
                  title: Text(
                    "예약확정 내역",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Use ListView.builder to dynamically create ListTiles
                Expanded(
                  child: ListView.builder(
                    itemCount: reservationData.length,
                    itemBuilder: (context, index) {
                      var data = reservationData[index];

                      return Container(
                        margin:
                            EdgeInsets.all(5.0), // Set top and bottom padding
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.orange)),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.calendar_today),
                              title: Text(data['confirmedStoreName']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['confirmedStoreAddress']),
                                  Text(data['confirmedStoreNum']),
                                  // Add more subtitles as needed
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NaverMapPage(),
                                  ),
                                );
                                // Add your onTap logic here
                              },
                            ),
                          ],
                        ),

                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _fetchDataFromFirebase();
      });
    });
  }

  void _fetchDataFromFirebase() async {
    //email 불러오기
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    // List<Map<String, dynamic>> result_uid = result.map((doc) => doc.data() as Map<String, dynamic>).toList();
    // print("HELLO WORLD---------------------");
    String userEmail = result['email'];
    // print("user Email : $userEmail");
    //예약확정 내역 데이터 불러오기
    var snapshot = await FirebaseFirestore.instance
        .collection('reservation_confirm')
        .where("user", isEqualTo: userEmail)
        .get();
    // print("snapshot : $snapshot");
    var documents = snapshot.docs;

    // var reservationData = documents.map((doc) => doc.data() as Map<String, dynamic>).toList();
    // print(reservationData);

    var reservationsnap = FirebaseFirestore.instance
        .collection('reservation_confirm')
        .where("user", isEqualTo: userEmail)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      snapshot.docChanges.forEach((change) {
        var reservationData =
            documents.map((doc) => doc.data() as Map<String, dynamic>).toList();
        // print(reservationData);
        // Handle document changes (added, modified, removed)
        if (change.type == DocumentChangeType.added) {
          // print("Added: ${change.doc.data()}");
        } else if (change.type == DocumentChangeType.modified) {
          // print("Modified: ${change.doc.data()}");
        } else if (change.type == DocumentChangeType.removed) {
          // print("Removed: ${change.doc.data()}");
        }
      });
    });

    //예약대기 내역 데이터 불러오기
    var snapshot_waiting_query = await FirebaseFirestore.instance
        .collection("reservation_waiting")
        .where("user", isEqualTo: userEmail)
        .get();
    var documents_waiting_query = snapshot_waiting_query.docs;

    setState(() {
      //예약대기 내역 데이터 불러오기
      reservationWaitingData = documents_waiting_query
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      // print(reservationWaitingData);
      //예약확정 내역 데이터 불러오기
      reservationData =
          documents.map((doc) => doc.data() as Map<String, dynamic>).toList();
      // print(reservationData);
    });
  }

  void _cancelReservation(String reservationId) async {
    try {
      //email 불러오기
      var result =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // List<Map<String, dynamic>> result_uid = result.map((doc) => doc.data() as Map<String, dynamic>).toList();
      // print("HELLO WORLD---------------------");
      String userEmail = result['email'];
      var snapshot_waiting_query = await FirebaseFirestore.instance
          .collection("reservation_waiting")
          .where("user", isEqualTo: userEmail)
          .get();

      var documents_waiting_query = snapshot_waiting_query.docs;

      documents_waiting_query.forEach((doc) {
        var uuid = doc.id;
        FirebaseFirestore.instance
            .collection('reservation_waiting')
            .doc(uuid)
            .delete();
        setState(() {
          // 여기에서 상태를 업데이트하거나 필요한 작업을 수행할 수 있습니다.
        });
      });
      // 취소 성공 메시지 출력
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('예약이 취소되었습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // 취소 실패 시 에러 메시지 출력
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('예약 취소에 실패했습니다. 다시 시도해주세요.'),
          duration: Duration(seconds: 2),
        ),
      );
      print('예약 취소 에러: $e');
    }
  }
}
