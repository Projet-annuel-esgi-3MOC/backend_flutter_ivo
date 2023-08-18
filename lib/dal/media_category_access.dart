import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_enum_http_methods.dart';
import 'package:backend_flutter_ivo/bo/media_category.dart';
import 'package:backend_flutter_ivo/dal/_abst_dao.dart';
import 'package:backend_flutter_ivo/dal/http.dart';

class MediaCategoryAccess extends DAO<MediaCategory> {
  @override
  Future<bool> create(MediaCategory data) async {
    await fetch('localhost:3000', 'media-category',
        method: HttpMethods.post, body: data.toJson());
    return true;
  }

  @override
  Future<bool> delete(MediaCategory o) async {
    await fetch('localhost:3000', 'media-category',
        method: HttpMethods.delete, body: o.toJson());
    return true;
  }

  @override
  Future<MediaCategory> get(String id) async {
    var res = await fetch(
      'localhost:3000',
      'media-category/$id',
      method: HttpMethods.get,
    );

    return MediaCategory.fromMap(jsonDecode(res));
  }

  @override
  Future<List<MediaCategory>> getAll() async {
    var res = await fetch(
      'localhost:3000',
      'media-category',
      method: HttpMethods.get,
    );
    final List<dynamic> dataList = jsonDecode(res);

    return dataList.map((e) => MediaCategory.fromMap(e)).toList();
  }

  @override
  Future<bool> update(MediaCategory o) async {
    await fetch(
      'localhost:3000',
      'media-category/${o.id}',
      method: HttpMethods.patch,
      body: o.toJson(),
    );
    return true;
  }
}
