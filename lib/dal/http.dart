import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart' as retry;

Future<String> fetch(String domain, String path) async {
  final client = retry.RetryClient(http.Client());
  String res = '[]';
  try {
    var get = await client.get(Uri.http(domain, path));
    if(get.statusCode == HttpStatus.ok) {
      res = get.body;
      debugPrint('Response $res');
    } else {
      debugPrint('Error hapenned ${get.statusCode}');
    }
    
  } 
  catch (e, stackTrace) {
    debugPrint('Error hapenned $e');
    debugPrint('stack $stackTrace');
    debugPrintStack();
  }
  finally {
    client.close();
  }

  return res;
}
