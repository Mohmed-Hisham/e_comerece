import 'package:e_comerece/controller/settings_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsControllerImple controller = Get.put(SettingsControllerImple());
    return Container(
      child: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(height: Get.width / 2.5, color: Appcolor.primrycolor),
              Positioned(
                top: Get.width / 3.2,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(100),
                  child: Image.asset(
                    AppImagesassets.avata,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Disable Notfications"),
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  ListTile(
                    title: Text("Address"),
                    trailing: Icon(Icons.location_on_outlined),
                  ),

                  ListTile(
                    title: Text("About us"),
                    trailing: Icon(Icons.help_outline),
                  ),

                  ListTile(
                    title: Text("Conect us"),
                    trailing: Icon(Icons.contact_phone_outlined),
                  ),
                  ListTile(
                    onTap: () {
                      controller.logout();
                    },
                    title: Text("Logout"),
                    trailing: Icon(Icons.logout),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
