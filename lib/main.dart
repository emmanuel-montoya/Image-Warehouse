import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/ui/image_warehouse_app_routes.dart';
import 'package:image_warehouse/ui/pages/root_page.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_route_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_translations.dart';
import 'package:logger/logger.dart';


void main() {

  Logger.level = Level.verbose;
  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      translations: ImageWareHouseTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      defaultTransition: Transition.upToDown,
      debugShowCheckedModeBanner: false,
      home: const Root(),
      initialRoute: ImageWarehouseRouteConstants.root,
      getPages: ImageWareHouseAppRoutes.routes,
    );
  }
}

