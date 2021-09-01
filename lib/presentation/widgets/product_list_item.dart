import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quicksell_android_task/utils/custom/custom_text_style.dart';

Widget productListTile({
  required double height,
  required double width,
  required String productName,
  required String productDesc,
  required String productPrice,
  required String productImg,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    height: height,
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                productImg,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  productName,
                  style: customTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  softWrap: false,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  productDesc,
                  style: customTextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          '$productPrice',
          style: customTextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
