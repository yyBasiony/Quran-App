import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AudioDownloader {
  static Future<String> getOrDownloadAudio(String audioUrl, String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${dir.path}/quran_audio');

    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }

    final filePath = '${audioDir.path}/$filename';
    final file = File(filePath);

    if (await file.exists()) {
      final fileSize = await file.length();
      if (fileSize > 1000) return filePath;
    }

    final response = await http.get(Uri.parse(audioUrl));
    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception('Failed to download audio');
    }
  }

  static Future<bool> isAudioDownloaded(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${dir.path}/quran_audio');
    final filePath = '${audioDir.path}/$filename';
    final file = File(filePath);

    if (await file.exists()) {
      final fileSize = await file.length();
      return fileSize > 1000;
    }
    return false;
  }
}
