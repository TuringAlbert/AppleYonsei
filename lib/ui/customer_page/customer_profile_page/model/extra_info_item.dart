import 'package:flutter/material.dart';

class ExtraInfoItem {
  final String label;
  final Icon icon;
  final Function onTap;

  ExtraInfoItem._(this.label, this.icon, this.onTap);

  static final ExtraInfoItem _setting = ExtraInfoItem._(
    '마이 페이지',
    const Icon(
      Icons.account_circle_sharp,
    ),
        () {
      debugPrint("Route to Settings Page");
    },
  );
  static final ExtraInfoItem _help = ExtraInfoItem._(
    '카드 정보',
    const Icon(Icons.add_card_outlined),
        () {
      debugPrint("Route to Helping Page");
    },
  );
  static final ExtraInfoItem _host = ExtraInfoItem._(
    '고객센터 문의',
    const Icon(Icons.support_agent_rounded),
        () {
      debugPrint("Route to Hosting Page");
    },
  );

  static List<ExtraInfoItem> items = [
    _setting,
    _help,
    _host,
  ];
}
