import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const Map<int, IconData> categoryIcons = {
  2: FontAwesomeIcons.utensils, // Food
  3: FontAwesomeIcons.suitcase, // Luggage & Bags
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
  1511: FontAwesomeIcons.clock, // Watches (represented by clock)
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
  4: FontAwesomeIcons.shoePrints, // Shoes (duplicate for ID 4)
  88888888: FontAwesomeIcons.tableCellsLarge, // Other / Category
};

IconData getCategoryIcon(int id) => categoryIcons[id] ?? Icons.category;
