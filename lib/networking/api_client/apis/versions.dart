import 'dart:async';
import 'package:dio/dio.dart';

import '../../../includes.dart';

class VersionsApi {
  final Dio _http;

  var _versionId;

  VersionsApi(this._http);

  void setVersionId(id) {
    this._versionId = id;
  }

  Future<List<Version>> list() async {
    final response = await _http.get('/versions');

    List<Version> list = (response.data as List)
        .map(
          (e) => Version.fromJson(e),
        )
        .toList();
    return list;
  }

  Future<Version> get() async {
    final response = await _http.get('/versions/$_versionId');

    var d = Version.fromJson(response.data);
    return d;
  }
}
