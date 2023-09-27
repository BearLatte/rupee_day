import 'package:flutter/material.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/models/product_model.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/util/random_util.dart';

class ProductListItemView extends StatelessWidget {
  final ProductModel product;
  final Function()? onTap;
  const ProductListItemView({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.productName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#242431'),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 20.0)),
                Container(
                  height: 24.0,
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  decoration: BoxDecoration(
                    color: HexColor('#EDE6D9'),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      const CommonImage(src: 'asset/icons/score_star.png'),
                      const Padding(padding: EdgeInsets.only(right: 5.0)),
                      Text(
                        RandomUtil.randomScore(),
                        style: TextStyle(fontSize: 14.0, color: HexColor('#E09754')),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16.0)),
            Divider(
              color: HexColor('#ECECF5'),
              height: 1.0,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16.0)),
            CommonTextButton(
              'Loan now',
              width: 188.0,
              height: 50.0,
              borderRadius: 25.0,
              onTap: onTap,
            )
          ],
        ),
      ),
    );
  }
}
