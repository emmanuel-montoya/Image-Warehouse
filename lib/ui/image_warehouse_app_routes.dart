import 'package:get/get.dart';
import 'package:image_warehouse/ui/pages/home/home_page.dart';
import 'package:image_warehouse/ui/pages/image/local_image_details_page.dart';
import 'package:image_warehouse/ui/pages/image/online_image_details_page.dart';
import 'package:image_warehouse/ui/pages/local_warehouse/local_warehouse_page.dart';
import 'package:image_warehouse/ui/pages/online_warehouse/online_warehouse_page.dart';
import 'package:image_warehouse/ui/pages/profile/profile_page.dart';
import 'package:image_warehouse/ui/pages/root_page.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_route_constants.dart';


class ImageWareHouseAppRoutes {

  static final homePages = [const OnlineWarehousePage(), const LocalWarehousePage()];

  static final routes = [
    GetPage(
      name: ImageWarehouseRouteConstants.root,
      page: () => const Root(),
      transition: Transition.zoom
    ),
    GetPage(
        name: ImageWarehouseRouteConstants.home,
        page: () => const HomePage(),
        transition: Transition.zoom
    ),
    GetPage(
        name: ImageWarehouseRouteConstants.profile,
        page: () => const ProfilePage(),
        transition: Transition.zoom
    ),
    GetPage(
        name: ImageWarehouseRouteConstants.onlineImageDetails,
        page: () => const OnlineImageDetailsPage(),
        transition: Transition.zoom
    ),
    GetPage(
        name: ImageWarehouseRouteConstants.localImageDetails,
        page: () => const LocalImageDetailsPage(),
        transition: Transition.zoom
    ),

  ];

}

