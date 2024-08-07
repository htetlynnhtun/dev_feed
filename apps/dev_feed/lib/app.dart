import 'package:async_image/async_image.dart';
import 'package:dev_feed/bookmark/model/bookmark_manager.dart';
import 'package:dev_feed/bookmark/view/bookmark_page.dart';
import 'package:dev_feed/post_detail/api/remote_post_details_loader.dart';
import 'package:dev_feed/post_detail/post_detail_ui_composer.dart';
import 'package:dev_feed/posts_feed/api/posts_endpoint.dart';
import 'package:dev_feed/posts_feed/api/posts_mapper.dart';
import 'package:dev_feed/posts_feed/model/paginated_posts.dart';
import 'package:dev_feed/posts_feed/view/posts_page.dart';
import 'package:dev_feed/util/pipelines.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart';

import 'package:dev_feed/bookmark/cache/bookmark_store.dart';
import 'package:dev_feed/bookmark/cache/in_memory_bookmark_sotre.dart';
import 'package:dev_feed/bookmark/view/bookmark_button_view.dart';
import 'package:dev_feed/posts_feed/cache/cache.dart';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/view/post_item_view.dart';
import 'package:dev_feed/posts_feed/view/posts_list_view.dart';
import 'package:dev_feed/posts_feed/viewmodel/post_item_view_model.dart';
import 'package:dev_feed/util/image_data_loader_cache_decorator.dart';
import 'package:dev_feed/util/image_data_loader_with_fallback_composite.dart';
import 'package:rxdart/rxdart.dart';

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
        StatefulShellRoute.indexedStack(
          builder: (_, __, navigationShell) => NavBarShell(
            navigationShell: navigationShell,
          ),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/posts',
                  builder: (context, state) => PostsPage(
                    postsStream: makeRemotePostLoaderWithLocalFallback,
                    loadedView:
                        (BuildContext context, List<Post> posts, loadMore) {
                      return PostsListView(
                        key: const ValueKey('posts-list-view'),
                        posts: posts,
                        itemView: (context, post) =>
                            postItemView(context, post),
                        loadNextPage: loadMore,
                      );
                    },
                  ),
                  routes: [
                    GoRoute(
                      path: ':postId',
                      builder: (context, state) {
                        final postId =
                            int.parse(state.pathParameters['postId']!);
                        return PostDetailUIComposer.detailPage(
                          postId,
                          RemotePostDetailsLoader(dio: dio),
                          imageDataLoaderComposite,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/bookmarks',
                  builder: (context, state) => BookmarkPageComposer.compose(
                    bookmarkLoader: bookmarkStore.retrieveAll,
                    postListView: (BuildContext context, List<Post> posts) {
                      return PostsListView(
                        key: const ValueKey('bookmarked-posts-list-view'),
                        posts: posts,
                        itemView: (context, post) =>
                            postItemView(context, post),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
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
        dataLoader: makeLocalImageDataLoaderWithRemoteFallback,
      ),
      bookmarkButtonView: (context) => BookmarkButtonView(
        post: post,
        bookmarkLoader: bookmarkManager.loadAll,
        bookmarkCreator: bookmarkManager,
        bookmarkDeleter: bookmarkManager,
      ),
    );
  }
}

extension on App {
  static final _localPostLoader = Expando<LocalPostLoader>('LocalPostLoader');
  LocalPostLoader get localPostLoader {
    if (_localPostLoader[this] == null) {
      _localPostLoader[this] = LocalPostLoader(
        postStore: RealmPostStore(realm: realm),
      );
    }
    return _localPostLoader[this]!;
  }

  Stream<List<Post>> makeRemotePostsLoader({required int page}) {
    var url = PostsEndpoint.get(page).url('https://dev.to/api');
    return client
        .get(url) //
        .asStream()
        .map(PostsMapper.map);
  }

  Stream<PaginatedPosts> makeRemotePostLoaderWithLocalFallback() {
    return makeRemotePostsLoader(page: 1)
        .cacheTo(localPostLoader)
        .fallbackTo(localPostLoader.loadStream())
        .map((posts) => (
              page: 1,
              mergedPosts: posts,
              newPosts: posts,
            ))
        .map(makePage);
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
        .cacheTo(localPostLoader);
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

  Stream<Uint8List> makeLocalImageDataLoaderWithRemoteFallback(Uri url) {
    final localImageDataLoader = LocalImageDataLoader(
      RealmImageDataStore(realm),
    );
    final remoteImageDataLoader = RemoteImageDataLoader(dio);
    return localImageDataLoader.loadStream(url).fallbackTo(
          remoteImageDataLoader
              .loadStream(url)
              .cacheTo(localImageDataLoader, url),
        );
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

  static final _bookmarkManager = Expando<BookmarkManager>('BookmarkManager');
  BookmarkManager get bookmarkManager {
    if (_bookmarkManager[this] == null) {
      _bookmarkManager[this] = BookmarkManager(bookmarkStore);
    }
    return _bookmarkManager[this]!;
  }
}

class NavBarShell extends StatelessWidget {
  const NavBarShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
      ),
    );
  }
}
