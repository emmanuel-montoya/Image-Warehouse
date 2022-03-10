import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/domain/model/stored_image.dart';
import 'package:image_warehouse/domain/model/warehouse_user.dart';
import 'package:image_warehouse/domain/use-cases/online_warehouse_service.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_page_id_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_route_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_color.dart';
import 'package:image_warehouse/utils/image_warehouse_utilities.dart';
import '../../../data/api-services/unsplash_searcher.dart';
import 'package:http/http.dart' as http;

class OnlineWarehouseController extends GetxController implements OnlineWarehouseService {

  var logger = ImageWarehouseUtilities.logger;

  TextEditingController searchParamController = TextEditingController();

  ScrollController _onlineWarehouseScrollController = ScrollController();
  ScrollController get onlineWarehouseScrollController => _onlineWarehouseScrollController;

  String _searchParam = "";

  final RxList<StoredImage> _retrievedImages = <StoredImage>[].obs;
  List<StoredImage> get retrievedImages => _retrievedImages;
  set retrievedImages(List<StoredImage> retrievedImages) => _retrievedImages.value = retrievedImages;

  final RxMap<String, StoredImage> _totalImages = <String, StoredImage>{}.obs;
  Map<String, StoredImage> get totalImages => _totalImages;
  set totalImages(Map<String, StoredImage> totalImages) => _totalImages.value = totalImages;

  Map<String, StoredImage> _totalImagesClone = {};

  final RxMap<String, StoredImage> _filteredImages = <String, StoredImage>{}.obs;
  Map<String, StoredImage> get filteredImages => _filteredImages;
  set filteredImages(Map<String, StoredImage> filteredImages) => _filteredImages.value = filteredImages;

  int currentImageIndex = 0;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;

  final UnsplashSearcher _unsplashSearcher = UnsplashSearcher();

  @override
  void onInit() async {
    super.onInit();
    logger.i("OnlineWarehouse Controller Init");

    try {
      _searchParam = "Lovely dogs";
      await loadStoredImages(_searchParam);
      _onlineWarehouseScrollController.addListener(_onlineWarehouseScrollListener);

    } catch (e) {
      logger.e(e.toString());
    }

  }


