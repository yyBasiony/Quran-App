import 'package:flutter/material.dart';
import 'package:quran_app/models/ayah_model.dart';
import 'package:quran_app/services/quran_service.dart';

class SurahDetailsScreen extends StatefulWidget {
  final int surahNumber;

  SurahDetailsScreen({required this.surahNumber});

  @override
  _SurahDetailsScreenState createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  final QuranService _quranService = QuranService();
  List<AyahModel> _ayahs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAyahs();
  }

  Future<void> _loadAyahs() async {
    setState(() => _isLoading = true);
    _ayahs = await _quranService.fetchSurahAyahs(widget.surahNumber);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("سورة ${widget.surahNumber}")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _ayahs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_ayahs[index].text),
                );
              },
            ),
    );
  }
}
