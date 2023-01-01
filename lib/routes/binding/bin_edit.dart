import 'package:get/get.dart';
import 'package:walletin/routes/controller/con_edit.dart';

class BinEdit extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ConEdit());
  }
}
