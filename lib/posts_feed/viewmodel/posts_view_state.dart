part of 'posts_view_model.dart';

@freezed
sealed class PostsViewState with _$PostsViewState {
  const factory PostsViewState.idle() = Idle;
  const factory PostsViewState.loading() = Loading;
  const factory PostsViewState.loaded(List<Post> posts) = Loaded;
  const factory PostsViewState.failure(String message) = failure;
}
