part of 'async_image_view_model.dart';

@freezed
sealed class AsyncImageViewState with _$AsyncImageViewState {
  const factory AsyncImageViewState.loading() = Loading;
  const factory AsyncImageViewState.loaded(Uint8List data) = Loaded;
  const factory AsyncImageViewState.failure(String message) = Failure;
}
