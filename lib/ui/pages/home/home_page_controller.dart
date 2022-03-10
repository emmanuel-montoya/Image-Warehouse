import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/domain/use-cases/image_warehouse_home_service.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_page_id_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_utilities.dart';

class HomeController extends GetxController implements ImageWarehouseHomeService {

  var logger = ImageWarehouseUtilities.logger;

  int currentIndex = 0;
  final PageController pageController = PageController();

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;

  @override
  void onInit() async {
    super.onInit();
    logger.i("ImageWarehouse Home Controller Init");

    try {

      pageController.addListener(() {
        currentIndex = pageController.page!.toInt();
      });

    } catch (e) {
      logger.e(e.toString());
    }

  }


  @override
  void onReady() {
    super.onReady();
    isLoading = false;
    update([ImageWarehousePageIdConstants.home]);
  }


  @override
  Future<void> selectPageView(int index) async {

    currentIndex = index;

    try {
      if(pageController.hasClients) {
        pageController.jumpToPage(index);
      }

    } catch (e) {
      logger.e(e.toString());
    }

    update([ImageWarehousePageIdConstants.home]);
  }


}

