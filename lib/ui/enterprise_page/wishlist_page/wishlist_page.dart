import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


// FirebaseFirestore firestore = FirebaseFirestore.instance;


Future<List<Map<String, dynamic>>> getData() async {
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return [];
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;

  var result = await FirebaseFirestore.instance
      .collection('reservation_confirm').orderBy('time')
      .get();
  return result.docs
      .where((doc) => doc['confirm_status'] == true  && doc['Enter_uid'] == uid)
      .map((doc) => (doc.data() as Map<String, dynamic>?) ?? {})
      // .map((doc) => {'id': doc.id, ...doc.data()!})
      .toList();
}



class WishlistPage extends StatefulWidget {
  final bool isShrink;

  const WishlistPage({required this.isShrink, Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late Future<List<Map<String, dynamic>>> getDataFuture;

  @override
  void initState() {
    super.initState();
    getDataFuture = getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ReservText(),
                ReservationSum(dataFuture: getDataFuture),
                ReservListText(),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: getDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('에러: ${snapshot.error}');
                    } else if (snapshot.data == null) {
                      return Text('데이터가 없습니다.');
                    } else {
                      List<Widget> reservationWidgets = [];
                      for (var data in snapshot.data!) {
                        String dateData = data['date']?.toString() ?? '';
                        String numPeople = data['person']?.toString() ?? '';
                        String nickname = data['nickname']?.toString() ?? '';
                        String phoneNum = data['phone_num']?.toString() ?? '';
                        String resvTime = data['time']?.toString() ?? '';
                        String customer_uid = data['customer_uid']?.toString() ?? '';
                        String userNoShow = data['noShow']?.toString() ?? '';
                        bool button_status = data['button_status'] as bool? ?? false;
                        String reservation_Id = data['reservation_Id']?.toString() ?? '';

                        reservationWidgets.add(
                          Reservationlist(
                            dateData: dateData,
                            numPeople: numPeople,
                            nickname: nickname,
                            phoneNum: phoneNum,
                            resvTime: resvTime,
                            customer_uid: customer_uid,
                            userNoShow: userNoShow,
                            button_status: button_status,
                            reservation_Id: reservation_Id,
                          ),
                        );
                      }
                      return Column(children: reservationWidgets);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Reservationlist extends StatefulWidget {
  final String dateData;
  final String numPeople;
  final String nickname;
  final String phoneNum;
  final String resvTime;
  final String customer_uid;
  final String userNoShow;
  final bool button_status;
  final String reservation_Id;

  const Reservationlist({
    required this.dateData,
    required this.numPeople,
    required this.nickname,
    required this.phoneNum,
    required this.resvTime,
    required this.customer_uid,
    required this.userNoShow,
    required this.button_status,
    required this.reservation_Id,
    Key? key,
  }) : super(key: key);

  @override
  _ReservationlistState createState() => _ReservationlistState();
}

class _ReservationlistState extends State<Reservationlist> {
  // bool buttonsVisible = widget.button_status;
  late bool buttonsVisible;
  late Future<String> userEmailFuture;

  @override
  void initState() {
    super.initState();
    buttonsVisible = widget.button_status;
  }

  void _toggleButtonsVisibility() {
    setState(() {
      buttonsVisible = !buttonsVisible;
      print(buttonsVisible);
    });
  }


  void onPressedConfirmed(String reservation_Id) async {
    try {
      await FirebaseFirestore.instance.collection('reservation_confirm')
          .doc(widget.reservation_Id)
          .update({
        'button_status': false,
      });

      print('final_confirm is updated to false');
      _toggleButtonsVisibility();
    } catch (e) {
      print('Error updating final_confirm: $e');
    }
  }


  void onPressedNoShow(String customer_uid) async {
    try {
      if (customer_uid?.isNotEmpty ?? false) {
        await FirebaseFirestore.instance.collection('users').doc(customer_uid).update({
          'noShow': FieldValue.increment(1),
        });

        print('customer_uid: $customer_uid');
        print('노쇼 버튼이 눌렸습니다. 사용자의 No-show +1 카운트가 업데이트되었습니다: $customer_uid');

        await FirebaseFirestore.instance.collection('reservation_confirm')
            .doc(widget.reservation_Id)
            .update({
          'button_status': false,
        });

        _toggleButtonsVisibility();
      } else {
        print('유효하지 않은 customer_uid: $customer_uid');
      }
    } catch (e) {
      print('No-show +1 카운트 업데이트 중 오류 발생: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('MM월 dd일').format(DateTime.now());

    return Container(
      alignment: Alignment.topCenter,
      height: buttonsVisible ? 145 : 110,
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
              Icon(
                Icons.calendar_month,
                size: 50,
              ),
              Container(
                height: 80,
                width: 220,
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$currentDate ${widget.resvTime}",
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
                            "예약 확정",
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
                    // Text("${widget.numPeople} 명,    노쇼: ${widget.userNoShow} 회"),
                    Text("인원 : ${widget.numPeople} 명"),
                    Text("예약명 : ${widget.nickname}"),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              if (buttonsVisible)
                Center(
                  child: Container(
                    width: 270,
                    height: 35,
                    margin: EdgeInsets.fromLTRB(5, 7, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            primary: Colors.lightGreen,
                          ),
                          onPressed: () {
                            onPressedConfirmed(widget.reservation_Id);
                          },
                          child: Text(
                            "왔다",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            onPressedNoShow(widget.customer_uid);
                          },
                          child: Text(
                            "노쇼",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}

class ReservationSum extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> dataFuture;

  const ReservationSum({required this.dataFuture, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('에러: ${snapshot.error}');
        } else {
          int currentDayReservations = snapshot.data?.length ?? 0;

          return Container(
            width: 300,
            height: 50,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(currentDate),
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.grey,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("예약 확정: $currentDayReservations 팀"),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class ReservText extends StatelessWidget {
  const ReservText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 300,
      margin: EdgeInsets.fromLTRB(4, 20, 0, 0),
      child: Text("예약 내역",
      style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
      ),
    );
  }
}

class ReservListText extends StatelessWidget {
  const ReservListText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 300,
      margin: EdgeInsets.fromLTRB(4, 10, 0, 0),
      child: Text("예약 목록",
      style: TextStyle(
      fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}

void main() {
  runApp(WishlistPage(isShrink: false));
}