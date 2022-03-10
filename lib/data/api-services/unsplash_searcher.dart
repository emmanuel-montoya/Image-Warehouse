import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_warehouse/domain/model/stored_image.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_constants.dart';

import '../../utils/image_warehouse_utilities.dart';

class UnsplashSearcher {

  var logger = ImageWarehouseUtilities.logger;
  int _page = 1;
  int _totalPages = 0;
  String _searchParam = "";

  Future<List<StoredImage>> searchPhotos(String param, {firstPage = true}) async {
    logger.d('Entering searchPhotos method for $param');

    List<StoredImage> storedImages = [];

    if(!firstPage && _page < _totalPages && _searchParam == param) {
      _page++;
    } else {
      _searchParam = param;
      _page = 1;
    }

    try {
      Uri uri = Uri.parse(ImageWarehouseConstants.unsplashBaseUrl+ImageWarehouseConstants.searchPhotos
          +'?query=$param&page=$_page');

      http.Response response = await http.get(uri,
          headers: {
            'Authorization': 'Client-ID ${ImageWarehouseConstants.accessKey}'
          }
      );

      if (response.statusCode == 200) {
        logger.i('Images retrieved Successfully for $param');
        var responseBody = jsonDecode(response.body);
        _totalPages = responseBody['total_pages'];
        List<dynamic> totalImages = responseBody['results'];
        for (var element in totalImages) {
          StoredImage storedImage = StoredImage.fromJSON(element);
          logger.d('Store Image Description: ${storedImage.description}');
          storedImages.add(storedImage);
        }

      } else {
        logger.e('Something occurred while retrieving images with $param');
      }
    } catch (e) {
      logger.e(e.toString());
    }

    logger.i("${storedImages.length} images were retrieved from Unsplash API");
    return storedImages;
  }


}

