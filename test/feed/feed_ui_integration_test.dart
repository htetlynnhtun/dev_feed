@Tags(['integration'])

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dev_feed/async_image/model/image_data_loader.dart';
import 'package:dev_feed/posts_feed/posts_feed_ui_composer.dart';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/view/post_item_view.dart';
import 'package:dev_feed/posts_feed/view/posts_page.dart';

import '../helpers.dart';

abstract class PostSelectionHandler {
  void onSelected(int id);
}

typedef PostItemSelectionHandler = void Function(int id);

void main() async {
  group('FeedUIIntegrationTest', () {
    (PostsPage, PostLoaderSpy, ImageDataLoaderSpy) makeSUT({
      PostItemSelectionHandler? handler,
    }) {
      final postLoader = PostLoaderSpy();
      final dataLoader = ImageDataLoaderSpy();

      final sut = FeedUIComposer.feedPage(
        postLoader,
        dataLoader,
        handler ?? (_) {},
      );

      return (sut, postLoader, dataLoader);
    }

    testWidgets('load posts actions request posts from loader', (tester) async {
      final (sut, postLoaderSpy, _) = makeSUT();

      expect(
        postLoaderSpy.loadCallCount,
        0,
        reason: 'Expected no loading requests before UI is rendered',
      );

      await tester.pumpWidget(MaterialApp(home: sut));
      expect(
        postLoaderSpy.loadCallCount,
        1,
        reason: 'Expected 1 loading request once UI is rendered',
      );

      postLoaderSpy.completeLoadingWithException();
      await tester.pump();
      await tester.simulateUserInitiatedPostReload();
      expect(
        postLoaderSpy.loadCallCount,
        2,
        reason: 'Expected another loading requests once user initiates a load',
      );
    });

    testWidgets('loading indicator is visible while loading posts',
        (tester) async {
      final (sut, postLoaderSpy, _) = makeSUT();

      await tester.pumpWidget(MaterialApp(home: sut));
      expect(
        sut.loadingIndicator,
        findsOneWidget,
        reason: 'Expected loading indicator while loading posts',
      );

      postLoaderSpy.completeLoadingWithException();
      await tester.pump();
      expect(
        sut.loadingIndicator,
        findsNothing,
        reason:
            'Expected no loading indicator once loading posts is completed with failure',
      );

      await tester.simulateUserInitiatedPostReload();
      await tester.pump();
      expect(
        sut.loadingIndicator,
        findsOneWidget,
        reason: 'Expected loading indicator once user initiates post reload',
      );

      postLoaderSpy.completeLoading(at: 1);
      await tester.pump();
      expect(
        sut.loadingIndicator,
        findsNothing,
        reason:
            'Expected no loading inidcator once loading posts is completed successfully',
      );
    });

    testWidgets('loading completion renders successfully loaded posts',
        (tester) async {
      final (sut, postLoaderSpy, _) = makeSUT();
      final posts = [
        makePost(id: 0),
        makePost(id: 1),
        makePost(id: 2),
        makePost(id: 3),
      ];

      await tester.pumpWidget(MaterialApp(home: sut));
      expect(
        sut.postItemView,
        findsNothing,
        reason: 'Expected no post items while loading posts',
      );

      postLoaderSpy.completeLoading(result: posts, at: 0);
      await tester.pump();
      await tester.verifyRendering(posts);
    });

    testWidgets('post item selection notifies handler', (tester) async {
      final selectedPosts = <int>[];
      final (sut, postLoaderSpy, _) = makeSUT(handler: selectedPosts.add);
      final post1 = makePost(id: 1);
      final post2 = makePost(id: 2);

      await tester.pumpWidget(MaterialApp(home: sut));
      postLoaderSpy.completeLoading(result: [post2, post1]);
      await tester.pump();

      await tester.simulatePostItemSelection(post2);
      expect(
        selectedPosts,
        [post2.id],
        reason: 'Expected post selection for post id: ${post2.id}',
      );

      await tester.simulatePostItemSelection(post1);
      expect(
        selectedPosts,
        [post2.id, post1.id],
        reason: 'Expected post selection for post id: ${post2.id}, ${post1.id}',
      );
    });

    testWidgets(
        'loading completion renders failure message on failure until next reload',
        (tester) async {
      final (sut, loaderSpy, _) = makeSUT();

      await tester.pumpWidget(MaterialApp(home: sut));

      await tester.pump();
      expect(
        sut.failureView,
        findsNothing,
        reason: 'Expected no failure view while loading',
      );

      loaderSpy.completeLoadingWithException();
      await tester.pump();
      expect(
        sut.failureView,
        findsOneWidget,
        reason:
            'Expected failure view once post loading is completed with failrue',
      );

      await tester.simulateUserInitiatedPostReload();
      await tester.pump();
      expect(
        sut.failureView,
        findsNothing,
        reason: 'Expected no failure view once user initiated post reload',
      );
    });

    testWidgets('post item view loads image urls when rendered',
        (tester) async {
      tester.view.physicalSize = const Size(1500, 1);
      final (sut, loaderSpy, imageDataLoaderSpy) = makeSUT();
      final post1 = makePost(
        id: 1,
        coverImage: "https://image-1.com",
        profileImage: "https://profile-1.com",
      );
      final post2 = makePost(
        id: 2,
        coverImage: "https://image-2.com",
        profileImage: "https://profile-2.com",
      );

      await tester.pumpWidget(MaterialApp(home: sut));
      loaderSpy.completeLoading(result: [post1, post2]);
      await tester.pump();

      expect(
        imageDataLoaderSpy.loadedImageUrl,
        [post1.coverImage, post1.user.profileImage],
        reason: 'Expected image url requests for first posts',
      );

      await tester.simulatePostVisible(post2);
      expect(
        imageDataLoaderSpy.loadedImageUrl,
        [
          post1.coverImage,
          post1.user.profileImage,
          post2.coverImage,
          post2.user.profileImage,
        ],
        reason: 'Expected image url requests for second posts',
      );
    });

    testWidgets(
        'post item view cancel loading images when not being rendered anymore',
        (tester) async {
      tester.view.physicalSize = const Size(1500, 1);
      addTearDown(tester.view.resetPhysicalSize);
      final (sut, loaderSpy, imageDataLoaderSpy) = makeSUT();
      final posts = <Post>[];
      for (var i = 0; i < 20; i++) {
        posts.add(makePost(
          id: i,
          coverImage: "https://image-$i.com",
          profileImage: "https://profile-$i.com",
        ));
      }

      await tester.pumpWidget(MaterialApp(home: sut));
      loaderSpy.completeLoading(result: posts);
      await tester.pump();

      // post at 0 is automatically visible
      var lastVisiblePostIndex = 1;
      await tester.simulatePostVisible(posts[lastVisiblePostIndex]);

      // TODO: This test is fragile, Depending on the post item widget height to make it not visible and disposed.
      // scroll to lastVisiblePost index + 2 indexed post to
      // make first 2 posts out of list view cache extent
      await tester.simulatePostVisible(posts[lastVisiblePostIndex + 2]);
      expect(
        imageDataLoaderSpy.cancelledImageURLs,
        [
          posts[0].coverImage,
          posts[0].user.profileImage,
          posts[1].coverImage,
          posts[1].user.profileImage,
        ],
        reason: 'Expected cancel image url requests for first 2 posts',
      );
    });

    testWidgets(
        'post item cover image loading indicator is visible while loading image data',
        (tester) async {
      final (sut, loaderSpy, imageDataLoaderSpy) = makeSUT();
      final post0 = makePost(id: 0, coverImage: 'https://image-0.com');
      final post1 = makePost(id: 1, coverImage: 'https://image-1.com');

      await tester.pumpWidget(MaterialApp(home: sut));
      loaderSpy.completeLoading(result: [post0, post1]);
      await tester.pump();

      expect(
        sut.coverImageLoadingIndicatorOf(post0),
        findsOne,
        reason:
            'Expected loading indicator for first post cover image while loading first cover image',
      );
      expect(
        sut.coverImageLoadingIndicatorOf(post1),
        findsOne,
        reason:
            'Expected loading indicator for second post cover image while loading second cover image',
      );

      final firstCoverImageData =
          await tester.runAsync(() => createRedImage(1, 1));
      imageDataLoaderSpy.completImageLoading(data: firstCoverImageData!, at: 0);
      await tester.pump();
      expect(
        sut.coverImageLoadingIndicatorOf(post0),
        findsNothing,
        reason:
            'Expected no loading indicator for first post cover image once first cover image loaded',
      );
      expect(
        sut.coverImageLoadingIndicatorOf(post1),
        findsOne,
        reason:
            'Expected no loading indicator state change for second post cover image once first cover image loaded',
      );

      imageDataLoaderSpy.completeImageLoadingWithException(at: 2);
      await tester.pump();
      expect(
        sut.coverImageLoadingIndicatorOf(post0),
        findsNothing,
        reason:
            'Expected no loading indicator state change for first post cover image once loading second cover image is failed',
      );
      expect(
        sut.coverImageLoadingIndicatorOf(post1),
        findsNothing,
        reason:
            'Expected no loading indicator for second post cover image once second cover image loading failed',
      );

      await tester.tap(sut.coverImageRetryButtonOf(post1));
      await tester.pump();
      expect(
        sut.coverImageLoadingIndicatorOf(post0),
        findsNothing,
        reason:
            'Expected no loading indicator state change for first post cover image once loading second cover image is failed',
      );
      expect(
        sut.coverImageLoadingIndicatorOf(post1),
        findsOne,
        reason:
            'Expected loading indicator for second post cover image on retry action',
      );
    });

    testWidgets('renders post item cover image loaded from url',
        (tester) async {
      final (sut, loaderSpy, imageDataLoaderSpy) = makeSUT();
      final post0 = makePost(id: 0, coverImage: 'https://image-0.com');
      final post1 = makePost(id: 1, coverImage: 'https://image-1.com');

      await tester.pumpWidget(MaterialApp(home: sut));
      loaderSpy.completeLoading(result: [post0, post1]);
      await tester.pump();

      await tester.simulatePostVisible(post1);
      final firstImageData = await tester.runAsync(() => createRedImage(1, 1));
      final secondImageData = await tester.runAsync(() => createRedImage(2, 2));

      expect(
        sut.imageWithData(firstImageData!),
        findsNothing,
        reason: 'Expected no image while image data is loading',
      );
      expect(
        sut.imageWithData(secondImageData!),
        findsNothing,
        reason: 'Expected no image while image data is loading',
      );

      imageDataLoaderSpy.completImageLoading(data: firstImageData, at: 0);
      await tester.pump();
      expect(
        sut.imageWithData(firstImageData),
        findsOne,
        reason:
            'Expected image for first image once first image loading is completed',
      );
      expect(
        sut.imageWithData(secondImageData),
        findsNothing,
        reason:
            'Expected no image state change for second image once first image loading is completed',
      );

      imageDataLoaderSpy.completImageLoading(data: secondImageData, at: 1);
      await tester.pump();
      expect(
        sut.imageWithData(firstImageData),
        findsOne,
        reason:
            'Expected no image state change for first image once second image loading is completed',
      );
      expect(
        sut.imageWithData(secondImageData),
        findsOne,
        reason:
            'Expected image for second image once second image loading is completed',
      );
    });
  });
}

