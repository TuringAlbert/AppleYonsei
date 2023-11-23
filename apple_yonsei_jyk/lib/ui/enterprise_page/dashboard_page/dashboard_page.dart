import 'package:flutter/material.dart';
import 'package:AppleYonsei/ui/enterprise_page/common/animated_scale_screen_widget.dart';
import 'package:AppleYonsei/ui/enterprise_page/profile_page/login_overlay_widget.dart';
import 'package:flutter/cupertino.dart';

class DashboardPage extends StatefulWidget {
  final bool isShrink;
  const DashboardPage({Key? key, required this.isShrink}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends AnimatedScaleScreenWidget<DashboardPage> {
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
                    "Bobple 사장님 전용",
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
                  const Text(
                    "안녕하세요 밥플 사장님 계정에 오신 것을 환영합니다!",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "TEST.",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
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

//####

// import 'package:flutter/material.dart';


final List<Map<String, String>> orderHistory = [
  {
    'date': '11월 4일 (근) 18:30',
    'amount': "10명 팀",
    'info': "장우영, 010-9024-6582",
  },
  {
    'date': '11월 4일 (근) 18:30',
    'amount': "10명 팀",
    'info': "장우영, 010-9024-6582",
  },
  {
    'date': '11월 4일 (근) 18:30',
    'amount': "10명 팀",
    'info': "장우영, 010-9024-6582",
  },
];

final List<Map<String, String>> teamList = [
  {
    'name': 'sungjun',
    'teamNo': "10",
    'teamHr': "7",
    'image':
    "data:image/jpeg;base64,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",
  },
  {
    'name': 'sungjun',
    'teamNo': "10",
    'teamHr': "7",
    'image':
    "data:image/jpeg;base64,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",
  },
  {
    'name': 'sungjun',
    'teamNo': "10",
    'teamHr': "7",
    'image':
    "data:image/jpeg;base64,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",
  },
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  final user = "User";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enterprise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: '안녕하세요, ${user}'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final int bColor = 0xffeeeeee;
  final double bRad = 35.0;
  final int feedNum = 3;
  final int groupValue = 0;

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
            title: Text(title),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///// INCOMING TEAM //////
            Stack(alignment: AlignmentDirectional.topStart, children: [
              Container(
                  height: 60,
                  // width: screenWidth,
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                    color: Color(bColor),
                    borderRadius: BorderRadius.circular(bRad),
                  ),
                  child: Column(
                    children: [
                      Text('${teamList[0]['name']!}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("${teamList[0]['teamNo']!}명"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("${teamList[0]['teamHr']!}시"),
                          )
                        ],
                      )
                    ],
                  )),
              Container(
                alignment: Alignment(-0.92, 2),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 23,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(teamList[0]['image']!),
                  ),
                ),
              ),
            ]),

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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: CupertinoSlidingSegmentedControl<int>(
                          thumbColor: Colors.blue,
                          groupValue: groupValue,
                          children: {
                            0: Text("No"),
                            1: Text("Yes"),
                          },
                          onValueChanged: (int? newValue) {
                            if (newValue != null) {
                              // final snackBar = SnackBar(
                              //   content: Row(
                              //     children: [
                              //       Expanded(
                              //         child:
                              //             Text('Value changed to: $newValue'),
                              //       ),
                              //       // ProgressIndicatorExample()
                              //     ],
                              //   ),
                              //   action: SnackBarAction(
                              //     label: 'Action',
                              //     onPressed: () {
                              //       // Code to execute.
                              //     },
                              //   ),
                              // );

                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(snackBar);

                              // // Delay dismissal of the SnackBar for at least 1 second
                              // Future.delayed(Duration(seconds: 5), () {
                              //   ScaffoldMessenger.of(context)
                              //       .removeCurrentSnackBar();
                              // });
                              showCustomDialog(context);
                            }
                          },
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
                child: Text("이전 예약"),
              ),
            ),

            /////// 예약확정 Order History //////////
            Expanded(
              child: ListView.builder(
                itemCount: feedNum,
                itemBuilder: (context, index) => ListTile(
                  subtitle: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        width: 800,
                        decoration: BoxDecoration(
                          color: Color(bColor),
                          borderRadius: BorderRadius.circular(bRad),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.calendar_month),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(orderHistory[index]['date']!),
                                Text(orderHistory[index]['amount']!),
                                Text(orderHistory[index]['info']!),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                child: Text("예약확정"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///// DIALOG POPUP /////

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext mainBuildContext) {
        return FutureBuilder(
          future: simulateTask(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Task completed, close the original page's navigator stack
              Navigator.of(mainBuildContext).pop();
            }

            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      DecreasingLinearProgressIndicator(duration: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text('${teamList[0]['teamNo']!}명')),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text('${teamList[0]['teamHr']!}시'))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    // Navigator.of(context).pop();
                  },
                  child: Text('수락'),
                ),
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> simulateTask() async {
    // Simulate a task taking place
    await Future.delayed(Duration(seconds: 5));
  }
}

///// PROGRESS BAR /////

class DecreasingLinearProgressIndicator extends StatelessWidget {
  final double duration;

  const DecreasingLinearProgressIndicator({required this.duration});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: Duration(seconds: duration.toInt()),
      builder: (context, value, child) {
        return LinearProgressIndicator(
          borderRadius: BorderRadius.circular(30),
          value: value,
          minHeight: 20,
          backgroundColor: Color(0xffe0e0e1),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        );
      },
    );
  }
}