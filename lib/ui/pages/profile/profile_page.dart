import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/ui/pages/profile/profile_controller.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_page_id_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_theme.dart';
import 'package:image_warehouse/utils/image_warehouse_utilities.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      id: ImageWarehousePageIdConstants.profile,
      init: ProfileController(),
      builder: (_) => Scaffold(
        body: Container(
          decoration: ImageWarehouseAppTheme.boxDecoration,
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              ImageWarehouseAppTheme.heightSpace20,
              Container(
                width: 150.0,
                height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      image: DecorationImage(
                      image: Image.network(_.warehouseUser.profileImage).image,
                        fit: BoxFit.cover,
                      ),
                  ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 20, right: 20),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ImageWarehouseTranslationConstants.name.tr,
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                  ),
                  ImageWarehouseAppTheme.heightSpace10,
                  Text(_.warehouseUser.name,
                    style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                  ),
                  ImageWarehouseAppTheme.heightSpace10,
                  Text(
                    ImageWarehouseTranslationConstants.location.tr,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  ImageWarehouseAppTheme.heightSpace10,
                  Text(_.warehouseUser.location,
                    style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                  ),
                  ImageWarehouseAppTheme.heightSpace10,
                  Text(ImageWarehouseTranslationConstants.portfolioUrl.tr,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  ImageWarehouseAppTheme.heightSpace10,
                  Text(_.warehouseUser.portfolioUrl,
                    style: const TextStyle(
                        color: Colors.white
                    ),
                  ),
                  ImageWarehouseAppTheme.heightSpace10,
                  Text(
                    ImageWarehouseTranslationConstants.totalPhotos.tr,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  ImageWarehouseAppTheme.heightSpace10,
                  Text(_.warehouseUser.totalPhotos.toString(),
                    style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                  ),
                 Center(
                   child: ElevatedButton(
                     child: Text(ImageWarehouseTranslationConstants.gotoPortfolio.tr,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                     ),
                     style: ElevatedButton.styleFrom(primary: Colors.white12,
                       padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10, top: 10),
                       textStyle: const TextStyle(color: Colors.white),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0)),
                     ),
                     onPressed: () {
                       ImageWarehouseUtilities.launchURL(_.warehouseUser.portfolioUrl);
                     },
                   ),
                 ),
                    ],
                  )),
                ],
              ),),)

    );
  }
}
