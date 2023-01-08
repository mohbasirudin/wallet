import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletin/base/const.dart';
import 'package:walletin/base/func.dart';
import 'package:walletin/database/database.dart';
import 'package:walletin/database/wallet.dart';
import 'package:walletin/view/dialog_change.dart';
import 'package:walletin/widget/text.dart';

class ConMain extends GetxController {
  RxList<ModelWallet> data = <ModelWallet>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit

    fetch();
    super.onInit();
  }

  void fetch() async {
    try {
      await Db.read().then(
        (value) {
          if (value.isNotEmpty) {
            for (var i = 0; i < value.length; i++) {
              ModelWallet model = ModelWallet.fromMap(value[i]);
              data.add(model);
            }
          } else {
            data.value = [];
          }
        },
      );
    } catch (e) {}
  }

  void showDialogChange({
    required BuildContext context,
    ModelWallet? oldData,
    required String title,
    required String type,
  }) async {
    print("id=> ${BaseFunc.generateId()}");
    String result = await Get.dialog(
          DialogChange(
            title: title,
            type: type,
          ),
        ) ??
        "";
    print("result=> $result");
    if (result.isNotEmpty) {
      Uri uri = Uri.parse(result);
      String typeAmount = uri.queryParameters[ConstString.queryType] ?? "";
      String note = uri.queryParameters[ConstString.queryNote] ?? "";
      String amount = uri.queryParameters[ConstString.queryAmount] ?? "";
      int id = 0;
      String createdAt = "";
      String updatedAt = "";
      String month = "";
      String year = "";
      bool isAdd = type == ConstString.typeAdd;

      DateTime today = DateTime.now();
      print("isAdd=> $isAdd");
      if (isAdd) {
        id = int.parse(BaseFunc.generateId());
        createdAt = today.toString();
        updatedAt = today.toString();
        month = today.month.toString();
        year = today.year.toString();
      } else {
        id = oldData!.id;
        createdAt = oldData.createdAt;
        updatedAt = today.toString();
        month = oldData.month;
        year = oldData.year;
      }
      ModelWallet model = ModelWallet(
        id: id,
        note: note,
        createdAt: createdAt,
        updatedAt: updatedAt,
        type: typeAmount,
        amount: amount,
        month: month,
        year: year,
      );
      print("id=>$id");
      if (type == ConstString.typeAdd) {
        _add(context: context, model: model);
      } else {
        _edit(context: context, model: model);
      }
    }
  }

  void _add({
    required BuildContext context,
    required ModelWallet model,
  }) async {
    try {
      int result = await Db.create(data: model);
      if (result == model.id) {
        _snackbar(context: context, isFailed: false);
      } else {
        _snackbar(context: context);
      }
    } catch (e) {
      print("error add => $e");
      _snackbar(context: context);
    }
  }

  void _edit({
    required BuildContext context,
    required ModelWallet model,
  }) async {
    try {
      int result = await Db.update(
        data: model,
        id: model.id.toString(),
      );
      if (result == 1) {
        _snackbar(context: context, isFailed: false);
      } else {
        _snackbar(context: context);
      }
    } catch (e) {
      _snackbar(context: context);
    }
  }

  void _snackbar({
    required BuildContext context,
    // String? message,
    bool isFailed = true,
  }) {
    SnackBar snackBar = SnackBar(
      content: CustomText(
        text: isFailed ? "Failed" : "Success",
      ),
      backgroundColor: isFailed ? Colors.red : Colors.green,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }
}
