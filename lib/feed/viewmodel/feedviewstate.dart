part of 'feed_view_model.dart';

@freezed
sealed class FeedViewState with _$FeedViewState {
  const factory FeedViewState.loading() = Loading;
  const factory FeedViewState.loaded(List<PostViewModel> posts) = Loaded;
  const factory FeedViewState.failure(String message) = failure;
}
