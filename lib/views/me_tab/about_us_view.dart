import 'package:flutter/material.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_corlor.dart';

import '../../common/common_image.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'About Us',
      appBarColor: HexColor('#15173B'),
      isDarkStatusBar: false,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Expanded(child: CommonImage(src: 'asset/images/about_us_bg_img.png')),
            Container(
              padding: const EdgeInsets.only(top: 60, bottom: 10),
              child: const Text('Version 1.0.0', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
