import 'package:dev_feed/bookmark/view/bookmark_page.dart';
import 'package:dev_feed/post_detail/api/remote_post_details_loader.dart';
import 'package:dev_feed/post_detail/post_detail_ui_composer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart';

import 'package:dev_feed/async_image/api/remote_image_data_loader.dart';
import 'package:dev_feed/async_image/cache/local_image_data_loader.dart';
import 'package:dev_feed/async_image/cache/realm_image_data_store.dart';
import 'package:dev_feed/async_image/model/image_data_loader.dart';
import 'package:dev_feed/async_image/view/async_image_view.dart';
import 'package:dev_feed/async_image/viewmodel/async_image_view_model.dart';
import 'package:dev_feed/bookmark/cache/bookmark_store.dart';
import 'package:dev_feed/bookmark/cache/in_memory_bookmark_sotre.dart';
import 'package:dev_feed/bookmark/model/bookmark_creator.dart';
import 'package:dev_feed/bookmark/model/bookmark_deleter.dart';
import 'package:dev_feed/bookmark/view/bookmark_button_view.dart';
import 'package:dev_feed/bookmark/viewmodel/bookmark_item_view_model.dart';
import 'package:dev_feed/posts_feed/api/remote_post_loader.dart';
import 'package:dev_feed/posts_feed/cache/cache.dart';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/posts_feed_ui_composer.dart';
import 'package:dev_feed/posts_feed/view/post_item_view.dart';
import 'package:dev_feed/posts_feed/view/posts_list_view.dart';
import 'package:dev_feed/posts_feed/viewmodel/post_item_view_model.dart';
import 'package:dev_feed/util/image_data_loader_cache_decorator.dart';
import 'package:dev_feed/util/image_data_loader_with_fallback_composite.dart';
import 'package:dev_feed/util/post_loader_cache_decorator.dart';
import 'package:dev_feed/util/post_loader_with_fallback_composite.dart';

class App extends StatelessWidget {
  final http.Client client;
  final Realm realm;
  final Dio dio;

  const App({
    super.key,
    required this.client,
    required this.realm,
    required this.dio,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

extension on App {
  RouterConfig<Object> get router {
    return GoRouter(
      initialLocation: '/posts',
      routes: [
        GoRoute(
          path: '/posts',
          builder: (context, state) => FeedUIComposer.feedPage(
            postLoader,
            (BuildContext context, List<Post> posts) {
              return PostsListView(
                key: const ValueKey('posts-list-view'),
                posts: posts,
                itemView: (context, post) => postItemView(context, post),
              );
            },
          ),
          routes: [
            GoRoute(
              path: ':postId',
              builder: (context, state) {
                final postId = int.parse(state.pathParameters['postId']!);
                return PostDetailUIComposer.detailPage(
                  postId,
                  RemotePostDetailsLoader(dio: dio),
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
            postListView: (BuildContext context, List<Post> posts) {
              return PostsListView(
                key: const ValueKey('bookmarked-posts-list-view'),
                posts: posts,
                itemView: (context, post) => postItemView(context, post),
              );
            },
          ),
        ),
      ],
      debugLogDiagnostics: kDebugMode,
    );
  }
}

extension on App {
  PostItemView postItemView(BuildContext context, Post post) {
    return PostItemView(
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
    );
  }
}

extension on App {
  static final _postLoader = Expando<PostLoader>('PostLoader');
  PostLoader get postLoader {
    if (_postLoader[this] == null) {
      var localPostLoader = LocalPostLoader(
        postStore: RealmPostStore(realm: realm),
      );
      _postLoader[this] = PostLoaderWithFallbackComposite(
        primary: PostLoaderCacheDecorator(
          decoratee: RemotePostLoader(client: client),
          cache: localPostLoader,
        ),
        fallback: localPostLoader,
      );
    }
    return _postLoader[this]!;
  }
}

extension on App {
  static final _imageDataLoader = Expando<ImageDataLoader>('ImageDataLoader');
  ImageDataLoader get imageDataLoaderComposite {
    if (_imageDataLoader[this] == null) {
      var localImageDataLoader = LocalImageDataLoader(
        RealmImageDataStore(realm),
      );
      _imageDataLoader[this] = ImageDataLoaderWithFallbackComposite(
        primary: localImageDataLoader,
        fallback: ImageDataLoaderCacheDecorator(
          decoratee: RemoteImageDataLoader(dio),
          cache: localImageDataLoader,
        ),
      );
    }
    return _imageDataLoader[this]!;
  }
}

extension on App {
  static final _bookmarkStore = Expando<BookmarkStore>('BookmarkStore');
  BookmarkStore get bookmarkStore {
    if (_bookmarkStore[this] == null) {
      _bookmarkStore[this] = InMemoryBookmarkSotre();
    }
    return _bookmarkStore[this]!;
  }

  static final _bookmarkCreator = Expando<BookmarkCreator>('BookmarkCreator');
  BookmarkCreator get bookmarkCreator {
    if (_bookmarkCreator[this] == null) {
      _bookmarkCreator[this] = BookmarkCreatorImpl(bookmarkStore);
    }
    return _bookmarkCreator[this]!;
  }

  static final _bookmarkDeleter = Expando<BookmarkDeleter>('BookmarkDeleter');
  BookmarkDeleter get bookmarkDeleter {
    if (_bookmarkDeleter[this] == null) {
      _bookmarkDeleter[this] = BookmarkDeleterImpl(bookmarkStore);
    }
    return _bookmarkDeleter[this]!;
  }
}
