import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:walletin/base/colors.dart';
import 'package:walletin/base/const.dart';
import 'package:walletin/base/func.dart';
import 'package:walletin/routes/controller/con_main.dart';
import 'package:walletin/routes/routes.dart';
import 'package:walletin/view/dialog_change.dart';
import 'package:walletin/widget/text.dart';
import 'package:walletin/helper/extensions.dart';

class PageMain extends GetView<ConMain> {
  const PageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const CustomText(
          text: ConstString.name,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _viewTop(),
          _viewBody(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            DialogChange(
              title: ConstString.add,
              onResult: (type, result) {},
            ),
          );
        },
        backgroundColor: BaseColors.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _viewTop() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ConstDouble.padding,
      ),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 120,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: BaseFunc.rupiah(
                    money: 6000000,
                  ),
                  // fontColor: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                const CustomText(
                  text: ConstString.totalBalance,
                  // fontColor: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _viewBody() {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: ConstDouble.padding + 4,
              right: ConstDouble.padding,
              top: ConstDouble.padding * 2,
              bottom: ConstDouble.padding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: ConstString.transaction,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                Row(
                  children: const [
                    CustomText(text: "Sort"),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return _item(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({required int index}) {
    bool selected = index % 2 == 1;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: ConstDouble.padding,
        horizontal: ConstDouble.padding + 4,
      ),
      color: selected ? Colors.white : Colors.grey.shade50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: CustomText(
              text: "asdhjs asjdasjd asdka sdahsdjas".toCapitalized(),
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            width: 104,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  text: "${selected ? "+" : "-"}"
                      "${BaseFunc.rupiah(money: 400000)}",
                  fontWeight: FontWeight.w300,
                  fontColor: selected ? BaseColors.input : BaseColors.output,
                ),
                CustomText(
                  text: "22-07-22",
                  fontWeight: FontWeight.w300,
                  fontColor: Colors.blueGrey.shade300,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
