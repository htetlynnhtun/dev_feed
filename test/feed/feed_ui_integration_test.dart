import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dev_feed/async_image/model/image_data_loader.dart';
import 'package:dev_feed/feed/feed_ui_composer.dart';
import 'package:dev_feed/feed/model/model.dart';

import '../helpers.dart';
import 'feed_ui_integration_test.mocks.dart';

abstract class PostSelectionHandler {
  void onSelected(int id);
}

@GenerateNiceMocks([
  MockSpec<PostLoader>(),
  MockSpec<ImageDataLoader>(),
  MockSpec<PostSelectionHandler>(),
])
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
  });
}
