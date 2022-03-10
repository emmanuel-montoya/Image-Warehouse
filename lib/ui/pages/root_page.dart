import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_constants.dart';
import 'package:image_warehouse/utils/constants/image_warehouse_translation_constants.dart';
import 'package:image_warehouse/utils/image_warehouse_app_color.dart';
import 'home/home_page.dart';

class Root extends StatelessWidget {

  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: ImageWarehouseAppColor.indigo,
            title: const Text(ImageWarehouseConstants.imageWarehouseTitle,
              style: TextStyle(color: Colors.white),
            ),
            content:  Text(ImageWarehouseTranslationConstants.wantToCloseApp.tr,
              style: const TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(ImageWarehouseTranslationConstants.no.tr,
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text(ImageWarehouseTranslationConstants.yes.tr,
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          ),
        ));
      },
      child: const HomePage()
    );
  }

}

