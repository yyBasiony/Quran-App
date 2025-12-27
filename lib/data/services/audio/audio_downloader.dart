import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'audio_service.dart';

class AudioDownloader {
  static Future<Directory> _getAudioDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${dir.path}/quran_audio');
    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }
    return audioDir;
  }

  static Future<File> _getAudioFile(String filename) async {
    final audioDir = await _getAudioDirectory();
    return File('${audioDir.path}/$filename');
  }

  static Future<bool> _isValidAudioFile(File file) async {
    if (await file.exists()) {
      final fileSize = await file.length();
      return fileSize > 1000;
    }
    return false;
  }

  static Future<File?> _getValidCachedFile(String filename) async {
    final file = await _getAudioFile(filename);
    return await _isValidAudioFile(file) ? file : null;
  }

  static Future<String> getOrDownloadAudio(String audioUrl, String filename) async {
    final cachedFile = await _getValidCachedFile(filename);
    if (cachedFile != null) return cachedFile.path;

    final file = await _getAudioFile(filename);
    final response = await AudioService.fetchAudioFile(audioUrl);

    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    }

    throw Exception('Failed to download audio');
  }

  static Future<bool> isAudioDownloaded(String filename) async {
    return await _getValidCachedFile(filename) != null;
  }
}
