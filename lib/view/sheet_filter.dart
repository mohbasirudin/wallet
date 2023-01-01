import 'package:flutter/cupertino.dart';
import 'package:walletin/base/const.dart';
import 'package:walletin/widget/text.dart';

class SheetFilter extends StatelessWidget {
  const SheetFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      itemExtent: 32.0,
      children: List.generate(
        ConstString.month.length,
        (index) {
          return CustomText(
            text: ConstString.month[index],
          );
        },
      ),
      onSelectedItemChanged: (value) {
        print("value=> $value");
      },
    );
  }
}
