import 'dart:async';

import 'package:async_image/async_image.dart';
import 'package:dev_feed/posts_feed/api/posts_endpoint.dart';
import 'package:dev_feed/posts_feed/api/posts_mapper.dart';
import 'package:dev_feed/posts_feed/cache/local_post_loader.dart';
import 'package:dev_feed/posts_feed/cache/realm_post_store.dart';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/model/paginated_posts.dart';
import 'package:dev_feed/util/pipelines.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart';
import 'package:rxdart/rxdart.dart';

final realmConfig = Configuration.local([
  RealmPost.schema,
  RealmUser.schema,
  RealmImageCache.schema,
]);
final realm = Realm(realmConfig);
final localPostLoader = LocalPostLoader(
  postStore: RealmPostStore(realm: realm),
);

Stream<PaginatedPosts> makeRemotePostLoaderWithLocalFallback() {
  return makeRemotePostsLoader(page: 1)
      .cacheTo(localPostLoader)
      .fallbackTo(localPostLoader.loadStream())
      .map((posts) => (
            page: 1,
            mergedPosts: posts,
            newPosts: posts,
          ))
      .map(makePage)
      .delay(const Duration(seconds: 2));
}

PaginatedPosts makePage(
    ({
      int page,
      List<Post> mergedPosts,
      List<Post> newPosts,
    }) data) {
  return PaginatedPosts(
    posts: data.mergedPosts,
    loadMore: data.newPosts.isNotEmpty
        ? () => makeRemoteMorePostsLoader(page: data.page + 1)
        : null,
  );
}

Stream<List<Post>> makeRemotePostsLoader({required int page}) {
  var url = PostsEndpoint.get(page).url('https://dev.to/api');
  return http.Client()
      .get(url) //
      .asStream()
      .map(PostsMapper.map);
}

Stream<PaginatedPosts> makeRemoteMorePostsLoader({required int page}) {
  return makeRemotePostsLoader(page: page)
      .zipWith(
        localPostLoader.loadStream(),
        (posts, cachedPosts) => (
          page: page,
          mergedPosts: cachedPosts + posts,
          newPosts: posts,
        ),
      )
      .map(makePage)
      .cacheTo(localPostLoader)
      .delay(const Duration(seconds: 2));
}

class PaginatedPostsNotifier extends StateNotifier<AsyncValue<PaginatedPosts>> {
  final Stream<PaginatedPosts> Function() postsStream;

  PaginatedPostsNotifier(this.postsStream) : super(const AsyncLoading());

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  StreamSubscription? _subscription;

  Future<void> load() {
    final loadOperation = Completer();
    _subscription?.cancel();
    _subscription =
        postsStream().doOnDone(() => loadOperation.complete()).listen(
              _onData,
              onError: _onError,
            );
    return loadOperation.future;
  }

  void Function()? loadMorePosts;

  void _onData(PaginatedPosts data) {
    state = AsyncData(data);
    final loadMore = data.loadMore;
    if (loadMore != null) {
      loadMorePosts = () {
        _subscription?.cancel();
        _subscription = loadMore().listen(
              _onData,
              onError: _onError,
            );
      };
    } else {
      loadMorePosts = null;
    }
  }

  void _onError(Object e, StackTrace s) {
    state = AsyncError(e, s);
  }
}

final paginatedPostsNotifierProvider =
    StateNotifierProvider<PaginatedPostsNotifier, AsyncValue<PaginatedPosts>>(
        (ref) {
  return PaginatedPostsNotifier(makeRemotePostLoaderWithLocalFallback)..load();
});
