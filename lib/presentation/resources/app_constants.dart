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
    'Desouk',
    '6th of October',
    'Obour',
    'New Cairo',
    'Helwan'
  ];

  static const Map<String, String> cityNamesArabic = {
    'Cairo': 'القاهرة',
    'Alexandria': 'الإسكندرية',
    'Giza': 'الجيزة',
    'Mansoura': 'المنصورة',
    'Asyut': 'أسيوط',
    'Tanta': 'طنطا',
    'Zagazig': 'الزقازيق',
    'Suez': 'السويس',
    'Ismailia': 'الإسماعيلية',
    'Fayoum': 'الفيوم',
    'Beni Suef': 'بني سويف',
    'Minya': 'المنيا',
    'Sohag': 'سوهاج',
    'Qena': 'قنا',
    'Luxor': 'الأقصر',
    'Aswan': 'أسوان',
    'Damietta': 'دمياط',
    'Port Said': 'بورسعيد',
    'Sharm El-Sheikh': 'شرم الشيخ',
    'Hurghada': 'الغردقة',
    'Damanhur': 'دمنهور',
    'Kafr El Sheikh': 'كفر الشيخ',
    'Mallawi': 'ملوي',
    'Banha': 'بنها',
    'Arish': 'العريش',
    'Matruh': 'مطروح',
    'Qalyub': 'قليوب',
    'Desouk': 'دسوق',
    '6th of October': '٦ أكتوبر',
    'Obour': 'العبور',
    'New Cairo': 'القاهرة الجديدة',
    'Helwan': 'حلوان'
  };

  static const List<BottomNavBarData> bottomNavBarData = [
    (label: 'الرئيسية', icon: Icons.home),
    (label: 'القرآن', icon: Icons.menu_book),
    (label: 'بحث', icon: Icons.search),
    (label: 'الإعدادات', icon: Icons.settings),
  ];
}
typedef BottomNavBarData = ({String label, IconData icon});
