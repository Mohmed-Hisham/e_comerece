import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:flutter/material.dart';

class SellerinfoAlibaba extends StatelessWidget {
  final ProductDetailsAlibabaControllerImple controller;
  const SellerinfoAlibaba({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final companyName = controller.getCompanyName();
    final companyType = controller.getCompanyType();
    final contactName = controller.getCompanyContactName();

    if (companyName == null || companyType == null)
      return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seller Information',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.business, color: Colors.blue[700], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      companyName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.category, color: Colors.blue[600], size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      companyType,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.blue[600]),
                    ),
                  ),
                ],
              ),
              if (contactName != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blue[600], size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Contact: $contactName',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.blue[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
