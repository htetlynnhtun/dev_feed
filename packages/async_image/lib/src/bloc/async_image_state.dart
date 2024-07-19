part of 'async_image_cubit.dart';

@freezed
sealed class AsyncImageState with _$AsyncImageState {
  const factory AsyncImageState.loading() = Loading;
  const factory AsyncImageState.loaded(Uint8List data) = Loaded;
  const factory AsyncImageState.failure(String message) = Failure;
}