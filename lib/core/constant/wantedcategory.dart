import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const Map<int, IconData> categoryIcons = {
  2: FontAwesomeIcons.utensils, // Food
  3: FontAwesomeIcons.suitcase, // Luggage & Bags
  4: FontAwesomeIcons.shoePrints, // Shoes
  6: FontAwesomeIcons.blender, // Home Appliances
  7: FontAwesomeIcons.laptop, // Computer & Office
  13: FontAwesomeIcons.hammer, // Home Improvement
  15: FontAwesomeIcons.house, // Home & Garden
  18: FontAwesomeIcons.futbol, // Sports & Entertainment
  21: FontAwesomeIcons.school, // Office & School Supplies
  26: FontAwesomeIcons.puzzlePiece, // Toys & Hobbies
  30: FontAwesomeIcons.shield, // Security & Protection
  34: FontAwesomeIcons.car, // Automobiles, Parts & Accessories
  36: FontAwesomeIcons.gem, // Jewelry & Accessories
  39: FontAwesomeIcons.lightbulb, // Lights & Lighting
  44: FontAwesomeIcons.microchip, // Consumer Electronics
  66: FontAwesomeIcons.spa, // Beauty & Health
  320: FontAwesomeIcons.gift, // Weddings & Events
  322: FontAwesomeIcons.shoePrints, // Shoes
  502: FontAwesomeIcons.microchip, // Electronic Components & Supplies
  509: FontAwesomeIcons.mobile, // Phones & Telecommunications
  1420: FontAwesomeIcons.screwdriverWrench, // Tools
  1501: FontAwesomeIcons.baby, // Mother & Kids
  1503: FontAwesomeIcons.chair, // Furniture
  1511: FontAwesomeIcons.clock, // Watches
  1524: FontAwesomeIcons.deleteLeft, // Luggage & Bags
  200574005: FontAwesomeIcons.shirt, // Underwear / Clothing
  201169612: FontAwesomeIcons.cloud, // Virtual Products
  202216001: FontAwesomeIcons.industry, // Industrial & Business
  201768104:
      FontAwesomeIcons.basketball, // Sports Shoes, Clothing & Accessories
  202192403:
      FontAwesomeIcons.headset, // Phones & Telecommunications Accessories
  200000345: FontAwesomeIcons.personDress, // Women's Clothing
  200000343: FontAwesomeIcons.person, // Men's Clothing
  200000297: FontAwesomeIcons.ring, // Apparel Accessories
  200165144: FontAwesomeIcons.scissors, // Hair Extensions & Wigs
  200001075: FontAwesomeIcons.star, // Special Category
  202228412: FontAwesomeIcons.book, // Books & Cultural Merchandise
  200000532: FontAwesomeIcons.gift, // Novelty & Special Use
  201520802: FontAwesomeIcons.recycle, // Second-Hand
  201355758: FontAwesomeIcons.motorcycle, // Motorcycle Equipments & Parts
  0: FontAwesomeIcons.shirt, // Clothing (default)
  88888888: FontAwesomeIcons.tableCellsLarge, // Other / Category
  // 👇 الأيقونات الجديدة اللي طلعت في الكونسول:
  66666666: Icons.apps, // All — استخدمت أيقونة Material لأنها عامة
  202115202: FontAwesomeIcons.shirt, // Men’s T-Shirt Sets
  127734143: FontAwesomeIcons.shirt, // Men's T-Shirts
  202116201: FontAwesomeIcons.shirt, // Men’s Shirt Sets
  202116101:
      FontAwesomeIcons.shirt, // Men’s Outerwear Sets — لو مفيش، شوف البديل تحت
  202115801: FontAwesomeIcons.shirt, // Men’s Hoodies&Sweatshirt Sets — بديل
  127734132: FontAwesomeIcons.shirt, // Men's Hoodies & Sweatshirts — بديل
  201270276: FontAwesomeIcons.personRunning, // Tracksuits
  348: FontAwesomeIcons.shirt, // Men's Shirts
  201606802: FontAwesomeIcons.child, // Boys clothing sets
  201273171: FontAwesomeIcons.shirt, // Active Tops
  201756202:
      FontAwesomeIcons.kaaba, // Traditional Muslim Clothing & Accessories
  127654037: FontAwesomeIcons.syringe, // Injection Valves
  201150601: FontAwesomeIcons.personDress, // Women's Sets
  100005790: FontAwesomeIcons.briefcase, // Career Dresses
  1355: FontAwesomeIcons.industry, // Construction Machinery Parts
  201969301: FontAwesomeIcons.microchip, // Specialized ICs
  14190101: FontAwesomeIcons.plug, // Connectors
  100005791: FontAwesomeIcons.shirt, // Casual Dresses
  32004: FontAwesomeIcons.gem, // Evening Dresses
};

IconData getCategoryIcon(int id) => categoryIcons[id] ?? Icons.category;
