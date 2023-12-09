import 'package:flutter/material.dart';
import 'package:AppleYonsei/ui/customer_page/common/animated_scale_screen_widget.dart';
import 'package:AppleYonsei/ui/enterprise_page/enterprise_profile_page/login_overlay_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/reservation_completed_page.dart';

const List<String> locationlist = ['신촌', '안암'];
const List<String> personlist = ['4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14','15','16','17'];
const List<String> timelist = ['16:00', '16:30', '17:00', '17:30', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', '22:00'];
const List<String> pmenulist = ['치킨', '피자', '햄버거', '삼겹살', '국밥', '면류'];
const List<String> nmenulist = ['피자', '치킨', '햄버거', '삼겹살', '국밥', '면류'];

class GroupReservationPage extends StatefulWidget {
  const GroupReservationPage({Key? key}) : super(key: key);

  @override
  _GroupReservationPageState createState() => _GroupReservationPageState();
}

class _GroupReservationPageState extends AnimatedScaleScreenWidget<GroupReservationPage> {
  String selectedLocation = '신촌';
  String selectedPerson = '4';
  String selectedTime = '16:00';
  String selectedPreferredMenu = '치킨';
  String selectedNonPreferredMenu = '피자';
  bool pending_status = false;
  bool confirm_status = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;


  bool _showOverlay = false;
  late AnimationController? overlayController;
  late Animation<double>? overlayAnimation;
  OverlayEntry? _overlayEntry;
  late String nickname;
  late String noShow;

  //dropdownbutton 예약
  void ReservationRegister() async{

    try {
      final nicknameSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (nicknameSnapshot.exists) {
        var data = nicknameSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          var nickname = data["nickname"];
          var noShow = data["noShow"];

          await FirebaseFirestore.instance.collection('reservation_waiting').doc().set({
            "user": user.email,
            "customer_uid": user.uid,
            "nickname": nickname,
            "location": selectedLocation,
            "person": selectedPerson,
            "time": selectedTime,
            "prefer": selectedPreferredMenu,
            "unprefer": selectedNonPreferredMenu,
            "pending_status": pending_status,
            "confirm_status": confirm_status,
            "noShow": noShow,
          });

          print('예약이 성공적으로 추가되었습니다!');
        } else {
          print("Data is null");
        }
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Reservation process error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('10초 단체 예약하기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: DropdownButtonExample(
                list: locationlist,
                title: '위치',
                onChanged : (String value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: DropdownButtonExample(
                list: personlist,
                title: '인원',
                onChanged: (String value) {
                  setState(() {
                    selectedPerson = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: DropdownButtonExample(
                list: timelist,
                title: '당일 예약시간',
                onChanged: (String value) {
                  setState(() {
                    selectedTime = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: DropdownButtonExample(
                list: pmenulist,
                title: '선호 메뉴',
                onChanged: (String value) {
                  setState(() {
                    selectedPreferredMenu = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: DropdownButtonExample(
                list: nmenulist,
                title: '비선호 메뉴',
                onChanged: (String value) {
                  setState(() {
                    selectedNonPreferredMenu = value;
                  });
                },
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: () {

              // Access the selected values here
              print(user.email);
              print('Selected Location: $selectedLocation');
              print('Selected Person: $selectedPerson');
              print('Selected Time: $selectedTime');
              print('Selected Preferred Menu: $selectedPreferredMenu');
              print('Selected Non-Preferred Menu: $selectedNonPreferredMenu');
              print('Pendign status : $pending_status');
              print('reservation status : $confirm_status');
              // You can use these values for further processing or send them to a function.
              ReservationRegister();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReservationCompletedPage(),
                ),
              );
            },
                child: Text("예약하기"),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(300, 50)),
                ))
          ],
        ),
      ),
    );
  }
}


class DropdownButtonExample extends StatefulWidget {
  final List<String> list;
  final String title;
  final ValueChanged<String> onChanged;

  const DropdownButtonExample({
    Key? key,
    required this.list,
    required this.title,
    required this.onChanged,
  })
      : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = '';


  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text(widget.title)),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          isExpanded: true,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            // width: 100,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
            // Call the onChanged callback to pass the selected value to the parent widget
            widget.onChanged(value!);
          },
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}