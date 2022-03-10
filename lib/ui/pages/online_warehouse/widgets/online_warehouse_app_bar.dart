import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/ui/pages/online_warehouse/online_warehouse_controller.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_color.dart';
import 'package:image_warehouse/utils/image_warehouse_app_theme.dart';


class OnlineWarehouseAppBar extends StatelessWidget implements PreferredSizeWidget {

  final OnlineWarehouseController onlineWarehouseController;

  const OnlineWarehouseAppBar(this.onlineWarehouseController, {Key? key}) : super(key: key);

  @override
  Size get preferredSize => ImageWarehouseAppTheme.appBarHeight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: onlineWarehouseController.searchParamController,
        maxLines: 1,
        onChanged: (param) async => await onlineWarehouseController.setSearchParam(param.trim()),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.image_search, color: Colors.white),
          hintText: ImageWarehouseTranslationConstants.enterUserOrImageName.tr,
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: ImageWarehouseAppColor.indigo,
      elevation: 10.0,
    );
  }

}

