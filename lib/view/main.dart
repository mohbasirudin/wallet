import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletin/base/colors.dart';
import 'package:walletin/base/const.dart';
import 'package:walletin/base/func.dart';
import 'package:walletin/database/wallet.dart';
import 'package:walletin/routes/controller/con_main.dart';
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
          controller.showDialogChange(
            context: context,
            title: ConstString.add,
            type: ConstString.typeAdd,
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
                Obx(
                  () {
                    return CustomText(
                      text: BaseFunc.rupiah(
                        money: controller.amount.value,
                      ),
                      // fontColor: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    );
                  },
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
            child: Obx(
              () {
                if (controller.data.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "Empty",
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      return _item(
                        context: context,
                        index: index,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({
    required BuildContext context,
    required int index,
  }) {
    ModelWallet data = controller.data[index];
    bool selected = index % 2 == 1;
    bool isIn = data.type == ConstString.amountIn;
    return Material(
      color: selected ? Colors.white : Colors.grey.shade50,
      child: InkWell(
        onTap: () {
          controller.showDialogChange(
            context: context,
            title: ConstString.edit,
            type: ConstString.typeEdit,
            oldData: data,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: ConstDouble.padding,
            horizontal: ConstDouble.padding + 4,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: CustomText(
                  text: data.note.toCapitalized(),
                  fontWeight: FontWeight.w300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: ConstDouble.padding,
                ),
                child: SizedBox(
                  width: 104,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        text: "${isIn ? "+" : "-"}"
                            "${BaseFunc.rupiah(money: double.parse(data.amount))}",
                        fontWeight: FontWeight.w300,
                        fontColor: isIn ? BaseColors.input : BaseColors.output,
                      ),
                      CustomText(
                        text: BaseFunc.timeFormat(
                          date: data.createdAt,
                        ),
                        fontWeight: FontWeight.w300,
                        fontColor: Colors.blueGrey.shade300,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.delete(
                    context: context,
                    model: data,
                    index: index,
                  );
                },
                child: Icon(
                  Icons.close,
                  color: BaseColors.icon,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
