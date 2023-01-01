import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:walletin/base/colors.dart';
import 'package:walletin/base/const.dart';
import 'package:walletin/widget/text.dart';

class DialogChange extends StatelessWidget {
  final String title;
  final Function(int type, String result) onResult;
  DialogChange({
    required this.title,
    required this.onResult,
    super.key,
  });

  _ConChange? controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(_ConChange());
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ConstDouble.radius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          ConstDouble.padding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: ConstDouble.padding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: ConstDouble.padding,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _textField(
                      con: controller!.conAmount,
                      hint: "0",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      padding: const EdgeInsets.only(
                        right: ConstDouble.padding,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 96,
                    child: _textField(
                      con: controller!.conType,
                      hint: controller!.types[1],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      readOnly: true,
                      enabled: false,
                      sufficIcon: GestureDetector(
                        onTap: () {
                          print("asd");
                        },
                        child: CustomPopupMenu(
                          controller: controller!.conMenu,
                          arrowColor: Colors.white,
                          barrierColor: Colors.black12,
                          horizontalMargin: Get.width / 8,
                          menuBuilder: () {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(
                                ConstDouble.radius,
                              ),
                              child: Container(
                                width: 80,
                                color: Colors.white,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1,
                                      height: 1,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    String type = controller!.types[index];
                                    return InkWell(
                                      onTap: () {
                                        if (type != controller!.conType.text) {
                                          controller!.conType.text = type;
                                          controller!.conMenu.hideMenu();
                                        }
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        child: Center(
                                          child: CustomText(text: type),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: controller!.types.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            );
                          },
                          pressType: PressType.singleClick,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: BaseColors.icon,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _textField(
              con: controller!.conNote,
              hint: "Note",
              padding: const EdgeInsets.only(
                bottom: ConstDouble.padding * 2,
              ),
            ),
            _button(),
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        ConstDouble.radius * 0.5,
      ),
      child: Material(
        color: BaseColors.primary,
        child: InkWell(
          onTap: () {},
          child: const SizedBox(
            width: double.infinity,
            height: 48,
            child: Center(
              child: CustomText(
                text: "Submit",
                fontColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController con,
    required String hint,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    EdgeInsets? padding,
    bool readOnly = false,
    bool enabled = true,
    Widget? sufficIcon,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextField(
        controller: con,
        cursorColor: BaseColors.primary,
        style: _textStyle(),
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: textInputAction ?? TextInputAction.done,
        readOnly: readOnly,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          isDense: true,
          hintText: hint,
          hintStyle: _textStyle(
            color: Colors.blueGrey.shade300,
          ),
          border: _border(),
          errorBorder: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(),
          disabledBorder: _border(),
          focusedErrorBorder: _border(),
          suffixIcon: sufficIcon,
        ),
      ),
    );
  }

  TextStyle _textStyle({Color? color}) {
    return TextStyle(
      color: color ?? Colors.black87,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
  }

  OutlineInputBorder _border() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
    );
  }
}

class _ConChange extends GetxController {
  TextEditingController conNote = TextEditingController();
  TextEditingController conAmount = TextEditingController();
  TextEditingController conType = TextEditingController();
  CustomPopupMenuController conMenu = CustomPopupMenuController();

  List<String> types = [
    "In",
    "Out",
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    conMenu.showMenu();

    conType.text = types[1];

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    conNote.dispose();
    conAmount.dispose();
    conType.dispose();
    conMenu.dispose();

    super.dispose();
  }
}
