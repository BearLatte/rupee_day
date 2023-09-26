import 'package:flutter/material.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/util/hex_corlor.dart';

enum ItemType { normal, calendar, more }

class FormItemWidget extends StatelessWidget {
  final String itemName;
  final TextEditingController inputController;
  final String placeholder;
  final ItemType type;
  final bool multiLines;
  final Function()? onTap;
  final TextInputType? keyboardType;

  const FormItemWidget({
    super.key,
    this.onTap,
    this.multiLines = false,
    this.type = ItemType.normal,
    this.keyboardType,
    required this.itemName,
    required this.inputController,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      padding: EdgeInsets.only(
        left: 15.0,
        right: type == ItemType.normal ? 15.0 : 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Text(
            itemName,
            style: TextStyle(color: HexColor('#333333'), fontSize: 14.0),
          ),
          const Padding(padding: EdgeInsets.only(right: 10.0)),
          Expanded(
            child: TextField(
              onTap: onTap,
              controller: inputController,
              textAlign: TextAlign.right,
              keyboardType: keyboardType,
              style: TextStyle(color: HexColor('#15173B'), fontSize: 16.0),
              readOnly: type != ItemType.normal,
              maxLines: multiLines ? null : 1,
              decoration: InputDecoration(
                hintText: placeholder,
                border: InputBorder.none,
                hintStyle: TextStyle(color: HexColor('#999999')),
              ),
            ),
          ),
          if (type == ItemType.calendar)
            IconButton(
              onPressed: onTap,
              icon: const CommonImage(src: 'asset/icons/calendar_icon.png'),
            ),
          if (type == ItemType.more)
            IconButton(
              onPressed: onTap,
              icon: const CommonImage(src: 'asset/icons/arrow_right_icon.png'),
            )
          // suffix ?? Container(),
        ],
      ),
    );
  }
}
