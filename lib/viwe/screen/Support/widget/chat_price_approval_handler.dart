import 'package:e_comerece/controller/support_controller/support_screen_controller.dart';
import 'package:e_comerece/data/model/support_model/get_message_model.dart';
import 'package:e_comerece/viwe/screen/Support/widget/price_approval_card.dart';
import 'package:e_comerece/viwe/screen/local_serviess/service_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPriceApprovalHandler extends StatelessWidget {
  final List<Message> messages;
  final SupportScreenControllerImp controller;

  const ChatPriceApprovalHandler({
    super.key,
    required this.messages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    String? approvedPrice;
    final regex = RegExp(r"approve price (\d+)", caseSensitive: false);
    if (messages.isNotEmpty && messages.first.message != null) {
      final match = regex.firstMatch(messages.first.message!);
      if (match != null) {
        approvedPrice = match.group(1);
      }
    }

    if (approvedPrice != null) {
      return Hero(
        tag: controller.serviceModel?.serviceId ?? "",
        child: PriceApprovalCard(
          price: approvedPrice,
          onConfirm: () {
            Get.to(
              () => const ServiceOrderScreen(),
              arguments: {
                'service_model': controller.serviceModel,
                'quoted_price': double.parse(approvedPrice!),
                'chat_id': controller.chatid,
              },
            );
          },
        ),
      );
    }
    return const SizedBox();
  }
}
