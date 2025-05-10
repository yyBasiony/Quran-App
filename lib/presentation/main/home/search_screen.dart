import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFD6EFE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF006400),
        title: const Text('البحث والتفسير', style: TextStyle(color: Colors.white)),
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
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => provider.searchAyahs(provider.controller.text),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const CircularProgressIndicator()
            else if (provider.errorMessage.isNotEmpty)
              Text(provider.errorMessage, style: const TextStyle(color: Colors.red))
            else if (provider.searchResults.isEmpty)
              const Text('لا توجد نتائج')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: provider.searchResults.length,
                  itemBuilder: (context, index) {
                    final ayah = provider.searchResults[index];
return Card(
  margin: const EdgeInsets.symmetric(vertical: 8),
  child: ListTile(
    title: Text(
      ayah.text,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
    ),
    subtitle: ayah.surah != null
        ? Text(
            '[${ayah.surah}]',
            textAlign: TextAlign.right,
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
