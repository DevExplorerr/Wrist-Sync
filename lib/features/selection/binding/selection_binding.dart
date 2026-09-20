import 'package:get/get.dart';
import 'package:wrist_sync/features/selection/controller/selection_controller.dart';

class SelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectionController>(() => SelectionController());
  }
}
