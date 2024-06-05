import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:dio/dio.dart';

import 'package:dev_feed/async_image/model/image_data_loader.dart';

class RemoteImageDataLoader implements ImageDataLoader {
  final Dio _dio;

  RemoteImageDataLoader(this._dio);

  @override
  CancelableOperation<Uint8List> load(Uri url) {
    final cancelToken = CancelToken();
    return CancelableOperation.fromFuture(
      () async {
        final response = await _dio.getUri(
          url,
          cancelToken: cancelToken,
          options: Options(responseType: ResponseType.bytes),
        );
        return Uint8List.fromList(response.data);
      }(),
      onCancel: cancelToken.cancel,
    );
  }
}
