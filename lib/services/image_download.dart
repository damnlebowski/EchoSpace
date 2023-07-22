import 'dart:io';
import 'package:dio/dio.dart';

class DownloadImage{

Future<void> downloadImageFromFirebase(String imageUrl) async {
  try {
    Dio dio = Dio();

    String downloadDir = await _getCustomDownloadDirectory();

    String fileName = imageUrl.split('=').last;
    String savePath = '$downloadDir/$fileName.jpg';

    await dio.download(imageUrl, savePath);

    print('Image downloaded: $savePath');
  } catch (e) {
    print('Error downloading image: $e');
  }
}

Future<String> _getCustomDownloadDirectory() async {
  final downloadsDirectory = Directory('/storage/emulated/0/DCIM/EchoSpace');

  if (!await downloadsDirectory.exists()) {
    await downloadsDirectory.create(recursive: true);
  }

  return downloadsDirectory.path;
}

}