import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_color.dart';
import 'package:image_warehouse/utils/image_warehouse_app_theme.dart';


class NoFavoritesPage extends StatelessWidget {

  const NoFavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ImageWarehouseAppColor.indigo,
      body: Container(
        width: ImageWarehouseAppTheme.fullWidth(context),
        decoration: ImageWarehouseAppTheme.boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite,
                size: 150,
                color: Colors.white,
              ),
              ImageWarehouseAppTheme.heightSpace10,
              Text(ImageWarehouseTranslationConstants.noFavoritesYet.tr,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              ),
              ImageWarehouseAppTheme.heightSpace10,
              Text(ImageWarehouseTranslationConstants.addSomeImagesMsg.tr,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                  ),
                textAlign: TextAlign.center,
              ),
            ]
          )
        )
      );
  }

}
