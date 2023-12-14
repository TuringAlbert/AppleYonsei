import 'dart:ui' as ui;
import 'dart:html';

import 'package:flutter/material.dart';

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
        title: Text('네이버 지도 API'),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          // 등록된 IFrameElement Widget들 중
          //'naver-map'라는 이름을 가진 개체를 Widget으로 임베딩
          child: HtmlElementView(viewType: 'naver-map'),
        ),
      ),
    );
  }
}