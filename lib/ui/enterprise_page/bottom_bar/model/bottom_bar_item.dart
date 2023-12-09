import 'package:AppleYonsei/ui/enterprise_page/common/model/base_model.dart';

class BottomBarItem extends BaseModel {
  static String assertPath = 'assets/icon/';

  BottomBarItem._(String label, String assetImage)
      : super(label, assertPath + assetImage);
  static final BottomBarItem _wishlist = BottomBarItem._(
    '예약확정',
    'heart_icon.png',
  );
  static final BottomBarItem _home = BottomBarItem._(
    '홈',
    'airbnb_icon.png',
  );
  // static final BottomBarItem _reservationStatus = BottomBarItem._(
  //   '예약',
  //   'inbox_icon.png',
  // );
  static final BottomBarItem _profile = BottomBarItem._(
    '계정',
    'account_icon.png',
  );

  static List<BottomBarItem> items = [
    _wishlist,
    _home,
    // _reservationStatus,
    _profile
  ];
}
