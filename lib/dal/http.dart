import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart' as retry;

Future<String> fetch(String domain, String path) async {
  final client = retry.RetryClient(http.Client());
  String res = '[]';

  try {
    res = await client.read(Uri.http(domain, path));
    debugPrint(res);
  } catch (e, stackTrace) {
    debugPrint('ClientException: ${e.toString()}');
    debugPrint('stack $stackTrace');
  } finally {
    client.close();
  }

  return res;
}
