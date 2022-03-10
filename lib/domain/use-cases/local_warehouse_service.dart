import 'package:image_warehouse/domain/model/stored_image.dart';
import 'package:image_warehouse/domain/model/warehouse_user.dart';


abstract class LocalWarehouseService {

  Future<void> setFilterParam(String param);
  Map<String, StoredImage> filterByParam(String param);
  Future<void> loadStoredImages();
  Future<void> gotoProfileDetails(WarehouseUser warehouseUser);
  Future<void> gotoImageDetails(StoredImage storedImage);
  Future<void> readFavorites();
  Future<void> removeFromFavorites(String storedImageId);

}

