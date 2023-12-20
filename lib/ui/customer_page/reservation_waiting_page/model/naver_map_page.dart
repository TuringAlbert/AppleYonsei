import 'dart:ui' as ui;
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapPage extends StatefulWidget {
  NaverMapPage({Key? key}) : super(key: key);

  @override
  State<NaverMapPage> createState() => _NaverMapPageState();
}

class _NaverMapPageState extends State<NaverMapPage> {
  @override
  void initState() {
    // assets/map.html에서 작성한 네이버 지도 API 호출 후
    // 응답받은 iframe을 IFrameElement라는 Flutter Widget으로 등록
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'naver-map',
          (int viewId) => IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src = 'assets/map.html'
        ..style.border = 'none',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가게 위치 정보'),
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 400,
              width: double.infinity,
              // 등록된 IFrameElement Widget들 중
              //'naver-map'라는 이름을 가진 개체를 Widget으로 임베딩
              child: HtmlElementView(viewType: 'naver-map'),
              // child: HtmlElementView(viewType: '<html>dfdfdfdffdfd</html>'.replace("37.56556", dfdf)),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "예약 확정!",
                        style: TextStyle(
                        fontSize: 20.0, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4,),
                  Center(
                    child: Text(
                      "식당명 : AAA 식당",
                        style: TextStyle(
                        fontSize: 13.0, // Adjust the font size as needed
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Center(
                    child: Image.asset('assets/images/Frame 3194.png'),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.white10,
                        width: 1.0
                      )
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Container(
                            child: Image.asset('assets/images/Frame 3179.png'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "오시는 길",
                              style: TextStyle(
                                fontSize: 15.0, // Adjust the font size as needed
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "서울특별시 서대문구 신촌동 131-54",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.white10,
                            width: 1.0
                        )
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Container(
                            child: Container(
                                width: 60,
                                height: 60,
                                child: Image.asset('assets/images/res.png')),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "캡스톤 식당",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "010-0000-0000",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            child: Image.asset('assets/images/Group 3157.png'),
                          ),
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "캡스톤 식당",
                        //       style: TextStyle(
                        //           fontSize: 15.0, // Adjust the font size as needed
                        //           fontWeight: FontWeight.bold
                        //       ),
                        //     ),
                        //     Text(
                        //       "010-0000-0000",
                        //       style: TextStyle(
                        //           fontSize: 12.0,
                        //           color: Colors.grey
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.all(16.0),
                        //   child: Container(
                        //     height: 60,
                        //     width: 60,
                        //     child: Image.asset('assets/images/Group 3157.png'),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ]
              ),
            ),
          )
          ]
      ),
    );
  }
}