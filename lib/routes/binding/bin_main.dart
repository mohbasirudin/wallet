import 'package:get/get.dart';
import 'package:walletin/routes/controller/con_main.dart';

class BinMain extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(
      ConMain(),
    );
  }
}
