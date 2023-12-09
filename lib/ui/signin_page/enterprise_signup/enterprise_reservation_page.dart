import 'package:AppleYonsei/ui/enterprise_page/enterprise_home_page.dart';
import 'package:flutter/material.dart';
import 'package:AppleYonsei/ui/enterprise_page/common/animated_scale_screen_widget.dart';
import 'package:AppleYonsei/ui/enterprise_page/enterprise_profile_page/enterprise_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth_page.dart';

const List<String> businessCodeList = ['치킨', '피자', '햄버거', '삼겹살', '국밥', '면류'];
const List<String> locationCodeList = ['신촌', '안암'];

class EnterpriseReservationPage extends StatefulWidget {
  final bool isShrink;
  const EnterpriseReservationPage({Key? key, required this.isShrink}) : super(key: key);

  @override
  _EnterpriseReservationPageState createState() => _EnterpriseReservationPageState();
}

class _EnterpriseReservationPageState extends AnimatedScaleScreenWidget<EnterpriseReservationPage> {
  String selectedLocation = '신촌';
  String selectedBusinessCode = '치킨';

  bool _showOverlay = false;
  late AnimationController? overlayController;
  late Animation<double>? overlayAnimation;
  OverlayEntry? _overlayEntry;

  // final TextEditingController businessCodeController = TextEditingController();
  // final TextEditingController locationCodeController = TextEditingController();
  final TextEditingController storeAddressController = TextEditingController();
  final TextEditingController storeInfoController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeNumController = TextEditingController();

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

  Future<String?> getUserId() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.uid;
      }
    } catch (e) {
      print('Error getting user ID: $e');
    }
    return null;
  }

  void registerStoreInfo() async {
    try {
      String? userId = await getUserId();
      print(userId);
      if (userId != null) {
        print("null");
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'businessCode': selectedBusinessCode,
          'locationCode': selectedLocation,
          'storeAddress': storeAddressController.text,
          'store_info': storeInfoController.text,
          'storeName': storeNameController.text,
          'store_num': storeNumController.text,
          'enterpriseDataRegister' : true,
        });

        print('가게 정보가 성공적으로 업데이트되었습니다!');
      } else {
        print('사용자 ID를 가져오지 못했습니다.');
      }
    } catch (e) {
      print('가게 정보 업데이트 중 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return animatedScaleWidget(
      SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "가게 정보 입력",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      color: Colors.black87,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Container(
                      height: 1.5,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // 가게 정보 입력 필드 추가
                  Container(
                    width: 200,
                    child: DropdownButtonExample(
                      list: businessCodeList,
                      title: '업종',
                      onChanged: (String value) {
                        setState(() {
                          selectedBusinessCode = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // 가게 정보 입력 필드 추가
                  Container(
                    width: 200,
                    child: DropdownButtonExample(
                      list: locationCodeList,
                      title: '지역',
                      onChanged: (String value) {
                        setState(() {
                          selectedLocation = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: storeAddressController,
                    decoration: InputDecoration(labelText: '가게 주소'),
                    maxLines: 2,
                  ),
                  TextField(
                    controller: storeInfoController,
                    decoration: InputDecoration(labelText: '가게 정보'),
                    maxLines: 2,
                  ),
                  TextField(
                    controller: storeNameController,
                    decoration: InputDecoration(labelText: '가게 이름'),
                    maxLines: 2,
                  ),
                  TextField(
                    controller: storeNumController,
                    decoration: InputDecoration(labelText: '전화번호'),
                    maxLines: 2,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){
                      registerStoreInfo();
                      print("TESTS*********");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AuthPage(),
                        ),
                      );

                    },
                    child: Text('가게 정보 등록'),
                  ),
                ],
              ),
            ),
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