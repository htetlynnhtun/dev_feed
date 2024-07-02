import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dev_feed/post_detail/model/model.dart';
import 'package:dev_feed/shared/model/model.dart';

part 'post_details_dto.dart';
part 'remote_post_details_loader.freezed.dart';
part 'remote_post_details_loader.g.dart';

final class RemotePostDetailsLoader implements PostDetailsLoader {
  final Dio _dio;

  RemotePostDetailsLoader({required Dio dio}) : _dio = dio;

  static const _url = 'https://dev.to/api/articles';

  @override
  CancelableOperation<PostDetails> load(int postId) {
    final cancelToken = CancelToken();
    return CancelableOperation.fromFuture(
      () async {
        final response = await _dio.get(
          '$_url/$postId',
          cancelToken: cancelToken,
        );
        final dto = PostDetailsDto.fromJson(response.data);
        return dto.toDomain();
      }(),
      onCancel: cancelToken.cancel,
    );
  }
}
