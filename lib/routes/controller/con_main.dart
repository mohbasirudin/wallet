import 'package:get/get.dart';
import 'package:walletin/view/dialog_change.dart';

class ConMain extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void showDialogChange({
    required String title,
    required String type,
  }) {
    Get.dialog(
      DialogChange(
        title: title,
        type: type,
        onResult: (type, result) {},
      ),
    );
  }
}
