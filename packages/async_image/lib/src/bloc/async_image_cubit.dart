import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_image_cubit.freezed.dart';
part './async_image_state.dart';

class AsyncImageCubit extends Cubit<AsyncImageState> {
  final Stream<Uint8List> Function(Uri) dataLoader;
  final Uri imageUrl;
  AsyncImageCubit(
    this.dataLoader,
    this.imageUrl,
  ) : super(const AsyncImageState.loading());

  StreamSubscription<Uint8List>? _subscription;

  void load() {
    emit(const AsyncImageState.loading());
    _subscription?.cancel();
    _subscription = dataLoader(imageUrl).listen(
      (data) => emit(AsyncImageState.loaded(data)),
      onError: (error, stackTrace) =>
          emit(AsyncImageState.failure(error.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
