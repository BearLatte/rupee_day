import 'package:flutter/material.dart';
import 'package:rupee_day/Controllers/auth_third_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/util/hex_corlor.dart';

class ContactItemWidget extends StatelessWidget {
  final bool isPhoneEnable;
  final InputControllerModel controllerModel;
  final Function()? relationSelectionAction;
  final Function()? phoneSelectionAction;
  const ContactItemWidget({
    super.key,
    required this.isPhoneEnable,
    required this.controllerModel,
    this.relationSelectionAction,
    this.phoneSelectionAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: Column(
        children: [
          Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 14.0)),
                Text(
                  'Relation',
                  style: TextStyle(color: HexColor('#333333'), fontSize: 14.0),
                ),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.end,
                    controller: controllerModel.relationController,
                    onTap: relationSelectionAction,
                    decoration: InputDecoration(
                      hintText: 'Please select',
                      hintStyle: TextStyle(
                        color: HexColor('#999999'),
                        fontSize: 16.0,
                      ),
                      suffix: const SizedBox(width: 10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                InkWell(
                  onTap: relationSelectionAction,
                  child: const CommonImage(
                      src: 'asset/icons/arrow_right_icon.png'),
                )
              ],
            ),
          ),
          Container(
            height: 44,
            margin: const EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 14.0)),
                Expanded(
                  child: TextField(
                    style:
                        TextStyle(color: HexColor('#333333'), fontSize: 14.0),
                    controller: controllerModel.contactNameController,
                    readOnly: !isPhoneEnable,
                    onTap: phoneSelectionAction,
                    decoration: InputDecoration(
                      hintText: 'Contact Name',
                      hintStyle: TextStyle(
                        color: HexColor('#999999'),
                        fontSize: 14.0,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // const TextField(decoration: InputDecoration(hintText: 'Contact Name')),
                SizedBox(
                  width: 150,
                  child: TextField(
                    textAlign: TextAlign.end,
                    controller: controllerModel.phoneNumberController,
                    readOnly: !isPhoneEnable,
                    onTap: phoneSelectionAction,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Select a contact',
                      hintStyle: TextStyle(
                        color: HexColor('#999999'),
                        fontSize: 14.0,
                      ),
                      suffix: const SizedBox(width: 10.0),
                    ),
                  ),
                ),
                InkWell(
                  onTap: phoneSelectionAction,
                  child: const CommonImage(
                    src: 'asset/icons/contact_phone_icon.png',
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
