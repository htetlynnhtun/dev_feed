import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:dev_feed/feed/viewmodel/post_item_view_model.dart';
import 'package:dev_feed/feed/viewmodel/posts_view_model.dart';

import '../../helpers.dart';
import 'posts_view_model_test.mocks.dart';

abstract class ItemsLoader {
  Future<List<PostItemViewModel>> load();
}

@GenerateNiceMocks([MockSpec<ItemsLoader>()])
void main() {
  (PostsViewModel, MockItemsLoader) makeSUT() {
    final mockedItemsLoader = MockItemsLoader();
    final sut = PostsViewModel(loader: mockedItemsLoader.load);
    return (sut, mockedItemsLoader);
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
        final mockedItemsLoader = MockItemsLoader();
        when(mockedItemsLoader.load()).thenThrow(Exception('Failed to load'));
        return PostsViewModel(loader: mockedItemsLoader.load);
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
        final mockedItemsLoader = MockItemsLoader();

        // TODO: Feel something's wrong, just to test PostsViewModel, need to mock PostItemViewModel
        when(mockedItemsLoader.load())
            .thenAnswer((_) async => uniquePosts().mapToViewModels());
        return PostsViewModel(loader: mockedItemsLoader.load);
      },
      act: (notifier) => notifier.load(),
      expectedValues: [
        const PostsViewState.loading(),
        const PostsViewState.loaded(expectedPostItemViewModels),
      ],
    );
  });
}
