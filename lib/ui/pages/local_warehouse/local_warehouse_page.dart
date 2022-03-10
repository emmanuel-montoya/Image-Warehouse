import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/domain/model/stored_image.dart';
import 'package:image_warehouse/ui/pages/local_warehouse/local_warehouse_controller.dart';
import 'package:image_warehouse/ui/pages/local_warehouse/widgets/local_warehouse_app_bar.dart';
import 'package:image_warehouse/ui/pages/local_warehouse/widgets/no_favorites_page.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_page_id_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_color.dart';
import 'package:image_warehouse/utils/image_warehouse_app_theme.dart';


class LocalWarehousePage extends StatelessWidget {

  const LocalWarehousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalWarehouseController>(
      id: ImageWarehousePageIdConstants.localWarehouse,
      init: LocalWarehouseController(),
      builder: (_) => Scaffold(
      appBar: LocalWarehouseAppBar(_),
      body: Container(
        decoration: ImageWarehouseAppTheme.boxDecoration,
        child: Obx(() =>_.isLoading ? const Center(
          child: CircularProgressIndicator()
        ) : _.storedImages.isEmpty
        ? const NoFavoritesPage()
        : ListView.builder(
          shrinkWrap: true,
          itemCount: _.filteredImages.isNotEmpty ? _.filteredImages.length : _.storedImages.length,
          itemBuilder: (context, index) {
            StoredImage storedImage = _.filteredImages.isNotEmpty
            ? _.filteredImages.values.elementAt(index)
            : _.storedImages.values.elementAt(index);
            return ListTile(
              minVerticalPadding: 0,
              contentPadding: const EdgeInsets.all(0),
              tileColor: ImageWarehouseAppColor.indigo75,
              title: Stack(
                children: [
                  GestureDetector(
                    onTap: () => _.gotoImageDetails(storedImage),
                    child: Image.file(storedImage.imageFile!,
                      fit: BoxFit.fitWidth,
                    )
                  ),
                  Positioned(
                   right: ImageWarehouseAppTheme.padding10,
                   top: ImageWarehouseAppTheme.padding10,
                   child: TextButton(
                    onPressed: () async => {
                      await _.removeFromFavorites(storedImage.id)
                    },
                    child: Column(
                      children: [
                        const Icon(Icons.save_alt,
                            color: Colors.white,
                            size: 30
                        ),
                        Text(ImageWarehouseTranslationConstants.removeFromFav.tr,
                          style: const TextStyle(
                            fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          )
                        )
                      ],
                    )
                   ),
                  ),
                  Positioned(
                    right: ImageWarehouseAppTheme.padding10,
                    bottom: ImageWarehouseAppTheme.padding10,
                    child: TextButton(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(storedImage.warehouseUser!.profileImage),
                              ),
                              ImageWarehouseAppTheme.heightSpace10,
                              Text(storedImage.warehouseUser?.username == null ? ""
                                  : "@${storedImage.warehouseUser!.username}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ],
                          ),
                          onPressed: () => _.gotoProfileDetails(storedImage.warehouseUser!)

                    ),
                  ),
                  Positioned(
                    left: ImageWarehouseAppTheme.padding10,
                    bottom: ImageWarehouseAppTheme.padding10,
                    child: TextButton(
                      child: Column(
                        children: [
                          const Icon(Icons.favorite,
                            color: Colors.white,
                            size: 40
                          ),
                          ImageWarehouseAppTheme.heightSpace10,
                          Text(storedImage.likes.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ],
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ]
              ),
            );
          })
        ),
      ),
      )
    );
  }
}

