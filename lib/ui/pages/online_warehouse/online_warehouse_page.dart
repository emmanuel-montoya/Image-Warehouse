import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/domain/model/stored_image.dart';
import 'package:image_warehouse/ui/pages/online_warehouse/widgets/online_warehouse_app_bar.dart';
import 'package:image_warehouse/ui/pages/online_warehouse/online_warehouse_controller.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_page_id_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_color.dart';
import 'package:image_warehouse/utils/image_warehouse_app_theme.dart';


class OnlineWarehousePage extends StatelessWidget {

  const OnlineWarehousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnlineWarehouseController>(
      id: ImageWarehousePageIdConstants.onlineWarehouse,
      init: OnlineWarehouseController(),
      builder: (_) => Scaffold(
      appBar: OnlineWarehouseAppBar(_),
      body: Container(
        decoration: ImageWarehouseAppTheme.boxDecoration,
        child: Obx(() =>_.isLoading ? const Center(
          child: CircularProgressIndicator()
        )
        : ListView.builder(
          controller: _.onlineWarehouseScrollController,
          shrinkWrap: true,
          itemCount: _.filteredImages.isNotEmpty ? _.filteredImages.length : _.totalImages.length,
          itemBuilder: (context, index) {
            StoredImage storedImage = _.filteredImages.isNotEmpty
            ? _.filteredImages.values.elementAt(index)
            : _.totalImages.values.elementAt(index);
            _.currentImageIndex = index;
            return ListTile(
              minVerticalPadding: 0,
              contentPadding: const EdgeInsets.all(0),
              tileColor: ImageWarehouseAppColor.indigo75,
              title: Stack(
                children: [
                  GestureDetector(
                    onTap: () => _.gotoImageDetails(storedImage),
                    child: CachedNetworkImage(
                      imageUrl: storedImage.imageUrl,
                      fit: BoxFit.fitWidth,
                    )
                  ),
                  Positioned(
                   right: ImageWarehouseAppTheme.padding10,
                   top: ImageWarehouseAppTheme.padding10,
                   child: TextButton(
                    onPressed: () async => await _.saveToFavorites(storedImage),
                    child: Column(
                      children: [
                        const Icon(Icons.save_alt,
                            color: Colors.white,
                            size: 30
                        ),
                        Text(ImageWarehouseTranslationConstants.saveToFav.tr,
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

