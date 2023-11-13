import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

typedef OnUploadProgressCallback = void Function(double valueProgress);

class DHRemove {
  final Dio dio = Dio();
  Future<Uint8List?> bg(
    File file, {
    required OnUploadProgressCallback onUploadProgressCallback,
  }) async {
    String apiUrl = "https://api.remove.bg/v1.0/removebg";
    // String username = 'V4jfAbeYFHg58sEBazqAXzCM';
    // String password = '';
    // String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    String fileName = file.path.split('/').last;
    var formData = FormData.fromMap({
      'image_file': await MultipartFile.fromFile(file.path, filename: fileName),
      'size': "preview",
      'type': "car",
      'crop': true,
      'crop_margin': "10%"
    });
    try {
      Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {
            'X-API-Key': 'wvnApFz7Ve5mGozacyvpx9Cj',
            // 'Accept': 'image/png',
          },
          responseType: ResponseType.bytes,
        ),
        onSendProgress: (count, total) {
          double progress = count / total;
          onUploadProgressCallback(progress);
        },
      );
      final getApi = response.data;

      /// Received `Bytes` Response
      return getApi;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

  Future<String?> bg2(
    File file, {
    required OnUploadProgressCallback onUploadProgressCallback,
  }) async {
    String apiUrl = "https://background-removal4.p.rapidapi.com/v1/results";
    // String username = 'V4jfAbeYFHg58sEBazqAXzCM';
    // String password = '';
    // String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    String fileName = file.path.split('/').last;
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path, filename: fileName),
      // 'size': "preview",
      // 'type': "car",
      // 'crop': true,
      // 'crop_margin': "10%"
    });
    try {
      Response response = await dio.post(
        apiUrl,
        data: formData,
        queryParameters: {'mode': 'fg-image-shadow'},
        options: Options(
          headers: {
            'X-RapidAPI-Key':
                '8d8c5fce23mshc63744adbdf6536p11ff43jsnd95dddec3e79',
            'X-RapidAPI-Host': 'background-removal4.p.rapidapi.com',
            'content-type': 'application/x-www-form-urlencoded',
          },
          responseType: ResponseType.json,
        ),
        onSendProgress: (count, total) {
          double progress = count / total;
          onUploadProgressCallback(progress);
        },
      );
      final getApi = response.data["results"][0]["entities"][0]["image"];

      /// Received `Bytes` Response

      return getApi;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      debugPrint(e.message);
    }
    return null;
  }
}
