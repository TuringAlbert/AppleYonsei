import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class InboxPage extends StatefulWidget {
  final bool isShrink;

  const InboxPage({Key? key, required this.isShrink}) : super(key: key);

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;
  late String businessCode;
  bool dialogShown = false;

  @override
  void initState() {
    super.initState();
    // String waitingCollectionPath = 'reservation_waiting';
    // _getUserBusinessCode();

    // // 문서 생성 감지 및 처리
    // _subscription = _firestore
    //     .collection(waitingCollectionPath)
    //     .snapshots()
    //     .listen((QuerySnapshot<Map<String, dynamic>> event) {
    //   for (QueryDocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
    //     if (doc['prefer'] == businessCode && !dialogShown) {
    //       _showConfirmationDialog(doc);
    //       dialogShown = true;
    //       _updatePendingStatus(doc.id);
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    // _subscription?.cancel();
    super.dispose();
  }

  // void _getUserBusinessCode() async {
  //   final User? user = _auth.currentUser;
  //   if (user != null) {
  //     DocumentSnapshot<Map<String, dynamic>> userDoc =
  //     await _firestore.collection('users').doc(user.uid).get();
  //     setState(() {
  //       businessCode = userDoc['businessCode'];
  //     });
  //   }
  // }

  // // 팝업 띄우기
  // Future<void> _showConfirmationDialog(
  //     QueryDocumentSnapshot<Map<String, dynamic>> doc,
  //     ) async {
  //   if (doc['pending_status']) {
  //     return;
  //   }

  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('예약 확인'),
  //         content: Text('수락 또는 거절하시겠습니까?'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               _acceptReservation(doc);
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('수락'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               _rejectReservation(doc.id);
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('거절'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _updatePendingStatus(String docId) {
  //   _firestore
  //       .collection('reservation_waiting')
  //       .doc(docId)
  //       .update({'pending_status': true});
  // }

  // void _acceptReservation(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
  //   _firestore.collection('reservation_confirm').add({
  //     'person': doc['person'],
  //     'user': doc['user'],
  //     'prefer': doc['prefer'],
  //     'time': doc['time'],
  //     'location': doc['location'],
  //     "pending_status": true,
  //     "confirm_status": true,
  //   });

  //   _firestore.collection('reservation_waiting').doc(doc.id).delete();
  // }

  // void _rejectReservation(String docId) {
  //   bool isPopupClosed = false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: Center(
        child: Text('Inbox Page'),
      ),
    );
  }
}

class YourConfirmationWidget extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;

  YourConfirmationWidget({required this.onAccept, required this.onReject});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 1000,
      color: Colors.lightGreen,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InboxPage(isShrink: false),
    );
  }
}
