import 'package:e_comerece/controller/local_service/service_order_controller.dart';
import 'package:e_comerece/viwe/screen/local_serviess/widget/service_order_content.dart';
import 'package:e_comerece/viwe/screen/local_serviess/widget/service_order_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceOrderScreen extends StatelessWidget {
  const ServiceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceOrderController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: const Stack(
        children: [
          // 1. Header Image
          ServiceOrderImage(),

          // 2. Scrollable Content
          ServiceOrderContent(),
        ],
      ),
    );
  }
}
