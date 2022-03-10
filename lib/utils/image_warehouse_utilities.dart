import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_color.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageWarehouseUtilities {

  static final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 5,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: false,
    )
  );


  static void showAlert(context, title,  message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ImageWarehouseAppColor.indigo,
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(ImageWarehouseTranslationConstants.close.tr),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }


  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      logger.i('Could not launch $url');
    }
  }


  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

}

