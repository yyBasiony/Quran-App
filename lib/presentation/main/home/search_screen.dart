import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/presentation/resources/app_colors.dart';
import '../../../providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text(
          'البحث والتفسير',
          style: TextStyle(color: AppColors.onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: provider.controller,
              onSubmitted: provider.searchAyahs,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'ابحث عن آية...',
                hintStyle: theme.textTheme.bodyMedium,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: theme.primaryColor),
                  onPressed: () => provider.searchAyahs(provider.controller.text),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const CircularProgressIndicator()
            else if (provider.errorMessage.isNotEmpty)
              Text(
                provider.errorMessage,
                style: const TextStyle(color: Colors.red),
              )
            else if (provider.searchResults.isEmpty)
              Text(
                'لا توجد نتائج',
                style: theme.textTheme.bodyMedium,
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: provider.searchResults.length,
                  itemBuilder: (context, index) {
                    final ayah = provider.searchResults[index];
                    return Card(
                      color: theme.cardColor,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          ayah.text,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: theme.textTheme.bodyLarge,
                        ),
                        subtitle: ayah.surah != null
                            ? Text(
                                '[${ayah.surah}]',
                                textAlign: TextAlign.right,
                                style: theme.textTheme.bodySmall,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