  _onlineWarehouseScrollListener() async {
    try {
      logger.d("Scroll Listener is working as expected");

      double maxScrollExtenOffset = onlineWarehouseScrollController.position.maxScrollExtent;

      if (onlineWarehouseScrollController.offset >= maxScrollExtenOffset
          && !onlineWarehouseScrollController.position.outOfRange
          && currentImageIndex == (totalImages.length-1)) {

        logger.d("Scroll Bottom Reached");
        Map<String, StoredImage> nextOnlineImages = await retrieveNextImages();
        logger.i("${nextOnlineImages.length} new images were retrieved");
        totalImages.addAll(nextOnlineImages);
        _onlineWarehouseScrollController = ScrollController(initialScrollOffset: maxScrollExtenOffset);
        _onlineWarehouseScrollController.addListener(_onlineWarehouseScrollListener);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    update([ImageWarehousePageIdConstants.onlineWarehouse]);
  }


  @override
  Future<void> setSearchParam(String param) async {
    logger.d('Entering setSearchParam method for $param');


    try {
      if(param.isEmpty) {
        for (var image in totalImages.values) {
          filteredImages[image.imageUrl] = image;
        }
      } else if(_searchParam != param || !_searchParam.contains(param)) {
        _searchParam = param;
        _totalImagesClone = Map<String,StoredImage>.from(totalImages);
        await loadStoredImages(param);
        for (var image in _totalImagesClone.values) {
          totalImages[image.id] = image;
        }
      }

      filteredImages = filterByParam(param);
      _onlineWarehouseScrollController = ScrollController();
      _onlineWarehouseScrollController.addListener(_onlineWarehouseScrollListener);

    } catch (e) {
      logger.e(e.toString());
    }

    update([ImageWarehousePageIdConstants.onlineWarehouse]);
  }


  @override
  Map<String, StoredImage> filterByParam(String param) {
    logger.d('Entering filterByURL method for $param');

    Map<String, StoredImage> filteredImages = {};

    try {
      if(param.isNotEmpty) {
        filteredImages.clear();
        for (StoredImage image in totalImages.values) {
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
    update([ImageWarehousePageIdConstants.onlineWarehouse]);
    return filteredImages;
  }


  @override
  Future<void>  loadStoredImages(String param) async {
    logger.d('Entering retrieveImages method for $param');

    try {
      if(param.isNotEmpty) {
        retrievedImages = await _unsplashSearcher.searchPhotos(param);
        if(retrievedImages.isNotEmpty) {
          totalImages.clear();
        }

        for (var image in retrievedImages) {
          totalImages[image.id] = image;
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    isLoading = false;
    update([ImageWarehousePageIdConstants.onlineWarehouse]);
  }


  @override
  Future<Map<String, StoredImage>> retrieveNextImages() async {
    logger.d('Entering retrieveNextImages method');

    Map<String, StoredImage> nextOnlineImages = {};

    try {
      if(_searchParam.isNotEmpty) {
        retrievedImages = await _unsplashSearcher.searchPhotos(_searchParam, firstPage: false);

        for (var image in retrievedImages) {
          nextOnlineImages[image.id] = image;
        }

      }
    } catch (e) {
      logger.e(e.toString());
    }

    isLoading = false;
    update([ImageWarehousePageIdConstants.onlineWarehouse]);
    return nextOnlineImages;
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
  Future<void> saveToFavorites(StoredImage favImage) async {
    logger.d("Entering saveToFavorites method");

    String actionMessage = "";
    try {

      StoredImage localImage = await readFavorite(favImage.id);

      if(localImage.id.isEmpty) {
        String localPath = await ImageWarehouseUtilities.localPath;
        logger.i("Application Documents Directory: $localPath");
        File jsonFileRef = File('$localPath/${favImage.id}.json');
        String favImageEncoded = jsonEncode(favImage.toJSON());
        logger.d("Image selected as favorite JSON: $favImageEncoded");
        jsonFileRef.writeAsString(favImageEncoded);
        await downloadImage(favImage);
        actionMessage = ImageWarehouseTranslationConstants.favImageAdded;
      } else {
        actionMessage = ImageWarehouseTranslationConstants.imageAlreadyInFav;
      }

    } catch (e) {
      logger.e(e.toString());
      actionMessage = ImageWarehouseTranslationConstants.errorWhileAddingToFav;
    }

    Get.snackbar(ImageWarehouseConstants.imageWarehouseTitle,
        actionMessage.tr,
        backgroundColor: ImageWarehouseAppColor.indigo75,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }


  @override
  Future<StoredImage> readFavorite(String favImageId) async {
    logger.d("Entering readFavorite method");

    StoredImage favStoredImage = StoredImage();

    try {
      String localPath = await ImageWarehouseUtilities.localPath;
      File jsonFileRef = File('$localPath/$favImageId.json');
      File jpegFileRef = File('$localPath/$favImageId.jpeg');
      final fileContent = await jsonFileRef.readAsString();
      favStoredImage = StoredImage.fromLocalJSON(jsonDecode(fileContent));
      if(await jpegFileRef.exists()) {
        favStoredImage.imageFile = jpegFileRef;
      }
      logger.d("Image stored from Username: ${favStoredImage.warehouseUser!.username}");

    } catch (e) {
      logger.e(e.toString());
    }

    return favStoredImage;

  }


  @override
  Future<void> downloadImage(StoredImage imageToStore) async {
    logger.d("Entering downloadImage method");

    try {
      final response = await http.get(Uri.parse(imageToStore.imageUrl));

      if (response.statusCode == 200) {
        // Get the document directory path
        String localPath = await ImageWarehouseUtilities.localPath;
        File jpegFileRef = File('$localPath/${imageToStore.id}.jpeg');
        await jpegFileRef.writeAsBytes(response.bodyBytes);
      }
    } catch (e) {
      logger.e(e.toString());
    }

  }


}

