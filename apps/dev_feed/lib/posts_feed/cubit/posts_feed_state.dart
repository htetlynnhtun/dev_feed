part of 'posts_feed_cubit.dart';

@freezed
sealed class PostsFeedState with _$PostsFeedState {
  const factory PostsFeedState.idle() = Idle;
  const factory PostsFeedState.loading() = Loading;
  const factory PostsFeedState.loaded(List<Post> posts) = Loaded;
  const factory PostsFeedState.failure(String message) = Failure;
}
