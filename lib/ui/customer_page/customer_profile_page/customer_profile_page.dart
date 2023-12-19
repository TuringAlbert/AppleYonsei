import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:AppleYonsei/ui/customer_page/common/animated_scale_screen_widget.dart';
import 'package:AppleYonsei/ui/customer_page/customer_profile_page/login_overlay_widget.dart';
import 'package:AppleYonsei/ui/customer_page/customer_profile_page/model/extra_info_item.dart';

class CustomerProfilePage extends StatefulWidget {
  final bool isShrink;

  const CustomerProfilePage({Key? key, required this.isShrink}) : super(key: key);

  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends AnimatedScaleScreenWidget<CustomerProfilePage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser!;

  bool goToOtherPage = true;
  bool _showOverlay = false;
  late AnimationController? overlayController;
  late Animation<double>? overlayAnimation;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    isShrink = widget.isShrink;
    overlayController = null;
    overlayAnimation = null;
  }

  @override
  void dispose() {
    super.dispose();
    if (!mounted) {
      overlayController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError){
          return Text('Error : ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists){
          return Text('Document does not exist');
        }
        //nickname 데이터 가져오기
        var nickname = snapshot.data!['nickname'];
        var noShow = snapshot.data?.get('noShow') ?? '';

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            return animatedScaleWidget(
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${nickname}님! \n환영합니다 :)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0,
                              color: Colors.black,
                            ),
                          ),
                          Text("노쇼 이력 : $noShow 회"),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(height: 10,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          Color(0xFF0D47A1),
                                          Color(0xFF1976D2),
                                          Color(0xFF42A5F5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(16.0),
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: signUserOut,
                                  child: const Text('Log Out'),

                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.withOpacity(0.20),
                            Colors.grey.withOpacity(0.1),
                            Colors.white,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ExtraInfoItem.items.map((item) {
                        Widget rowItem = TextButton(
                          onPressed: () => item.onTap(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: SizedBox(
                              height: 35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    item.label,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  item.icon,
                                ],
                              ),
                            ),
                          ),
                        );
                        if (ExtraInfoItem.items.indexOf(item) != ExtraInfoItem.items.length - 1) {
                          return Column(
                            children: [
                              rowItem,
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                child: Container(
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              )
                            ],
                          );
                        }
                        return rowItem;
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text('Error fetching storeName'),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    // return animatedScaleWidget(SingleChildScrollView(
    //     physics: const AlwaysScrollableScrollPhysics(
    //       parent: BouncingScrollPhysics(),
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Padding(
    //           padding:
    //           const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 user.email! + "님! \n환영합니다 :)",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 26.0,
    //                     color: Colors.black),
    //               ),
    //               const SizedBox(
    //                 height: 10,),
    //               ClipRRect(
    //                 borderRadius: BorderRadius.circular(4),
    //                 child: Stack(
    //                   children: <Widget>[
    //                     Positioned.fill(
    //                       child: Container(
    //                         decoration: const BoxDecoration(
    //                           gradient: LinearGradient(
    //                             colors: <Color>[
    //                               Color(0xFF0D47A1),
    //                               Color(0xFF1976D2),
    //                               Color(0xFF42A5F5),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     TextButton(
    //                       style: TextButton.styleFrom(
    //                         foregroundColor: Colors.white,
    //                         padding: const EdgeInsets.all(16.0),
    //                         textStyle: const TextStyle(fontSize: 20),
    //                       ),
    //                       onPressed: signUserOut,
    //                       child: const Text('Log Out'),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           height: 5,
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               colors: [
    //                 Colors.grey.withOpacity(0.20),
    //                 Colors.grey.withOpacity(0.1),
    //                 Colors.white,
    //               ],
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter,
    //             ),
    //           ),
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: ExtraInfoItem.items.map((item) {
    //             Widget rowItem = TextButton(
    //               onPressed: () => item.onTap(),
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
    //                 child: SizedBox(
    //                   height: 35,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Text(
    //                         item.label,
    //                         style: const TextStyle(fontSize: 16.0),
    //                       ),
    //                       item.icon,
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //             if (ExtraInfoItem.items.indexOf(item) !=
    //                 ExtraInfoItem.items.length - 1) {
    //               return Column(
    //                 children: [
    //                   rowItem,
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(vertical: 3.0),
    //                     child: Container(
    //                       height: 1,
    //                       color: Colors.grey.withOpacity(0.5),
    //                     ),
    //                   )
    //                 ],
    //               );
    //             }
    //             return rowItem;
    //           }).toList(),
    //         ),
    //       ],
    //     ),
    //   ),);
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:AppleYonsei/ui/customer_page/common/animated_scale_screen_widget.dart';
// import 'package:AppleYonsei/ui/customer_page/customer_profile_page/login_overlay_widget.dart';
// import 'package:AppleYonsei/ui/customer_page/customer_profile_page/model/extra_info_item.dart';
//
// class CustomerProfilePage extends StatefulWidget {
//   final bool isShrink;
//
//   const CustomerProfilePage({Key? key, required this.isShrink}) : super(key: key);
//
//   @override
//   _CustomerProfilePageState createState() => _CustomerProfilePageState();
// }
//
// class _CustomerProfilePageState extends AnimatedScaleScreenWidget<CustomerProfilePage> {
//   void signUserOut() {
//       FirebaseAuth.instance.signOut();
//   }
//
//   final user = FirebaseAuth.instance.currentUser!;
//
//   bool goToOtherPage = true;
//   bool _showOverlay = false;
//   late AnimationController? overlayController;
//   late Animation<double>? overlayAnimation;
//   OverlayEntry? _overlayEntry;
//
//   @override
//   void initState() {
//     super.initState();
//     isShrink = widget.isShrink;
//     overlayController = null;
//     overlayAnimation = null;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     if (!mounted) {
//       overlayController!.dispose();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         if (snapshot.hasError){
//           return Text('Error : ${snapshot.error}');
//         }
//         if (!snapshot.hasData || !snapshot.data!.exists){
//           return Text('Document does not exist');
//         }
//         //nickname 데이터 가져오기
//         var nickname = snapshot.data!['nickname'];
//
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData && snapshot.data!.exists) {
//             return animatedScaleWidget(
//               SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(
//                   parent: BouncingScrollPhysics(),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '${nickname}님! \n환영합니다 :)',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 26.0,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(4),
//                             child: Stack(
//                               children: <Widget>[
//                                 Positioned.fill(
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: <Color>[
//                                           Color(0xFF0D47A1),
//                                           Color(0xFF1976D2),
//                                           Color(0xFF42A5F5),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 TextButton(
//                                   style: TextButton.styleFrom(
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.all(16.0),
//                                     textStyle: const TextStyle(fontSize: 20),
//                                   ),
//                                   onPressed: signUserOut,
//                                   child: const Text('Log Out'),
//
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 5,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.grey.withOpacity(0.20),
//                             Colors.grey.withOpacity(0.1),
//                             Colors.white,
//                           ],
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                         ),
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: ExtraInfoItem.items.map((item) {
//                         Widget rowItem = TextButton(
//                           onPressed: () => item.onTap(),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                             child: SizedBox(
//                               height: 35,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     item.label,
//                                     style: const TextStyle(fontSize: 16.0),
//                                   ),
//                                   item.icon,
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                         if (ExtraInfoItem.items.indexOf(item) != ExtraInfoItem.items.length - 1) {
//                           return Column(
//                             children: [
//                               rowItem,
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 3.0),
//                                 child: Container(
//                                   height: 1,
//                                   color: Colors.grey.withOpacity(0.5),
//                                 ),
//                               )
//                             ],
//                           );
//                         }
//                         return rowItem;
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return Center(
//               child: Text('Error fetching storeName'),
//             );
//           }
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//     // return animatedScaleWidget(SingleChildScrollView(
//     //     physics: const AlwaysScrollableScrollPhysics(
//     //       parent: BouncingScrollPhysics(),
//     //     ),
//     //     child: Column(
//     //       crossAxisAlignment: CrossAxisAlignment.stretch,
//     //       children: [
//     //         Padding(
//     //           padding:
//     //           const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
//     //           child: Column(
//     //             crossAxisAlignment: CrossAxisAlignment.start,
//     //             children: [
//     //               Text(
//     //                 user.email! + "님! \n환영합니다 :)",
//     //                 style: TextStyle(
//     //                     fontWeight: FontWeight.bold,
//     //                     fontSize: 26.0,
//     //                     color: Colors.black),
//     //               ),
//     //               const SizedBox(
//     //                 height: 10,),
//     //               ClipRRect(
//     //                 borderRadius: BorderRadius.circular(4),
//     //                 child: Stack(
//     //                   children: <Widget>[
//     //                     Positioned.fill(
//     //                       child: Container(
//     //                         decoration: const BoxDecoration(
//     //                           gradient: LinearGradient(
//     //                             colors: <Color>[
//     //                               Color(0xFF0D47A1),
//     //                               Color(0xFF1976D2),
//     //                               Color(0xFF42A5F5),
//     //                             ],
//     //                           ),
//     //                         ),
//     //                       ),
//     //                     ),
//     //                     TextButton(
//     //                       style: TextButton.styleFrom(
//     //                         foregroundColor: Colors.white,
//     //                         padding: const EdgeInsets.all(16.0),
//     //                         textStyle: const TextStyle(fontSize: 20),
//     //                       ),
//     //                       onPressed: signUserOut,
//     //                       child: const Text('Log Out'),
//     //                     ),
//     //                   ],
//     //                 ),
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //         Container(
//     //           height: 5,
//     //           decoration: BoxDecoration(
//     //             gradient: LinearGradient(
//     //               colors: [
//     //                 Colors.grey.withOpacity(0.20),
//     //                 Colors.grey.withOpacity(0.1),
//     //                 Colors.white,
//     //               ],
//     //               begin: Alignment.topCenter,
//     //               end: Alignment.bottomCenter,
//     //             ),
//     //           ),
//     //         ),
//     //         Column(
//     //           crossAxisAlignment: CrossAxisAlignment.start,
//     //           children: ExtraInfoItem.items.map((item) {
//     //             Widget rowItem = TextButton(
//     //               onPressed: () => item.onTap(),
//     //               child: Padding(
//     //                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//     //                 child: SizedBox(
//     //                   height: 35,
//     //                   child: Row(
//     //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                     crossAxisAlignment: CrossAxisAlignment.center,
//     //                     children: [
//     //                       Text(
//     //                         item.label,
//     //                         style: const TextStyle(fontSize: 16.0),
//     //                       ),
//     //                       item.icon,
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ),
//     //             );
//     //             if (ExtraInfoItem.items.indexOf(item) !=
//     //                 ExtraInfoItem.items.length - 1) {
//     //               return Column(
//     //                 children: [
//     //                   rowItem,
//     //                   Padding(
//     //                     padding: const EdgeInsets.symmetric(vertical: 3.0),
//     //                     child: Container(
//     //                       height: 1,
//     //                       color: Colors.grey.withOpacity(0.5),
//     //                     ),
//     //                   )
//     //                 ],
//     //               );
//     //             }
//     //             return rowItem;
//     //           }).toList(),
//     //         ),
//     //       ],
//     //     ),
//     //   ),);
//   }
// }
