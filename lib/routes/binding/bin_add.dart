import 'package:get/get.dart';
import 'package:walletin/routes/controller/con_add.dart';

class BinAdd extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ConAdd());
  }
}
