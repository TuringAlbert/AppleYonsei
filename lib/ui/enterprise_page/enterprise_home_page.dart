import 'package:AppleYonsei/ui/enterprise_page/dashboard_page/dashboard_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:AppleYonsei/ui/enterprise_page/explore_page/explore_page.dart';
import 'package:AppleYonsei/ui/enterprise_page/wishlist_page/wishlist_page.dart';
import 'package:AppleYonsei/ui/enterprise_page/inbox_page/inbox_page.dart';
import 'package:AppleYonsei/ui/enterprise_page/enterprise_profile_page/enterprise_profile_page.dart';
import 'package:AppleYonsei/ui/signin_page/enterprise_signup/enterprise_reservation_page.dart';
import 'package:AppleYonsei/ui/enterprise_page/bottom_bar/custom_bottom_bar.dart';

class EnterpriseMyHomePage extends StatefulWidget {
  const EnterpriseMyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EnterpriseMyHomePage> createState() => _EnterpriseMyHomePageState();
}

class _EnterpriseMyHomePageState extends State<EnterpriseMyHomePage> with AfterLayoutMixin {
  int _bottomBarIndex = 1;
  bool _isLoading = true;
  final Size _loadingIconSize = const Size(100, 100);

  @override
  void initState() {

    super.initState();
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
                    'assets/images/babple_logo.png',
                ),
              ),
            ),
          ),
        ],
      );
    }
    switch (_bottomBarIndex) {
      case 0:
        return const WishlistPage(isShrink: false);
      case 2:
        return EnterpriseProfilePage(
          isShrink: false,
        );
      case 1:
      default:
        return DashboardPage(title: " 밥플 예약");
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
