import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:async/async.dart';
import 'package:dev_feed/feed/view/post_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dev_feed/async_image/model/image_data_loader.dart';
import 'package:dev_feed/feed/feed_ui_composer.dart';
import 'package:dev_feed/feed/model/model.dart';

import '../helpers.dart';

abstract class PostSelectionHandler {
  void onSelected(int id);
}

void main() {
  group('FeedUIIntegrationTest', () {
    (MaterialApp, PostLoaderSpy, ImageDataLoaderStub) makeSUT() {
      final postLoader = PostLoaderSpy();
      final dataLoader = ImageDataLoaderStub();

      final sut = FeedUIComposer.feedPage(
        postLoader,
        dataLoader,
        (_) {},
      );

      return (MaterialApp(home: sut), postLoader, dataLoader);
    }

    testWidgets('load posts actions request posts from loader', (tester) async {
      final (sut, postLoaderSpy, _) = makeSUT();

      await tester.render(sut);

      postLoaderSpy.completeLoadingWithException();
      await tester.rebuildIfNeeded();
      await tester.tap(widgetWithKey('retry-load-post-button'));

      expect(postLoaderSpy.loadCallCount, 2);
    });

    testWidgets('loading indicator is visible while loading posts',
        (tester) async {
      final (sut, postLoaderSpy, _) = makeSUT();

      await tester.render(sut);
      expect(widgetWithKey('post-loading-view'), findsOneWidget);

      postLoaderSpy.completeLoadingWithException();
      await tester.rebuildIfNeeded();
      expect(widgetWithKey('post-loading-view'), findsNothing);

      await tester.tap(find.byKey(const ValueKey('retry-load-post-button')));
      await tester.rebuildIfNeeded();
      expect(widgetWithKey('post-loading-view'), findsOneWidget);

      postLoaderSpy.completeLoading(at: 1);
      await tester.rebuildIfNeeded();
      expect(widgetWithKey('post-loading-view'), findsNothing);
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
      expect(widgetOfType(PostItemView), findsNothing);

      postLoaderSpy.completeLoading(result: posts, at: 0);
      await tester.rebuildIfNeeded();
      await tester.verifyRendering(posts);
    });
  });
}

Finder widgetWithKey<T>(T key) => find.byKey(ValueKey(key));
Finder widgetOfType(Type type) => find.byType(type);

extension on WidgetTester {
  Future<void> render(Widget sut) => pumpWidget(sut);

  Future<void> rebuildIfNeeded() => pump();

  Future<void> verifyRendering(List<Post> posts) async {
    for (final post in posts) {
      await scrollUntilVisible(find.byKey(ValueKey(post.id)), 500);
    }
  }
}

class ImageDataLoaderStub implements ImageDataLoader {
  @override
  CancelableOperation<Uint8List> load(Uri url) {
    return CancelableOperation.fromFuture(createRedImage(1, 1));
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
