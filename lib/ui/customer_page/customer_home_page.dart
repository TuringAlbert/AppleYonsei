import 'package:AppleYonsei/ui/customer_page/reservation_waiting_page/reservation_waiting_page.dart';
import 'package:flutter/material.dart';

import 'package:after_layout/after_layout.dart';
import 'package:AppleYonsei/ui/customer_page/bottom_bar/custom_bottom_bar.dart';
import 'package:AppleYonsei/ui/customer_page/explore_page/explore_page.dart';
import 'package:AppleYonsei/ui/customer_page/customer_profile_page/customer_profile_page.dart';
import 'package:AppleYonsei/ui/customer_page/group_reservation_page/group_reservation_page.dart';
import 'package:AppleYonsei/ui/customer_page/wishlist_page/wishlist_page.dart';

class CustomerMyHomePage extends StatefulWidget {
  const CustomerMyHomePage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<CustomerMyHomePage> createState() => _CustomerMyHomePageState();
}

class _CustomerMyHomePageState extends State<CustomerMyHomePage> with AfterLayoutMixin {
  late int _bottomBarIndex;
  bool _isLoading = true;
  final Size _loadingIconSize = const Size(100, 100);

  @override
  void initState() {
    super.initState();
    _bottomBarIndex = widget.index;
  }

  Widget bodyWidget() {
    if (_isLoading) {
      return Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 65,
            left: MediaQuery.of(context).size.width / 2 -
                _loadingIconSize.width / 2,
            child: SizedBox(
              height: _loadingIconSize.height,
              width: _loadingIconSize.width,
              child: const Image(
                image: AssetImage(
                  'assets/icon/airbnb_icon.png',
                ),
                color: Colors.grey,
              ),
            ),
          ),
        ],
      );
    }
    switch (_bottomBarIndex) {
      case 0:
        return const ReservationWaitingPage();
      // case 1:
      //   return const WishlistPage(
      //     isShrink: false,
      //   );
      case 2:
        return const CustomerProfilePage(
          isShrink: false,
        );
      case 1:
      default:
        return const GroupReservationPage(
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: bodyWidget(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 65,
                )
              : SizedBox(
                  height: 65,
                  child: CustomBottomBar(
                    index: _bottomBarIndex,
                    selectedIndex: (index) {
                      setState(
                        () {
                          _bottomBarIndex = index;
                        },
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    Future.delayed(
      const Duration(seconds: 1),
      () => {
        setState(() {
          _isLoading = false;
        })
      },
    );
  }
}
