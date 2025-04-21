// import 'package:flutter/material.dart';
// import 'package:quran_app/models/search_ayah_model.dart';
// import 'package:quran_app/services/quran_service.dart';
// import 'package:quran_app/services/tafsir_service.dart';

// class AyahSearchBar extends StatefulWidget {
//   const AyahSearchBar({super.key});

//   @override
//   State<AyahSearchBar> createState() => _AyahSearchBarState();
// }

// class _AyahSearchBarState extends State<AyahSearchBar> {
//   final TextEditingController _controller = TextEditingController();
//   final QuranService _quranService = QuranService();
//   final TafsirService _tafsirService = TafsirService();

//   List<SearchAyahModel> searchResults = [];
//   bool isSearching = false;

// void search(String query) async {
//   if (query.isEmpty) return;
//   setState(() {
//     isSearching = true;
//   });
//   final results = await _quranService.searchAyah(query);
//   print(" ${results.length}");
//   for (var ayah in results) {
//     print(" ${ayah.text}");
//   }
//   setState(() {
//     searchResults = results;
//     isSearching = false;
//   });
// }

//   void showTafsirDialog(int surah, int ayah) async {
//     final tafsir = await _tafsirService.fetchTafsir(surah, ayah);
//     if (tafsir != null) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text("التفسير"),
//           content: Text(tafsir.text),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("إغلاق"),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SearchAnchor.bar(
//           barHintText: 'ابحث عن آية...',
//           barTrailing: const [Icon(Icons.search)],
//           suggestionsBuilder: (context, controller) {
//             return [];
//           },
//           viewLeading: IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               _controller.clear();
//               setState(() {
//                 searchResults = [];
//               });
//             },
//           ),
//           barBackgroundColor: MaterialStatePropertyAll(Colors.white),
//           barElevation: MaterialStatePropertyAll(2),
//           onTap: () => search(_controller.text),
//           onSubmitted: (value) => search(value),
//         ),
//         const SizedBox(height: 16),
//         if (isSearching) const CircularProgressIndicator(),
//         if (!isSearching && searchResults.isNotEmpty)
//           ...searchResults.map((result) {
//             return Container(
//               margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.teal.shade50,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.teal),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(result.text, style: const TextStyle(fontSize: 16)),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           if (result.surah != null && result.ayah != null) {
//                             showTafsirDialog(result.surah!, result.ayah!);
//                           }
//                         },
//                         child: const Text("التفسير"),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//       ],
//     );
//   }
// }
