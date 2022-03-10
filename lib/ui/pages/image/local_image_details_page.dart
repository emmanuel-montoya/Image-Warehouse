import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/ui/pages/image/image_details_controller.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_page_id_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_route_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_theme.dart';

class LocalImageDetailsPage extends StatelessWidget {

  const LocalImageDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageDetailsController>(
      id: ImageWarehousePageIdConstants.imageDetails,
      init: ImageDetailsController(),
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: ImageWarehouseAppTheme.boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Center(
                  child: Image.file(_.storedImage.imageFile!)
                ),
                onTap: () {
                  Get.back();
                },
              ),
              ImageWarehouseAppTheme.heightSpace10,
              GestureDetector(
                onTap: () => Get.toNamed(ImageWarehouseRouteConstants.profile, arguments: [_.storedImage.warehouseUser]),
                child: Text("@${_.storedImage.warehouseUser!.username}",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Text(_.storedImage.description.isNotEmpty
                  ? _.storedImage.description
                  : _.storedImage.altDescription,
              style: const TextStyle(fontSize: 15, color: Colors.white),)
            ],
          )
        )
      ),
    );
  }
}

