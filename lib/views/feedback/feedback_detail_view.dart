import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/models/feedback_model.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/widget/image_grid_view.dart';

class FeedbackDetailView extends StatelessWidget {
  const FeedbackDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    FeedbackModel feedback = Get.arguments;
    List<String> imgs = jsonDecode(feedback.feedBackImg ?? '[]').cast<String>();
    return CommonView(
      title: 'Detail',
      appBarColor: HexColor('#15173B'),
      isDarkStatusBar: false,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (feedback.feedBackType == '1')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      constraints: const BoxConstraints(minHeight: 130),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Text(feedback.replyContent ?? '', maxLines: null, style: TextStyle(color: HexColor('#15173B'), fontSize: 14)),
                    ),
                    Container(padding: const EdgeInsets.only(bottom: 50), child: Text(feedback.replyTime ?? '', style: TextStyle(color: HexColor('#D0D0D0'), fontSize: 14))),
                  ],
                ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(feedback.productName, style: TextStyle(color: HexColor('#333333'), fontSize: 20, fontWeight: FontWeight.w600)),
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    Text('Order Number : ${feedback.loanOrderNo}', style: TextStyle(color: HexColor('#15173B'), fontSize: 16)),
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    Text(feedback.feedBackType, style: TextStyle(color: HexColor('#E09754'), fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Text(feedback.feedBackContent ?? '', maxLines: null, style: TextStyle(color: HexColor('#15173B'), fontSize: 14)),
              ),
              if (imgs.isNotEmpty)
                Column(
                  children: <Widget>[
                    Text('Uploaded pictures for your problem', textAlign: TextAlign.center, style: TextStyle(color: HexColor('#333333'), fontSize: 16, fontWeight: FontWeight.w600)),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    ImageGridView(images: imgs, isUpload: false)
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