// ========================= Helpers =========================

extension on PostsPage {
  Finder get loadingIndicator => widgetWithKey('post-loading-view');
  Finder get postItemView => widgetOfType(PostItemView);
  Finder get failureView => widgetWithKey('post-failure-view');

  Finder imageWithData(Uint8List data) => widgetWithKey(data);

  Finder coverImageLoadingIndicatorOf(Post post) => find.descendant(
        of: widgetWithKey(post.coverImage!),
        matching: widgetOfType(CircularProgressIndicator),
      );

  Finder coverImageRetryButtonOf(Post post) => find.descendant(
        of: widgetWithKey(post.coverImage!),
        matching: widgetWithKey('retry-button'),
      );
}

Finder widgetWithKey<T extends Object>(T key) => find.byKey(ValueKey(key));
Finder widgetOfType(Type type) => find.byType(type);

extension on WidgetTester {
  Future<void> verifyRendering(List<Post> posts) async {
    for (final post in posts) {
      await scrollUntilVisible(find.byKey(ValueKey(post.id)), 500);
    }
  }

  Future<void> simulatePostVisible(Post post) async {
    await scrollUntilVisible(widgetWithKey(post.id), 500);
  }

  Future<void> simulateUserInitiatedPostReload() =>
      tap(widgetWithKey('retry-load-post-button'));

