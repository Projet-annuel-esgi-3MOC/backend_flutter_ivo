import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_enum_http_methods.dart';
import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/dal/http.dart';

abstract class DAO<T> {
  Future<bool> create(T data);
  Future<T> get(String id);
  Future<List<T>> getAll();
  Future<bool> update(T o);
  Future<bool> delete(T o);
}

class Access<T extends Firebaseable> extends DAO<T> {
  final T Function(Map<String, dynamic>) instanceCreator;
  String collectionName;

  Access({required this.instanceCreator, required this.collectionName});

  @override
  Future<bool> create(T data) async {
    await fetch('localhost:3000', 'crud/$collectionName',
        method: HttpMethods.post, body: jsonEncode(data));
    return true;
  }

  @override
  Future<bool> delete(T o) async {
    await fetch('localhost:3000', 'crud/$collectionName/${o.id}',
        method: HttpMethods.delete);
    return true;
  }

  @override
  Future<T> get(String id) async {
    var res = await fetch(
      'localhost:3000',
      'crud/$collectionName/$id',
      method: HttpMethods.get,
    );

    return instanceCreator(jsonDecode(res));
  }

  @override
  Future<List<T>> getAll() async {
    var res = await fetch(
      'localhost:3000',
      'crud/$collectionName',
      method: HttpMethods.get,
    );
    final List<dynamic> dataList = jsonDecode(res);

    return dataList.map((e) => instanceCreator(e)).toList();
  }

  @override
  Future<bool> update(T o) async {
    await fetch(
      'localhost:3000',
      'crud/$collectionName/${o.id}',
      method: HttpMethods.patch,
      body: jsonEncode(o),
    );
    return true;
  }
}
