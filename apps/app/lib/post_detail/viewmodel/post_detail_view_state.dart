part of 'post_detail_view_model.dart';

@freezed
sealed class PostDetailViewState with _$PostDetailViewState {
  const factory PostDetailViewState.loading() = Loading;
  const factory PostDetailViewState.loaded(PostDetailViewData viewData) =
      Loaded;
  const factory PostDetailViewState.failure(String message) = Failure;
}
