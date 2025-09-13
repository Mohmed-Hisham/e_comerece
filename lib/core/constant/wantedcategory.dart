import 'package:flutter/material.dart';

const Map<int, IconData> categoryIcons = {
  2: Icons.fastfood, // Food
  3: Icons.checkroom_outlined, // Apparel & Accessories
  6: Icons.kitchen, // Home Appliances
  7: Icons.computer, // Computer & Office
  13: Icons.handyman, // Home Improvement
  15: Icons.house_outlined, // Home & Garden
  18: Icons.sports, // Sports & Entertainment
  21: Icons.school_outlined, // Office & School Supplies
  26: Icons.toys, // Toys & Hobbies
  30: Icons.security, // Security & Protection
  34: Icons.directions_car_outlined, // Automobiles, Parts & Accessories
  36: Icons.diamond_outlined, // Jewelry & Accessories
  39: Icons.lightbulb_outline, // Lights & Lighting
  44: Icons.devices_other, // Consumer Electronics
  66: Icons.health_and_safety_outlined, // Beauty & Health
  320: Icons.celebration_outlined, // Weddings & Events
  322: Icons.directions_run_outlined, // Shoes
  502: Icons.memory_outlined, // Electronic Components & Supplies
  509: Icons.phone_android_outlined, // Phones & Telecommunications
  1420: Icons.build_outlined, // Tools
  1501: Icons.child_care_outlined, // Mother & Kids
  1503: Icons.chair_outlined, // Furniture
  1511: Icons.watch_outlined, // Watches
  1524: Icons.backpack_outlined, // Luggage & Bags
  200574005: Icons.checkroom_outlined, // Underwear (fallback to clothing icon)
  201169612: Icons.cloud_outlined, // Virtual Products
  202216001: Icons.business_outlined, // Industrial & Business
  201768104:
      Icons.sports_basketball_outlined, // Sports Shoes,Clothing&Accessories
  202192403:
      Icons.headset_mic_outlined, // Phones & Telecommunications Accessories
  200000345: Icons.woman_outlined, // Women's Clothing
  200000343: Icons.man_outlined, // Men's Clothing
  200000297: Icons.style_outlined, // Apparel Accessories
  200165144: Icons.brush_outlined, // Hair Extensions & Wigs
  200001075: Icons.star_outline, // Special Category
  202228412: Icons.book_outlined, // Books & Cultural Merchandise
  200000532: Icons.new_releases_outlined, // Novelty & Special Use
  201520802: Icons.restore_outlined, // Second-Hand
  201355758: Icons.two_wheeler_outlined, // Motorcycle Equipments & Parts
};

/// دالة مساعدة بسيطة لاسترجاع الأيقونة مع افتراضي
IconData getCategoryIcon(int id) => categoryIcons[id] ?? Icons.category;
