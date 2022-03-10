import 'dart:io';

import 'package:image_warehouse/domain/model/warehouse_user.dart';

class StoredImage {

  String id;
  String description;
  String altDescription;
  String imageUrl;
  int likes;
  File? imageFile;
  WarehouseUser? warehouseUser;

  StoredImage({
    this.id = "",
    this.description = "",
    this.altDescription = "",
    this.imageUrl = "",
    this.likes = 0,
    this.warehouseUser,
    this.imageFile
  });


  @override
  String toString() {
    return 'StoredImage{id: $id, description: $description, altDescription: $altDescription, imageUrl: $imageUrl, likes: $likes, imageFile: $imageFile, warehouseUser: $warehouseUser}';
  }


  StoredImage.fromJSON(Map<String, dynamic> json) :
    id = json["id"],
    description = json["description"] ?? "",
    altDescription = json["alt_description"] ?? "",
    imageUrl = json["urls"]["full"],
    likes = json["likes"] ?? 0,
    warehouseUser = WarehouseUser.fromMap(json["user"]);


  StoredImage.fromLocalJSON(Map<String, dynamic> json) :
        id = json["id"],
        description = json["description"] ?? "",
        altDescription = json["alt_description"] ?? "",
        imageUrl = json["imageUrl"] ?? "",
        likes = json["likes"] ?? 0,
        warehouseUser = WarehouseUser.fromJSON(json["warehouseUser"]);


  Map<String, dynamic>  toJSON()=>{
    'id': id,
    'description': description,
    'alt_description': altDescription,
    'imageUrl': imageUrl,
    'likes': likes,
    'warehouseUser': warehouseUser?.toJSON() ?? WarehouseUser().toJSON()
  };
}

