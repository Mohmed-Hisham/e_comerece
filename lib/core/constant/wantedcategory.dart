// wantedcategory.dart

import 'package:flutter/material.dart';

final List<int> wantedCategoryIds = [
  // --- الإلكترونيات والهواتف (الأولوية القصوى) ---
  44, // Consumer Electronics (فئة رئيسية)
  509, // Phones & Telecommunications (فئة رئيسية)
  202192403, // Phones & Telecommunications Accessories (اكسسوارات الهواتف)
  202228401, // Mobile Phone Cases & Covers (جرابات الموبايل)
  100001205, // Mobile Phone Accessories (اكسسوارات أخرى)
  100000306, // Portable Audio & Video (السماعات بأنواعها)
  200003803, // Smart Electronics (الساعات والأجهزة الذكية)
  629, // Accessories & Parts (اكسسوارات وقطع غيار عامة)
  202228620, // Holders & Stands (حوامل الهواتف)
  5090301, // Mobile Phones (الهواتف المحمولة نفسها)
  // --- الكمبيوتر والمكتب ---
  7, // Computer & Office (فئة رئيسية)
  200001081, // Computer Peripherals (ملحقات الكمبيوتر: ماوس، كيبورد)
  200001074, // Storage Device (أجهزة التخزين: فلاشات، هاردات)
  200001083, // Laptop Parts & Accessories (اكسسوارات اللابتوب)
  200001077, // Networking (أجهزة الشبكات)
  702, // Laptops (لابتوبات)
  // --- الأزياء الرجالية والنسائية ---
  200000345, // Women's Clothing (ملابس نسائية - فئة رئيسية)
  200000343, // Men's Clothing (ملابس رجالية - فئة رئيسية)
  3, // Apparel & Accessories (فئة رئيسية عامة)
  201768104, // Sports Shoes,Clothing&Accessories (ملابس وأحذية رياضية)
  322, // Shoes (فئة رئيسية - أحذية)
  200000950, // Sneakers (أحذية رياضية)
  200131145, // Men's Shoes (أحذية رجالية)
  200133142, // Women's Shoes (أحذية نسائية)
  // --- الحقائب والساعات والمجوهرات ---
  1524, // Luggage & Bags (فئة رئيسية)
  152401, // Backpacks (حقائب الظهر)
  201336907, // Women's Handbags (حقائب نسائية)
  201337808, // Men's Bags (حقائب رجالية)
  3803, // Wallets & Holders (المحافظ)
  1511, // Watches (فئة الساعات)
  36, // Jewelry & Accessories (فئة رئيسية)
  1509, // Fashion Jewelry (مجوهرات الموضة)
  // --- اكسسوارات الملابس ---
  200000297, // Apparel Accessories (فئة رئيسية)
  200000440, // Eyewear & Accessories (النظارات واكسسواراتها)
  200000402, // Hats & Caps (القبعات)
  200000298, // Belts (الأحزمة)
  200000399, // Scarves & Wraps (الأوشحة)
  // --- المنزل والمطبخ والحديقة ---
  15, // Home & Garden (فئة رئيسية)
  3710, // Home Decor (ديكورات منزلية)
  1541, // Home Storage & Organization (أدوات التخزين والتنظيم)
  200000920, // Kitchen,Dining & Bar (أدوات المطبخ والطعام)
  405, // Home Textile (منسوجات منزلية: مفارش، ستائر)
  13, // Home Improvement (فئة رئيسية)
  200066142, // Bathroom Fixture (تجهيزات الحمام)
  // --- الجمال والصحة ---
  66, // Beauty & Health (فئة رئيسية)
  200001187, // Tools & Accessories (أدوات واكسسوارات التجميل)
  100000616, // Skin Care Tool (أدوات العناية بالبشرة)
  200001168, // Hair Care & Styling (العناية بالشعر)
  660103, // Makeup (مكياج)
  // --- ألعاب وهوايات ---
  26, // Toys & Hobbies (فئة رئيسية)
  201292714, // Action & Toy Figures (شخصيات الأكشن)
  200001383, // Building & Construction Toys (ألعاب التركيب)
  200001385, // Remote Control Toys (ألعاب التحكم عن بعد)
  // --- رياضة وتخييم ---
  18, // Sports & Entertainment (فئة رئيسية)
  100005529, // Camping & Hiking (معدات التخييم والرحلات)
  100005371, // Fitness & Body Building (اكسسوارات اللياقة البدنية)
  100005537, // Fishing (أدوات الصيد)
  // --- الأجهزة المنزلية والإضاءة ---
  6, // Home Appliances (فئة رئيسية)
  100000041, // Kitchen Appliances (أجهزة المطبخ الصغيرة)
  200165142, // Personal Care Appliances (أجهزة العناية الشخصية)
  39, // Lights & Lighting (فئة رئيسية)
  390503, // Portable Lighting (الإضاءة المحمولة)
  // --- السيارات والدراجات النارية ---
  34, // Automobiles, Parts & Accessories (فئة رئيسية)
  200003411, // Interior Accessories (اكسسوارات السيارات الداخلية)
  200003427, // Exterior Accessories (اكسسوارات السيارات الخارجية)
  200000285, // Car Electronics (إلكترونيات السيارات)
  201355758, // Motorcycle Equipments & Parts (قطع ومعدات الدراجات النارية)
];

