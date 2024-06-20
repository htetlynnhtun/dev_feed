import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/viewmodel/posts_view_model.dart';

import '../../helpers.dart';
import 'posts_view_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostLoader>()])
void main() {
  final posts = uniquePosts();
  
  (PostsViewModel, MockPostLoader) makeSUT() {
    final mockedPostLoader = MockPostLoader();
    final sut = PostsViewModel(loader: mockedPostLoader);
    return (sut, mockedPostLoader);
  }

  group('PostsViewModel', () {
    test('has correct initial state', () {
      final (sut, _) = makeSUT();

      expect(sut.value, const PostsViewState.idle());
    });

    test('does not message loader on init', () {
      final (_, mockedItemsLoader) = makeSUT();

      verifyZeroInteractions(mockedItemsLoader);
    });

    valueNotifierTest(
      '.load() notifies [loading, failure] on loader failure',
      arrange: () {
        final mockedPostLoader = MockPostLoader();
        when(mockedPostLoader.load()).thenThrow(Exception('Failed to load'));
        return PostsViewModel(loader: mockedPostLoader);
      },
      act: (notifier) => notifier.load(),
      expectedValues: [
        const PostsViewState.loading(),
        const PostsViewState.failure(
            'Please check your connection and try again'),
      ],
    );

    valueNotifierTest(
      '.load() notifies [loading, loaded] on loader success',
      arrange: () {
        final mockedPostLoader = MockPostLoader();
        when(mockedPostLoader.load()).thenAnswer((_) async => posts);
        return PostsViewModel(loader: mockedPostLoader);
      },
      act: (notifier) => notifier.load(),
      expectedValues: [
        const PostsViewState.loading(),
        PostsViewState.loaded(posts),
      ],
    );
  });
}