  Future<void> simulatePostItemSelection(Post post) =>
      tap(widgetWithKey(post.id));
}

class ImageDataLoaderSpy implements ImageDataLoader {
  final _imageRequests = <(String, Completer<Uint8List>)>[];
  final _cancelledImageURLs = <String>[];

  List<String> get loadedImageUrl => _imageRequests.map((e) => e.$1).toList();
  List<String> get cancelledImageURLs => _cancelledImageURLs;

  @override
  CancelableOperation<Uint8List> load(Uri url) {
    final urlString = url.toString();
    final completer = Completer<Uint8List>();
    _imageRequests.add((urlString, completer));
    return CancelableOperation.fromFuture(
      completer.future,
      onCancel: () {
        _cancelledImageURLs.add(urlString);
        completer.completeError('Operation cancelled');
      },
    );
  }

  void completImageLoading({required Uint8List data, required int at}) {
    _imageRequests[at].$2.complete(data);
  }

  void completeImageLoadingWithException({required int at}) {
    _imageRequests[at].$2.completeError(Exception('any'));
  }
}

class PostLoaderSpy implements PostLoader {
  final List<Completer<List<Post>>> _messages = [];

  int get loadCallCount => _messages.length;

  @override
  Future<List<Post>> load() {
    final completer = Completer<List<Post>>();
    _messages.add(completer);
    return completer.future;
  }

  void completeLoading({List<Post> result = const [], int at = 0}) {
    _messages[at].complete(result);
  }

  void completeLoadingWithException({int at = 0}) {
    _messages[at].completeError(Exception('any'));
  }
}

Future<Uint8List> createRedImage(int width, int height) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(
    recorder,
    Rect.fromPoints(
      const Offset(0, 0),
      Offset(
        width.toDouble(),
        height.toDouble(),
      ),
    ),
  );

  final paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  canvas.drawRect(
      Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()), paint);

  final picture = recorder.endRecording();
  final img = await picture.toImage(width, height);
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
