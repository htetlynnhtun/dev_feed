import 'package:dev_feed/async_image/view/async_image_view.dart';
import 'package:dev_feed/async_image/viewmodel/async_image_view_model.dart';
import 'package:dev_feed/bookmark/cache/in_memory_bookmark_sotre.dart';
import 'package:dev_feed/bookmark/model/bookmark_creator.dart';
import 'package:dev_feed/bookmark/model/bookmark_deleter.dart';
import 'package:dev_feed/bookmark/view/bookmark_button_view.dart';
import 'package:dev_feed/bookmark/view/bookmark_page.dart';
import 'package:dev_feed/bookmark/viewmodel/bookmark_item_view_model.dart';
import 'package:dev_feed/posts_feed/model/post.dart';
import 'package:dev_feed/posts_feed/view/post_item_view.dart';
import 'package:dev_feed/posts_feed/view/posts_list_view.dart';
import 'package:dev_feed/posts_feed/viewmodel/post_item_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart' hide App;

import 'package:dev_feed/async_image/api/remote_image_data_loader.dart';
import 'package:dev_feed/async_image/cache/local_image_data_loader.dart';
import 'package:dev_feed/async_image/cache/realm_image_data_store.dart';
import 'package:dev_feed/post_detail/api/remote_post_details_loader.dart';
import 'package:dev_feed/post_detail/post_detail_ui_composer.dart';
import 'package:dev_feed/posts_feed/api/api.dart';
import 'package:dev_feed/posts_feed/cache/cache.dart';
import 'package:dev_feed/posts_feed/posts_feed_ui_composer.dart';
import 'package:dev_feed/util/image_data_loader_cache_decorator.dart';
import 'package:dev_feed/util/image_data_loader_with_fallback_composite.dart';
import 'package:dev_feed/util/post_loader_cache_decorator.dart';
import 'package:dev_feed/util/post_loader_with_fallback_composite.dart';

void main() {
  final realmConfig = Configuration.local([
    RealmPost.schema,
    RealmUser.schema,
    RealmImageCache.schema,
  ]);
  final realm = Realm(realmConfig);

  final httpClient = http.Client();

  final remotePostLoader = RemotePostLoader(client: httpClient);

  final postStore = RealmPostStore(realm: realm);

  final localPostLoader = LocalPostLoader(postStore: postStore);

  final postLoaderComposite = PostLoaderWithFallbackComposite(
    primary: PostLoaderCacheDecorator(
      decoratee: remotePostLoader,
      cache: localPostLoader,
    ),
    fallback: localPostLoader,
  );

  final imageDataStore = RealmImageDataStore(realm);

  final localImageDataLoader = LocalImageDataLoader(imageDataStore);

  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      debugPrint('❔❔❔ Received reqeust for ${options.uri}');
      handler.next(options);
    },
    onResponse: (response, handler) {
      debugPrint('✅✅✅ Received response for ${response.realUri}');
      handler.next(response);
    },
    onError: (error, handler) {
      debugPrint(
          '❗️❗️❗️ Error for ${error.requestOptions.uri}: ${error.message}');
      handler.next(error);
    },
  ));

  final remoteImageDataLoader = RemoteImageDataLoader(dio);

  final imageDataLoaderComposite = ImageDataLoaderWithFallbackComposite(
    primary: localImageDataLoader,
    fallback: ImageDataLoaderCacheDecorator(
      decoratee: remoteImageDataLoader,
      cache: localImageDataLoader,
    ),
  );

  final postDetailsLoader = RemotePostDetailsLoader(dio: dio);

  final bookmarkStore = InMemoryBookmarkSotre();
  final bookmarkCreator = BookmarkCreatorImpl(bookmarkStore);
  final bookmarkDeleter = BookmarkDeleterImpl(bookmarkStore);

  postListView(BuildContext context, List<Post> posts) => PostsListView(
        key: const ValueKey('bookmarked-post-list-view'),
        posts: posts,
        itemView: (context, post) => PostItemView(
          key: ValueKey(post.id),
          postViewModel: PostItemViewModel(post),
          onTap: (id) => context.go('/posts/$id'),
          asyncImageView: (context, url) => AsyncImageView(
            key: ValueKey(url),
            imageUrl: url,
            viewModelFactory: (url) => AsyncImageViewModel(
              imageURL: url,
              dataLoader: imageDataLoaderComposite,
            ),
          ),
          bookmarkButtonView: (context) => BookmarkButtonView(
            viewModelFactory: () => BookmarkItemViewModel(
              post: post,
              loader: bookmarkStore.retrieveAll,
              creator: bookmarkCreator,
              deleter: bookmarkDeleter,
            ),
          ),
        ),
      );

  final router = GoRouter(
    initialLocation: '/posts',
    routes: [
      GoRoute(
        path: '/posts',
        builder: (context, state) => FeedUIComposer.feedPage(
          postLoaderComposite,
          postListView,
        ),
        routes: [
          GoRoute(
            path: ':postId',
            builder: (context, state) {
              final postId = int.parse(state.pathParameters['postId']!);
              return PostDetailUIComposer.detailPage(
                postId,
                postDetailsLoader,
                imageDataLoaderComposite,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/bookmarks',
        builder: (context, state) => BookmarkPageComposer.compose(
          bookmarkLoader: bookmarkStore.retrieveAll,
          postListView: postListView,
        ),
      ),
    ],
    debugLogDiagnostics: kDebugMode,
  );

  runApp(
    MaterialApp.router(
      routerConfig: router,
    ),
  );
}
