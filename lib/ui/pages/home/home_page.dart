import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/ui/image_warehouse_app_routes.dart';
import 'package:image_warehouse/ui/pages/home/home_page_controller.dart';
import 'package:image_warehouse/ui/pages/home/widgets/image_warehouse_bottom_nav_bar.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_page_id_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_color.dart';
import 'package:image_warehouse/utils/image_warehouse_app_theme.dart';


class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: ImageWarehousePageIdConstants.home,
      init: HomeController(),
      builder: (_) => Scaffold(
        backgroundColor: Colors.indigo,
        body: _.isLoading
        ? Container(
          decoration: ImageWarehouseAppTheme.boxDecoration,
          child: const Center(
            child: CircularProgressIndicator()
          )
        )
        : PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _.pageController,
          children: ImageWareHouseAppRoutes.homePages
        ),
        bottomNavigationBar: ImageWarehouseBottomNavBar (
          backgroundColor: ImageWarehouseAppColor.indigo,
          color: Colors.white54,
          selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
          notchedShape: const CircularNotchedRectangle(),
          iconSize: 30.0,
          onTabSelected:(int index) async => _.selectPageView(index),
          items: [
            ImageWarehouseBottomNavBarItem(iconData: Icons.home, text: ImageWarehouseTranslationConstants.home.tr),
            ImageWarehouseBottomNavBarItem(iconData: Icons.favorite, text: ImageWarehouseTranslationConstants.favorites.tr),
          ],
        ),
      )
    );
  }
}