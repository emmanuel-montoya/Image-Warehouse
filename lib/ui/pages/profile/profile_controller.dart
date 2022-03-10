import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/domain/model/warehouse_user.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_page_id_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_utilities.dart';


class ProfileController extends GetxController {

  var logger = ImageWarehouseUtilities.logger;

  int currentIndex = 0;
  final PageController pageController = PageController();
  TextEditingController searchParamController = TextEditingController();

  final RxString _searchParam = "".obs;
  String get searchParam => _searchParam.value;
  set searchParam(String searchParam) => _searchParam.value = searchParam;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;

  WarehouseUser warehouseUser = WarehouseUser();
  @override
  void onInit() async {
    super.onInit();
    logger.i("ImageWarehouse Home Controller Init");

    try {

      if(Get.arguments != null && Get.arguments.isNotEmpty) {
        warehouseUser = Get.arguments[0];
      }

    } catch (e) {
      logger.e(e.toString());
    }

  }

  @override
  void onReady() {
    super.onReady();
    isLoading = false;
    update([ImageWarehousePageIdConstants.profile]);
  }


}

