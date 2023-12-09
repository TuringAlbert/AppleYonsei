import 'package:AppleYonsei/ui/enterprise_page/dashboard_page/reservation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({
    Key? key,
    required this.title,

    ///required this.updateArray
  }) : super(key: key);

  final String title;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

/// YES NO SWITCHER ///
enum Switcher { yes, no }

class _DashboardPageState extends State<DashboardPage> {
  final int bColor = 0xffeeeeee;

//// for callback function
  bool yourState = false;

//// Refresh Update
  late Timer _timer;

  final double bRad = 35.0;

  final int feedNum = 3;

  final int groupValue = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String businessCode;
  late String locationCode;
  late String storeName;
  late String storeAddress;
  late String storeNum;

  /// default switch
  Switcher selectedSwitcher = Switcher.yes;

  /// list of reservations
  List<String> reservationDocId = [];

  @override
  void initState() {
    _getUserInfo();
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      setState(() {
        // Trigger a rebuild by updating the state
      });
      reservationDocId = [];
    });
  }

  late String confAddress = '$storeAddress $locationCode $storeName';

  Future getResvDocId() async {
    await FirebaseFirestore.instance
        .collection('reservation_waiting')
        .where('confirm_status', isEqualTo: false)
        .where('pending_status', isEqualTo: false)
        .where('prefer', isEqualTo: businessCode)
        .where('location', isEqualTo: locationCode)
        .get()
        .then((snapshot) => snapshot.docs.forEach((confDocument) {
              // print(confDocument.reference.id);
              reservationDocId.add(confDocument.reference.id);
            }));
  }

  // Fetch history data only if it's not already available
  Future<void> fetchHistoryData() async {
    if (reservationDocId.isEmpty) {
      await getResvDocId();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bRad),
            bottomRight: Radius.circular(bRad),
          ),
          child: AppBar(
            backgroundColor: Color(bColor),
            title: Text(widget.title),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///// RECEIVING SWITCH /////

            Container(
              margin: const EdgeInsets.all(8.0),
              // width: screenWidth,
              decoration: BoxDecoration(
                color: Color(bColor),
                borderRadius: BorderRadius.circular(bRad),
              ),
              child: Container(
                width: 800,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(Icons.notifications),
                    // Text(businessCode),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: CupertinoSlidingSegmentedControl<Switcher>(
                          thumbColor: Colors.blue,
                          children: {
                            Switcher.no: Text("No"),
                            Switcher.yes: Text("Yes"),
                          },
                          onValueChanged: (Switcher? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedSwitcher = newValue;
                              });
                            }
                          },
                          groupValue: selectedSwitcher,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text("예약 대기"),
              ),
            ),

            /////// 예약대기 //////////
            Expanded(child: feedState(selectedSwitcher, updateState)),

            /// MAKE MORE RESERVATIONS ///

            // FloatingActionButton(
            //   onPressed: acceptReservation,
            //   child: Text('PLACEHOLDER add user'),
            // )

            /// MAKE MORE RESERVATIONS ///
          ],
        ),
      ),
    );
  }

  Widget feedState(
    Switcher category,
    Function(bool, dynamic) updateState,
  ) {
    switch (category) {
      case Switcher.no:
        // print(reservationDocId);
        reservationDocId = [];
        return Center(child: Text(''));
      case Switcher.yes:
        // print(reservationDocId);

        return FutureBuilder(
          future: fetchHistoryData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // or another loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // print(itemsToRemove);
              return ListView.builder(
                itemCount: reservationDocId.length,
                itemBuilder: (context, index) => ListTile(
                  title: GetReservations(
                    documentID: reservationDocId[index],
                    bColor: bColor,
                    bRad: bRad,
                    callback: updateState,
                    confAddress: confAddress,
                    confName: storeName,
                    confNum: storeNum,
                    // updateArray: widget.updateArray
                  ),
                ),
              );
            }
          },
        );
    }
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void _getUserInfo() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        businessCode = userDoc['businessCode'];
        locationCode = userDoc['locationCode'];
        storeName = userDoc['storeName'];
        storeAddress = userDoc['storeAddress'];
        storeNum = userDoc['store_num'];
      });
    }
  }

  // Callback function to update the state
  void updateState(bool newState, dynamic delItem) {
    setState(() {
      yourState = newState;
      reservationDocId.remove(delItem);
    });
  }

  /// PLACEHOLDER FUNCTION, add users
  void acceptReservation() {
    _firestore.collection('reservation_waiting').add({
      'person': 4,
      'user': 'test123@gmail.com',
      'prefer': '치킨',
      'time': '16:00',
      'location': '신촌',
      "pending_status": true,
      "confirm_status": false,
    });
  }
}

