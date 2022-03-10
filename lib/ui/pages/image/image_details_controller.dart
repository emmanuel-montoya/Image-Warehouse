import 'package:get/get.dart';
import 'package:image_warehouse/domain/model/stored_image.dart';
import 'package:image_warehouse/utils/image_warehouse_utilities.dart';

class ImageDetailsController extends GetxController {

  var logger = ImageWarehouseUtilities.logger;
  StoredImage storedImage = StoredImage();

  @override
  void onInit() async {
    super.onInit();
    logger.i("ImageWarehouse Home Controller Init");

    try {

      if(Get.arguments != null && Get.arguments.isNotEmpty) {
        storedImage = Get.arguments[0];
      }

    } catch (e) {
      logger.e(e.toString());
    }

  }


}

