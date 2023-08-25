import 'package:backend_flutter_ivo/bo/_enum_http_methods.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart' as retry;

Future<String> fetch(String domain, String path,
    {HttpMethods method = HttpMethods.get,
    String body = '',
    Map<String, String> query = const {}}) async {
  final client = retry.RetryClient(http.Client());
  String res = '[]';
  http.Response? httpRes;

  Uri uri = Uri.http(domain, path, query = query);

  final headers = {'Content-Type': 'application/json'};

  debugPrint(
      '\nHTTP path: $path, method : $method , query : $query, uri: $uri, body: $body');

  try {
    switch (method) {
      case HttpMethods.get:
        res = await client.read(uri, headers: headers);
        break;
      case HttpMethods.post:
        httpRes = await client.post(uri, headers: headers, body: body);
        res = httpRes.body;
        break;
      case HttpMethods.delete:
        httpRes = await client.delete(uri, headers: headers, body: body);
        res = httpRes.body;
        break;
      case HttpMethods.patch:
        httpRes = await client.patch(uri, headers: headers, body: body);
        res = httpRes.body;
        break;
    }
  } catch (e, stackTrace) {
    debugPrint('ClientException: ${e.toString()}');
    debugPrint('stack $stackTrace');
  } finally {
    client.close();
  }

  debugPrint('\nHTTP res: $res');

  return res;
}
