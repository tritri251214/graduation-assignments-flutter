import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:graduation_assignments_flutter/common/common.dart';

enum HttpMethod { get, post, patch, put, delete }

Future<dynamic> request(
  HttpMethod method,
  String path, {
  Object data = const {},
}) async {
  late http.Response response;

  Uri uri = Uri();
  try {
    if (Platform.isAndroid) {
      uri =
          Uri.parse('${AppStrings.androidAPIBase}:${AppStrings.apiPort}/$path');
    } else if (Platform.isIOS) {
      uri = Uri.parse('${AppStrings.iosAPIBase}:${AppStrings.apiPort}/$path');
    }
  } catch (e) {
    uri = Uri.parse('${AppStrings.iosAPIBase}:${AppStrings.apiPort}/$path');
  }

  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
    HttpHeaders.acceptHeader: ContentType.json.mimeType,
  };

  switch (method) {
    case HttpMethod.get:
      response = await http.get(uri, headers: headers);
      break;
    case HttpMethod.post:
      response = await http.post(
        uri,
        headers: headers,
        body: json.encode(data),
      );
      break;
    case HttpMethod.patch:
      response = await http.patch(
        uri,
        headers: headers,
        body: json.encode(data),
      );
      break;
    case HttpMethod.put:
      response = await http.put(
        uri,
        headers: headers,
        body: json.encode(data),
      );
      break;
    case HttpMethod.delete:
      response =
          await http.delete(uri, headers: headers, body: json.encode(data));
      break;
    }

  switch (response.statusCode) {
    case 200:
      return json.decode(response.body);
    case 201:
      return json.decode(response.body);
    case 204:
      return;
    default:
      throw response;
  }
}

Future<dynamic> get(String path) async => request(HttpMethod.get, path);

Future<dynamic> post(String path, {Object data = const {}}) async =>
    request(HttpMethod.post, path, data: data);

Future<dynamic> patch(String path, {Object data = const {}}) async =>
    request(HttpMethod.patch, path, data: data);

Future<dynamic> put(String path, {Object data = const {}}) async =>
    request(HttpMethod.put, path, data: data);

Future<dynamic> delete(String path, {Object data = const {}}) async =>
    request(HttpMethod.delete, path, data: data);
