import 'package:flutter/cupertino.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/util/colors_util.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/views/loan_tab/index.dart';
import 'package:rupee_day/views/me_tab/index.dart';
import 'package:rupee_day/views/order_tab/index.dart';

List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(
    icon: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 5.0)),
        const CommonImage(
          src: 'asset/icons/tab_loan_normal.png',
          height: 24.0,
        ),
        Text(
          'Loan',
          style: TextStyle(color: ColorsUtil.hexColor(0xE09754, alpha: 0.4), fontSize: 14.0),
        )
      ],
    ),
    activeIcon: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 5.0)),
        const CommonImage(
          src: 'asset/icons/tab_loan_selected.png',
          height: 24.0,
        ),
        Text(
          'Loan',
          style: TextStyle(fontSize: 14.0, color: HexColor('#E09754')),
        )
      ],
    ),
  ),
  BottomNavigationBarItem(
    icon: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 5.0)),
        const CommonImage(
          src: 'asset/icons/tab_order_normal.png',
          height: 24.0,
        ),
        Text(
          'My Order',
          style: TextStyle(
            color: ColorsUtil.hexColor(0xE09754, alpha: 0.4),
            fontSize: 14.0,
          ),
        )
      ],
    ),
    activeIcon: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 5.0)),
        const CommonImage(
          src: 'asset/icons/tab_order_selected.png',
          height: 24.0,
        ),
        Text(
          'My Order',
          style: TextStyle(fontSize: 14.0, color: HexColor('#E09754')),
        )
      ],
    ),
  ),
  BottomNavigationBarItem(
    icon: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 5.0)),
        const CommonImage(
          src: 'asset/icons/tab_me_normal.png',
          height: 24.0,
        ),
        Text(
          'Me',
          style: TextStyle(color: ColorsUtil.hexColor(0xE09754, alpha: 0.4), fontSize: 14.0),
        )
      ],
    ),
    activeIcon: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 5.0)),
        const CommonImage(
          src: 'asset/icons/tab_me_selected.png',
          height: 24.0,
        ),
        Text(
          'Me',
          style: TextStyle(
            fontSize: 14.0,
            color: HexColor('#E09754'),
          ),
        )
      ],
    ),
  ),
];

List<Widget> tabViews = [const LoanTab(), OrderTab(), const MeTab()];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: items,
        height: 50.0,
        onTap: (index) async {
          // if (index == 1 && !(await Global.isLogin)) {
          //   return Get.toNamed(AppRoutes.Login);
          // }
          debugPrint('DEBUG: 当前点击的索引是$index');
        },
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (context) => tabViews[index],
      ),
    );
  }
}
