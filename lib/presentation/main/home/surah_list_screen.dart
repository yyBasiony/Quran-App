import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:provider/provider.dart';
import 'package:qanet/presentation/main/home/widgets/surah_card.dart';
import 'package:qanet/providers/surah_provider.dart';
import 'package:qanet/presentation/resources/app_colors.dart';

class SurahListScreen extends StatelessWidget {
  const SurahListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Al-Quran',
          style: theme.textTheme.titleLarge?.copyWith(color: AppColors.white),
        ),
      ),
      body: Consumer<SurahProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن سورة...',
                    prefixIcon: Icon(Icons.search, color: AppColors.primary, size: 24.sp), // ✅ حجم أيقونة مرن
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
                    ),
                  ),
                  onChanged: provider.filterSurahs,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.surahs.length,
                  itemBuilder: (context, index) {
                    final surah = provider.surahs[index];
                    return SurahCard(surah: surah);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
