import 'package:AppleYonsei/ui/customer_page/common/model/base_model.dart';

class BottomBarItem extends BaseModel {
  static String assertPath = 'assets/icon/';

  BottomBarItem._(String label, String assetImage)
      : super(label, assertPath + assetImage);

  static final BottomBarItem _reservationConfirm = BottomBarItem._(
    '확정내역',
    'search_btn.png',
  );
  // static final BottomBarItem _wishlist = BottomBarItem._(
  //   '예약test',
  //   'heart_icon.png',
  // );
  static final BottomBarItem _groupReservation = BottomBarItem._(
    '예약하기',
    'airbnb_icon.png',
  );
  // static final BottomBarItem _inbox = BottomBarItem._(
  //   '예약확정',
  //   'inbox_icon.png',
  // );
  static final BottomBarItem _account = BottomBarItem._(
    '계정',
    'account_icon.png',
  );

  static List<BottomBarItem> items = [
    _reservationConfirm,
    // _wishlist,
    _groupReservation,
    // _inbox,
    _account
  ];
}
