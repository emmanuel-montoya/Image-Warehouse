import 'package:image_warehouse/domain/model/stored_image.dart';
import 'package:image_warehouse/domain/model/warehouse_user.dart';


abstract class OnlineWarehouseService {

  Future<void> setSearchParam(String param);
  Map<String, StoredImage> filterByParam(String param);
  Future<void>  loadStoredImages(String param);
  Future<Map<String, StoredImage>> retrieveNextImages();
  Future<void> gotoProfileDetails(WarehouseUser warehouseUser);
  Future<void> gotoImageDetails(StoredImage storedImage);
  Future<void> saveToFavorites(StoredImage storedImage);
  Future<StoredImage> readFavorite(String favImageId);
  Future<void> downloadImage(StoredImage imageToStore);

}

