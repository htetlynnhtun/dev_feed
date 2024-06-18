import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:async/async.dart';
import 'package:dev_feed/feed/view/post_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dev_feed/async_image/model/image_data_loader.dart';
import 'package:dev_feed/feed/feed_ui_composer.dart';
import 'package:dev_feed/feed/model/model.dart';

import '../helpers.dart';
@GenerateNiceMocks([
  MockSpec<PostLoader>(),
  MockSpec<ImageDataLoader>(),
  MockSpec<PostSelectionHandler>(),
])
import 'feed_ui_integration_test.mocks.dart';

abstract class PostSelectionHandler {
  void onSelected(int id);
}

void main() {
  group('FeedUIIntegrationTest', () {
    (MaterialApp, MockPostLoader) makeSUT() {
      final postLoader = MockPostLoader();
      final dataLoader = MockImageDataLoader();
      final selectionHandler = MockPostSelectionHandler();
      final sut = FeedUIComposer.feedPage(
        postLoader,
        dataLoader,
        selectionHandler.onSelected,
      );

      return (MaterialApp(home: sut), postLoader);
    }

    testWidgets('load posts actions request posts from loader', (tester) async {
      final (sut, postLoader) = makeSUT();
      final mockedResponses = [
        Exception('fail to load'),
        uniquePosts(),
      ];
      when(postLoader.load()).thenAnswer((_) async {
        final response = mockedResponses.removeAt(0);
        if (response is List<Post>) {
          return response;
        } else {
          throw response;
        }
      });

      await tester.pumpWidget(sut);

      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('retry-load-post-button')));

      verify(postLoader.load()).called(2);
    });

    testWidgets('loading indicator is visible while loading posts',
        (tester) async {
      final postLoaderSpy = PostLoaderSpy();
      final dataLoader = MockImageDataLoader();
      final selectionHandler = MockPostSelectionHandler();
      final sut = MaterialApp(
        home: FeedUIComposer.feedPage(
          postLoaderSpy,
          dataLoader,
          selectionHandler.onSelected,
        ),
      );
      when(dataLoader.load(any))
          .thenReturn(CancelableOperation.fromFuture(createRedImage(1, 1)));

      await tester.pumpWidget(sut);
      expect(find.byKey(const ValueKey('post-loading-view')), findsOneWidget);

      postLoaderSpy.completeLoadingWithException();
      await tester.pump();
      expect(find.byKey(const ValueKey('post-loading-view')), findsNothing);

      await tester.tap(find.byKey(const ValueKey('retry-load-post-button')));
      await tester.pump();
      expect(find.byKey(const ValueKey('post-loading-view')), findsOneWidget);

      postLoaderSpy.completeLoading(at: 1);
      await tester.pump();
      expect(find.byKey(const ValueKey('post-loading-view')), findsNothing);
    });

    testWidgets('loading completion renders successfully loaded posts',
        (tester) async {
      final postLoaderSpy = PostLoaderSpy();
      final dataLoader = MockImageDataLoader();
      final selectionHandler = MockPostSelectionHandler();
      final sut = MaterialApp(
        home: FeedUIComposer.feedPage(
          postLoaderSpy,
          dataLoader,
          selectionHandler.onSelected,
        ),
      );
      final result = [
        makePost(id: 0),
        makePost(id: 1),
        makePost(id: 2),
        makePost(id: 3),
      ];
      when(dataLoader.load(any))
          .thenReturn(CancelableOperation.fromFuture(createRedImage(1, 1)));

      await tester.pumpWidget(sut);
      expect(find.byType(PostItemView), findsNothing);

      postLoaderSpy.completeLoading(result: result, at: 0);
      await tester.pump();
      for (final post in result) {
        await tester.scrollUntilVisible(find.byKey(ValueKey(post.id)), 500);
      }
    });
  });
}

class PostLoaderSpy implements PostLoader {
  List<Completer<List<Post>>> messages = [];

  @override
  Future<List<Post>> load() {
    final completer = Completer<List<Post>>();
    messages.add(completer);
    return completer.future;
  }

  void completeLoading({List<Post> result = const [], int at = 0}) {
    messages[at].complete(result);
  }

  void completeLoadingWithException({int at = 0}) {
    messages[at].completeError(Exception('any'));
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