// Map يربط كل category ID بـ IconData مناسبة
final Map<int, IconData> categoryIcons = {
  // --- الإلكترونيات والهواتف (الأولوية القصوى) ---
  44: Icons.devices_other, // Consumer Electronics
  509: Icons.phone_android_outlined, // Phones & Telecommunications
  202192403:
      Icons.headset_mic_outlined, // Phones & Telecommunications Accessories
  202228401: Icons.smartphone_outlined, // Mobile Phone Cases & Covers
  100001205: Icons.cable_outlined, // Mobile Phone Accessories
  100000306: Icons.headphones_outlined, // Portable Audio & Video
  200003803: Icons.watch_outlined, // Smart Electronics
  629: Icons.memory_outlined, // Accessories & Parts
  202228620:
      Icons.videocam_outlined, // Holders & Stands (استخدام أيقونة حامل كاميرا)
  5090301: Icons.phone_iphone_outlined, // Mobile Phones
  // --- الكمبيوتر والمكتب ---
  7: Icons.computer_outlined, // Computer & Office
  200001081: Icons.mouse_outlined, // Computer Peripherals
  200001074: Icons.sd_storage_outlined, // Storage Device
  200001083: Icons.laptop_mac_outlined, // Laptop Parts & Accessories
  200001077: Icons.router_outlined, // Networking
  702: Icons.laptop_chromebook_outlined, // Laptops
  // --- الأزياء الرجالية والنسائية ---
  200000345: Icons.woman_outlined, // Women's Clothing
  200000343: Icons.man_outlined, // Men's Clothing
  3: Icons.checkroom_outlined, // Apparel & Accessories
  201768104:
      Icons.sports_basketball_outlined, // Sports Shoes,Clothing&Accessories
  322: Icons.snowshoeing_outlined, // Shoes
  200000950: Icons.directions_run_outlined, // Sneakers
  200131145: Icons.man_2_outlined, // Men's Shoes (أيقونة مختلفة قليلاً)
  200133142: Icons.woman_2_outlined, // Women's Shoes (أيقونة مختلفة قليلاً)
  // --- الحقائب والساعات والمجوهرات ---
  1524: Icons.shopping_bag_outlined, // Luggage & Bags
  152401: Icons.backpack_outlined, // Backpacks
  201336907:
      Icons.wallet_giftcard_outlined, // Women's Handbags (أيقونة محفظة نسائية)
  201337808: Icons.business_center_outlined, // Men's Bags (أيقونة حقيبة عمل)
  3803: Icons.account_balance_wallet_outlined, // Wallets & Holders
  1511: Icons.watch_outlined, // Watches
  36: Icons.diamond_outlined, // Jewelry & Accessories
  1509: Icons.star_outline, // Fashion Jewelry
  // --- اكسسوارات الملابس ---
  200000297: Icons.style_outlined, // Apparel Accessories
  200000440: Icons.surround_sound_rounded, // Eyewear & Accessories
  200000402: Icons.local_activity_outlined, // Hats & Caps
  200000298: Icons.square_foot_outlined, // Belts
  200000399: Icons.ac_unit_outlined, // Scarves & Wraps (استخدام أيقونة شتوية)
  // --- المنزل والمطبخ والحديقة ---
  15: Icons.home_outlined, // Home & Garden
  3710: Icons.chair_outlined, // Home Decor
  1541: Icons.kitchen_outlined, // Home Storage & Organization
  200000920: Icons.restaurant_menu_outlined, // Kitchen,Dining & Bar
  405: Icons.bed_outlined, // Home Textile
  13: Icons.build_outlined, // Home Improvement
  200066142: Icons.shower_outlined, // Bathroom Fixture
  // --- الجمال والصحة ---
  66: Icons.health_and_safety_outlined, // Beauty & Health
  200001187: Icons.content_cut_outlined, // Tools & Accessories
  100000616: Icons.face_retouching_natural_outlined, // Skin Care Tool
  200001168: Icons.brush_outlined, // Hair Care & Styling
  660103: Icons.auto_fix_high_outlined, // Makeup
  // --- ألعاب وهوايات ---
  26: Icons.toys_outlined, // Toys & Hobbies
  201292714: Icons.person_pin_circle_outlined, // Action & Toy Figures
  200001383: Icons.construction_outlined, // Building & Construction Toys
  200001385: Icons.gamepad_outlined, // Remote Control Toys
  // --- رياضة وتخييم ---
  18: Icons.sports_esports_outlined, // Sports & Entertainment
  100005529: Icons.hiking_outlined, // Camping & Hiking
  100005371: Icons.fitness_center_outlined, // Fitness & Body Building
  100005537: Icons.phishing_outlined, // Fishing
  // --- الأجهزة المنزلية والإضاءة ---
  6: Icons.blender_outlined, // Home Appliances
  100000041: Icons.coffee_maker_outlined, // Kitchen Appliances
  200165142: Icons.electrical_services_outlined, // Personal Care Appliances
  39: Icons.lightbulb_outline, // Lights & Lighting
  390503: Icons.flashlight_on_outlined, // Portable Lighting
  // --- السيارات والدراجات النارية ---
  34: Icons.directions_car_outlined, // Automobiles, Parts & Accessories
  200003411: Icons.event_seat_outlined, // Interior Accessories
  200003427: Icons.car_repair_outlined, // Exterior Accessories
  200000285: Icons.speaker_group_outlined, // Car Electronics
  201355758: Icons.two_wheeler_outlined, // Motorcycle Equipments & Parts
};
