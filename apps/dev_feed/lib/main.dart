import 'package:async_image/async_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart' hide App;

import 'package:dev_feed/app.dart';
import 'package:dev_feed/posts_feed/cache/cache.dart';

void main() {
  final realmConfig = Configuration.local([
    RealmPost.schema,
    RealmUser.schema,
    RealmImageCache.schema,
  ]);
  final realm = Realm(realmConfig);

  final httpClient = http.Client();

  final dio = Dio();
  // dio.interceptors.add(InterceptorsWrapper(
  //   onRequest: (options, handler) {
  //     debugPrint('❔❔❔ Received reqeust for ${options.uri}');
  //     handler.next(options);
  //   },
  //   onResponse: (response, handler) {
  //     debugPrint('✅✅✅ Received response for ${response.realUri}');
  //     handler.next(response);
  //   },
  //   onError: (error, handler) {
  //     debugPrint(
  //         '❗️❗️❗️ Error for ${error.requestOptions.uri}: ${error.message}');
  //     handler.next(error);
  //   },
  // ));

  final app = App(
    client: httpClient,
    realm: realm,
    dio: dio,
  );

  runApp(app);
}
