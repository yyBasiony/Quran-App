import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const List<String> cities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Mansoura',
    'Asyut',
    'Tanta',
    'Zagazig',
    'Suez',
    'Ismailia',
    'Fayoum',
    'Beni Suef',
    'Minya',
    'Sohag',
    'Qena',
    'Luxor',
    'Aswan',
    'Damietta',
    'Port Said',
    'Sharm El-Sheikh',
    'Hurghada',
    'Damanhur',
    'Kafr El Sheikh',
    'Mallawi',
    'Banha',
    'Arish',
    'Matruh',
    'Qalyub',
    'Banha',
    'Desouk',
    '6th of October',
    'Obour',
    'New Cairo',
    'Helwan'
  ];


  static const List<BottomNavBarData> bottomNavBarData = [
    (label: 'الرئيسية', icon: Icons.home),
    (label: 'القرآن', icon: Icons.menu_book),
    (label: 'بحث', icon: Icons.search),
    (label: 'الإعدادات', icon: Icons.settings),
  ];
}

typedef BottomNavBarData = ({String label, IconData icon});
