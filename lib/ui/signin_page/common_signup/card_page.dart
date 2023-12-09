import 'package:AppleYonsei/ui/signin_page/model/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../auth_page.dart';

class CardPage extends StatefulWidget {
  CardPage({Key? key}) : super(key: key);



  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('카드 등록'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //여기에 이제 뒤로가기 버튼 눌렀을 때 수행할 동작 추가
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardRegister(),
            SizedBox(height: 5),
            TextBox(),
            SizedBox(height: 20),
            Center(
                child: Text('')
              //여기는 뒤로가기 버튼 눌렀을 때 돌아가는 페이지 적는 곳, 근데 필요는 없을 듯 화면 밑에 그냥 보여주는거라
            )
          ],
        ),
      // ),
    );
  }
}

class CardRegister extends StatefulWidget {
  const CardRegister({Key? key}) : super(key: key);

  @override
  State<CardRegister> createState() => _CardRegisterState();
}

List<String> options = ['개인카드(개인법인카드)', '법인카드'];

class _CardRegisterState extends State<CardRegister> {
  String currentOption = options[0];
  final firestore = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool cardRegister = true;

  void CardRegisterCheckUp() async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    //check if password is confirmed
      await firestore.collection('users').doc(userCredential.user!.uid).update({
        'cardRegister' : true,
      });
      print("User registered succesfully!");

    }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile(
          title: const Text('개인카드(개인법인카드)'),
          value: options[0],
          groupValue: currentOption,
          onChanged: (value) {
            setState(() {
              currentOption = value.toString();
            });
          },
        ),
        RadioListTile(
          title: const Text('법인카드'),
          value: options[1],
          groupValue: currentOption,
          onChanged: (value) {
            setState(() {
              currentOption = value.toString();
            });
          },
        ),
      ],
    );
  }
}

class TextBox extends StatefulWidget {
  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  final firestore = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void CardRegisterCheckUp() async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    //check if password is confirmed
    await firestore.collection('users').doc(userCredential.user!.uid).update({
      'cardRegister' : true,
    });
    print("User registered succesfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                labelText: '카드번호(xxxx-xxxx-xxxx-xxxx)'
            ),
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
            ],
            maxLength: 19,
          ),
          SizedBox(height: 10), // Add some spacing between the text fields
          TextField(
            decoration: InputDecoration(
                labelText: '유효기간(MM/YY)'
            ),
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
            ],
            maxLength: 5,
          ),
          SizedBox(height: 10), // Add some spacing between the text fields
          TextField(
            decoration: InputDecoration(
                labelText: '비밀번호(앞 두자리)'
            ),
            keyboardType: TextInputType.text,
            obscureText: true,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            maxLength: 2,
          ),
          SizedBox(height: 10), // Add some spacing between the text fields
          TextField(
            decoration: InputDecoration(
                labelText: '생년월일(YYMMDD)'
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            maxLength: 6,
          ),
          SizedBox(height: 100),
          // MyButton(
          //     onTap: CardRegisterCheckUp(),
          //     text: "저장하기 real"),
          ElevatedButton(
              onPressed: () {
                CardRegisterCheckUp();
                print("TESTS*********");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage(),
                  ),
                );
          },
              child: Text("저장하기"),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(300,50)),
              ))
        ],
      ),
    );
  }
}