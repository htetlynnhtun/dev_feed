import 'dart:async';

import 'package:async_image/async_image.dart';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/model/paginated_posts.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

extension PostLoaderPipeline on PostLoader {
  Stream<List<Post>> loadStream() => Stream.fromFuture(load());
}

extension FallbackPipeline<T> on Stream<T> {
  Stream<T> fallbackTo(Stream<T> fallbackEmitter) =>
      onErrorResumeNext(fallbackEmitter);
}

extension PostsCachePipeline on Stream<List<Post>> {
  Stream<List<Post>> cacheTo(PostCache cache) => doOnData(cache.save);
}

extension PaginatedPostsCachePipeline on Stream<PaginatedPosts> {
  Stream<PaginatedPosts> cacheTo(PostCache cache) =>
      doOnData((paginated) => cache.save(paginated.posts));
}

extension ImageDataLoaderPipeline on ImageDataLoader {
  Stream<Uint8List> loadStream(Uri url) {
    StreamSubscription? subscription;
    final controller = StreamController<Uint8List>();
    controller.onListen = () {
      subscription = load(url).asStream().listen(
            controller.add,
            onError: controller.addError,
          );
    };  
    controller.onCancel = subscription?.cancel;
    return controller.stream;
  }
}

extension ImageDataCachePipeline on Stream<Uint8List> {
  Stream<Uint8List> cacheTo(ImageDataCache cache, Uri url) =>
      doOnData((data) => cache.save(data, url));
}
