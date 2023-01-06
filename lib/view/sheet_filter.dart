import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walletin/base/const.dart';
import 'package:walletin/widget/text.dart';

class SheetFilter extends StatelessWidget {
  const SheetFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ConstDouble.radius,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CupertinoPicker(
              itemExtent: 28,
              children: List.generate(
                ConstString.month.length,
                (index) {
                  return SizedBox(
                    height: 32,
                    child: CustomText(
                      text: ConstString.month[index],
                    ),
                  );
                },
              ),
              onSelectedItemChanged: (value) {
                print("value=> $value");
              },
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 32.0,
              children: List.generate(
                ConstString.year.length,
                (index) {
                  return CustomText(
                    text: ConstString.year[index],
                  );
                },
              ),
              onSelectedItemChanged: (value) {
                print("value=> $value");
              },
            ),
          ),
        ],
      ),
    );
  }
}
