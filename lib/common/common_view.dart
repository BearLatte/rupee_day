import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rupee_day/util/hex_color.dart';

class CommonView extends StatelessWidget {
  final String? title;
  final Color titleColor;
  final Color backColor;
  final bool isShowBackBtn;
  final Color appBarColor;
  final Widget child;
  final bool isDarkStatusBar;
  final bool isShowStep;
  final String totalStep;
  final String currentStep;
  final List<Widget>? actions;
  final PreferredSizeWidget? appBarBottom;
  final Function()? backAction;

  const CommonView(
      {super.key,
      this.title,
      this.titleColor = Colors.white,
      this.backColor = Colors.white,
      this.isShowBackBtn = true,
      this.appBarColor = Colors.transparent,
      required this.child,
      this.isDarkStatusBar = true,
      this.isShowStep = false,
      this.totalStep = '4',
      this.currentStep = '1',
      this.appBarBottom,
      this.backAction,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: isDarkStatusBar ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        backgroundColor: appBarColor,
        bottom: appBarBottom,
        elevation: 0,
        leading: isShowBackBtn
            ? SizedBox(
                width: 44.0,
                height: 44.0,
                child: IconButton(
                  color: backColor,
                  icon: const Icon(Icons.keyboard_arrow_left, size: 44.0),
                  onPressed: () => backAction == null ? Get.back() : backAction!(),
                ),
              )
            : null,
        actions: isShowStep
            ? [
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(currentStep, style: TextStyle(color: HexColor('#E09754'), fontSize: 20.0)),
                      Text('/$totalStep', style: TextStyle(color: HexColor('#F2F2F2'), fontSize: 12.0)),
                      const Padding(padding: EdgeInsets.only(right: 10.0))
                    ],
                  ),
                )
              ]
            : (actions ?? []),
        title: Text(
          title ?? '',
          style: TextStyle(
            color: titleColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: HexColor('#f2f2f2'),
        child: child,
      ),
    );
  }
}
