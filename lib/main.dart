// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:quran_app/models/ayah_model.dart';
// import 'package:quran_app/models/surah_model.dart';
// import 'package:quran_app/services/quran_service.dart';
// import 'package:quran_app/surah_details.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(SurahModelAdapter());
//   Hive.registerAdapter(AyahModelAdapter());

//   await Hive.openBox<SurahModel>('surahs');
//   await Hive.openBox<List<AyahModel>>('ayahs');

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: SurahListScreen(),
//     );
//   }
// }

// class SurahListScreen extends StatefulWidget {
//   const SurahListScreen({super.key});

//   @override
//   _SurahListScreenState createState() => _SurahListScreenState();
// }

// class _SurahListScreenState extends State<SurahListScreen> {
//   final QuranService _quranService = QuranService();
//   List<SurahModel> _surahs = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadSurahs();
//   }

//   Future<void> _loadSurahs() async {
//     try {
//       final surahs = await _quranService.fetchSurahs();
//       setState(() {
//         _surahs = surahs;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Surah List')),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _surahs.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_surahs[index].name),
//                   subtitle: Text(_surahs[index].englishName),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SurahDetailsScreen(
//                           surahNumber: _surahs[index].number,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  runApp(
    const IslamicApp(),
  );
}
