import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/domain/model/stored_image.dart';
import 'package:image_warehouse/domain/model/warehouse_user.dart';
import 'package:image_warehouse/domain/use-cases/local_warehouse_service.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_page_id_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_route_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_color.dart';
import 'package:image_warehouse/utils/image_warehouse_utilities.dart';

class LocalWarehouseController extends GetxController implements LocalWarehouseService {

  var logger = ImageWarehouseUtilities.logger;

  TextEditingController filterParamController = TextEditingController();

  final String _filterParam = "";

  final RxMap<String, StoredImage> _filteredImages = <String, StoredImage>{}.obs;
  Map<String, StoredImage> get filteredImages => _filteredImages;
  set filteredImages(Map<String, StoredImage> filteredImages) => _filteredImages.value = filteredImages;

  final RxMap<String, StoredImage> _storedImages = <String, StoredImage>{}.obs;
  Map<String, StoredImage> get storedImages => _storedImages;
  set storedImages(Map<String, StoredImage> storedImages) => _storedImages.value = storedImages;


  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;

  @override
  void onInit() async {
    super.onInit();
    logger.i("LocalWarehouse Controller Init");

    try {
      await readFavorites();
    } catch (e) {
      logger.e(e.toString());
    }

  }


  @override
  Future<void> setFilterParam(String param) async {
    logger.d('Entering setSearchParam method for $param');


    try {
      if(param.isEmpty) {
        for (var image in storedImages.values) {
          filteredImages[image.imageUrl] = image;
        }
      } else if(_filterParam != param || !_filterParam.contains(param)) {
        filteredImages = filterByParam(param);
      }

    } catch (e) {
      logger.e(e.toString());
    }

    update([ImageWarehousePageIdConstants.localWarehouse]);
  }

  @override
  Map<String, StoredImage> filterByParam(String param) {
    logger.d('Entering filterByURL method for $param');

    Map<String, StoredImage> filteredImages = {};

    try {
      if(param.isNotEmpty) {
        filteredImages.clear();
        for (StoredImage image in storedImages.values) {
          if(image.description.toLowerCase().contains(param.toLowerCase())
            || image.altDescription.toLowerCase().contains(param.toLowerCase())
              || image.warehouseUser!.username.toLowerCase().contains(param.toLowerCase())
          ) {
            filteredImages[image.imageUrl] = image;
          }
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    logger.i('${filteredImages.length} images filtered');
    update([ImageWarehousePageIdConstants.localWarehouse]);
    return filteredImages;
  }


  @override
  Future<void> loadStoredImages() async {
    logger.d('Entering loadStoredImages method');

    try {
      //storedImages = await _unsplashSearcher.searchPhotos(param);
    } catch (e) {
      logger.e(e.toString());
    }

    isLoading = false;
    update([ImageWarehousePageIdConstants.localWarehouse]);
  }

  @override
  Future<void> gotoProfileDetails(WarehouseUser warehouseUser) async {
    await Get.toNamed(ImageWarehouseRouteConstants.profile, arguments: [warehouseUser]);
  }


  @override
  Future<void> gotoImageDetails(StoredImage storedImage) async {
    await Get.toNamed(ImageWarehouseRouteConstants.onlineImageDetails, arguments: [storedImage]);
  }


  @override
  Future<void> readFavorites() async {
    logger.d("Entering readFavorite method");

    try {
      String localPath = await ImageWarehouseUtilities.localPath;
      Directory jsonDir = Directory("$localPath/");
      List<FileSystemEntity> localPathFiles = jsonDir.listSync();

      for (var localPathFile in localPathFiles) {
        if (localPathFile.path.contains(".json")) {
          final localFile = await File(localPathFile.path).readAsString();
          StoredImage localStoreImage = StoredImage.fromLocalJSON(
              jsonDecode(localFile));
          if (localStoreImage.id.isNotEmpty) {
            File imageFile = File("$localPath/${localStoreImage.id}.jpeg");
            if (await imageFile.exists()) {
              localStoreImage.imageFile = imageFile;
            }
          }
          storedImages[localStoreImage.id] = localStoreImage;
        }
      }

      logger.d("${storedImages.length} retrieved at local memory");

    } catch (e) {
      logger.e(e.toString());
    }

    isLoading = false;
    update([ImageWarehousePageIdConstants.localWarehouse]);

  }


  @override
  Future<void> removeFromFavorites(String storedImageId) async {
    logger.d("Entering removeFromFavorites method");

    String actionMessage = "";

    try {
      String localPath = await ImageWarehouseUtilities.localPath;
      File jsonFileRef = File('$localPath/$storedImageId.json');
      File jpegFileRef = File('$localPath/$storedImageId.jpeg');

      if(await jsonFileRef.exists()) {
        await jsonFileRef.delete();
        logger.i("StoredImage Json File successfully removed");
      }

      if(await jpegFileRef.exists()) {
        await jpegFileRef.delete();
        logger.i("StoredImage JPEG File successfully removed");
      }

      storedImages.remove(storedImageId);
      filteredImages.remove(storedImageId);
      actionMessage = ImageWarehouseTranslationConstants.favImageRemoved;

    } catch (e) {
      logger.e(e.toString());
      actionMessage = ImageWarehouseTranslationConstants.errorWhileAddingToFav;
    }

    Get.snackbar(ImageWarehouseConstants.imageWarehouseTitle,
        actionMessage.tr,
        backgroundColor: ImageWarehouseAppColor.indigo75,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);

    update([ImageWarehousePageIdConstants.localWarehouse]);
  }





}

