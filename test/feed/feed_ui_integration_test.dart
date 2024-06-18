import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:async/async.dart';
import 'package:dev_feed/feed/view/post_item_view.dart';
import 'package:dev_feed/feed/view/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dev_feed/async_image/model/image_data_loader.dart';
import 'package:dev_feed/feed/feed_ui_composer.dart';
import 'package:dev_feed/feed/model/model.dart';

import '../helpers.dart';

abstract class PostSelectionHandler {
  void onSelected(int id);
}

typedef PostItemSelectionHandler = void Function(int id);

void main() {
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

      expect(postLoaderSpy.loadCallCount, 0,
          reason: 'Expected no loading requests before UI is rendered');

      await tester.render(sut);
      expect(postLoaderSpy.loadCallCount, 1,
          reason: 'Expected 1 loading request once UI is rendered');

      postLoaderSpy.completeLoadingWithException();
      await tester.rebuildIfNeeded();
      await tester.simulateUserInitiatedPostReload();
      expect(postLoaderSpy.loadCallCount, 2,
          reason:
              '''Expected another loading requests once user initiates a load''');
    });

    testWidgets('loading indicator is visible while loading posts',
        (tester) async {
      final (sut, postLoaderSpy, _) = makeSUT();

      await tester.render(sut);
      expect(sut.loadingIndicator, findsOneWidget);

      postLoaderSpy.completeLoadingWithException();
      await tester.rebuildIfNeeded();
      expect(sut.loadingIndicator, findsNothing);

      await tester.tap(find.byKey(const ValueKey('retry-load-post-button')));
      await tester.rebuildIfNeeded();
      expect(sut.loadingIndicator, findsOneWidget);

      postLoaderSpy.completeLoading(at: 1);
      await tester.rebuildIfNeeded();
      expect(sut.loadingIndicator, findsNothing);
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

      await tester.render(sut);
      expect(sut.postItemView, findsNothing);

      postLoaderSpy.completeLoading(result: posts, at: 0);
      await tester.rebuildIfNeeded();
      await tester.verifyRendering(posts);
    });

    testWidgets('post item selection notifies handler', (tester) async {
      final selectedPosts = <int>[];
      final (sut, postLoaderSpy, _) = makeSUT(handler: selectedPosts.add);
      final post1 = makePost(id: 1);
      final post2 = makePost(id: 2);

      await tester.render(sut);
      postLoaderSpy.completeLoading(result: [post2, post1]);
      await tester.rebuildIfNeeded();

      await tester.simulatePostItemSelection(post2);
      expect(selectedPosts, [post2.id],
          reason: 'Expect post selection for post id: ${post2.id}');

      await tester.simulatePostItemSelection(post1);
      expect(selectedPosts, [post2.id, post1.id],
          reason:
              '''Expect post selection for post id: ${post2.id}, ${post1.id}''');
    });

    testWidgets(
        'loading completion renders failure message on failure until next reload',
        (tester) async {
      final (sut, loaderSpy, _) = makeSUT();

      await tester.render(sut);

      await tester.rebuildIfNeeded();
      expect(sut.failureView, findsNothing);

      loaderSpy.completeLoadingWithException();
      await tester.rebuildIfNeeded();
      expect(sut.failureView, findsOneWidget);

      await tester.simulateUserInitiatedPostReload();
      await tester.rebuildIfNeeded();
      expect(sut.failureView, findsNothing);
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

      await tester.render(sut);
      loaderSpy.completeLoading(result: [post1, post2]);
      await tester.rebuildIfNeeded();

      expect(
        imageDataLoaderSpy.loadedImageUrl,
        [post1.coverImage, post1.user.profileImage],
        reason: '''Expected image url requests for first posts''',
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
        reason: '''Expected image url requests for second posts''',
      );
    });

    testWidgets(
        'post item view cancel loading images when not being rendered anymore',
        (tester) async {
      tester.view.physicalSize = const Size(1500, 1);
      final (sut, loaderSpy, imageDataLoaderSpy) = makeSUT();
      final posts = <Post>[];
      for (var i = 0; i < 20; i++) {
        posts.add(makePost(
          id: i,
          coverImage: "https://image-$i.com",
          profileImage: "https://profile-$i.com",
        ));
      }

      await tester.render(sut);
      loaderSpy.completeLoading(result: posts);
      await tester.rebuildIfNeeded();

      // post at 0 is automatically visible

      var lastVisiblePostIndex = 1;
      await tester.simulatePostVisible(posts[lastVisiblePostIndex]);

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
        reason: '''Expected cancel image url requests for first 2 posts''',
      );
    });
  });
}

// ========================= Helpers =========================

extension on PostsPage {
  Finder get loadingIndicator => widgetWithKey('post-loading-view');
  Finder get postItemView => widgetOfType(PostItemView);
  Finder get failureView => widgetWithKey('post-failure-view');
}

Finder widgetWithKey<T>(T key) => find.byKey(ValueKey(key));
Finder widgetOfType(Type type) => find.byType(type);

extension on WidgetTester {
  Future<void> render(Widget sut) => pumpWidget(MaterialApp(home: sut));

  Future<void> rebuildIfNeeded() => pump();

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

void ignoreOverflowErrors(
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  bool ifIsOverflowError = false;
  var exception = details.exception;
  if (exception is FlutterError) {
    ifIsOverflowError = !exception.diagnostics.any(
      (e) => e.value.toString().startsWith("A RenderFlex overflowed by"),
    );
  }
  if (ifIsOverflowError) {
    debugPrint('Ignored Overflow Error');
  } else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  }
}
