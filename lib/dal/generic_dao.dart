import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_enum_http_methods.dart';
import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/dal/_abst_dao.dart';
import 'package:backend_flutter_ivo/dal/http.dart';

class Access<T extends Firebaseable> extends DAO<T> {
  final T Function(String) instanceCreator;
  String collectionName;

  Access({required this.instanceCreator, required this.collectionName});

  @override
  Future<bool> create(T data) async {
    await fetch('localhost:3000', collectionName,
        method: HttpMethods.post, body: data.toJson());
    return true;
  }

  @override
  Future<bool> delete(T o) async {
    await fetch('localhost:3000', '$collectionName/${o.id}',
        method: HttpMethods.delete, body: o.toJson());
    return true;
  }

  @override
  Future<T> get(String id) async {
    var res = await fetch(
      'localhost:3000',
      '$collectionName/$id',
      method: HttpMethods.get,
    );

    return instanceCreator(res);
  }

  @override
  Future<List<T>> getAll() async {
    var res = await fetch(
      'localhost:3000',
      collectionName,
      method: HttpMethods.get,
    );
    final List<dynamic> dataList = jsonDecode(res);

    return dataList.map((e) => instanceCreator(e)).toList();
  }

  @override
  Future<bool> update(T o) async {
    await fetch(
      'localhost:3000',
      '$collectionName/${o.id}',
      method: HttpMethods.patch,
      body: o.toJson(),
    );
    return true;
  }
}
