import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/presentation/resources/app_colors.dart';
import '../../../providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar:
          AppBar(backgroundColor: theme.primaryColor, title: Text('البحث ', style: TextStyle(color: AppColors.onPrimary, fontSize: 20.sp))),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(children: [
          TextField(
              controller: provider.controller,
              onSubmitted: provider.searchAyahs,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                  hintText: 'ابحث عن آية...',
                  hintStyle: theme.textTheme.bodyMedium,
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: theme.primaryColor, size: 24.sp),
                      onPressed: () => provider.searchAyahs(provider.controller.text)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: theme.primaryColor)))),
          SizedBox(height: 16.h),
          if (provider.isLoading)
            const CircularProgressIndicator()
          else if (provider.errorMessage.isNotEmpty)
            Text(
              provider.errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            )
          else if (provider.searchResults.isEmpty)
            Text(
              'لا توجد نتائج',
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
            )
          else
            Expanded(
                child: ListView.builder(
                    itemCount: provider.searchResults.length,
                    itemBuilder: (context, index) {
                      final ayah = provider.searchResults[index];
                      return Card(
                          color: theme.cardColor,
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          child: ListTile(
                            title: Text(
                              ayah.text,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
                            ),
                            subtitle: ayah.surah != null
                                ? Text('[${ayah.surah}]', textAlign: TextAlign.right, style: theme.textTheme.bodySmall?.copyWith(fontSize: 13.sp))
                                : null,
                          ));
                    }))
        ]),
      ),
    );
  }
}
