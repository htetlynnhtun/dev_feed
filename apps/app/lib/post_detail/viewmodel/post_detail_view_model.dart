import 'package:async/async.dart';
import 'package:async_image/async_image.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import 'package:dev_feed/post_detail/model/model.dart';
import 'package:dev_feed/util/constants.dart';

part 'post_detail_view_model.freezed.dart';
part 'post_detail_view_state.dart';

typedef PostDetailViewModelFactory = PostDetailViewModel Function();

class PostDetailViewModel extends ValueNotifier<PostDetailViewState> {
  final int postId;
  final PostDetailsLoader postDetailsLoader;
  final ImageDataLoader imageDataLoader;

  PostDetailViewModel({
    required this.postId,
    required this.postDetailsLoader,
    required this.imageDataLoader,
  }) : super(const PostDetailViewState.loading());

  static final dateFormatter = DateFormat.yMMMd();
  var _disposed = false;
  CancelableOperation<PostDetails>? _loadOperation;

  Future<void> load() async {
    value = const PostDetailViewState.loading();
    try {
      _loadOperation = postDetailsLoader.load(postId);
      final loadedDetails = await _loadOperation!.value;
      value = PostDetailViewState.loaded((
        title: loadedDetails.title,
        body: loadedDetails.body,
        coverImage: loadedDetails.coverImage ?? flutterImage,
        likeCount: loadedDetails.likeCount.toString(),
        publishAt: dateFormatter.format(loadedDetails.publishedAt),
        tags: loadedDetails.tagList.map((e) => '# $e').join(' '),
        username: loadedDetails.user.name,
        userProfileImage: loadedDetails.user.profileImage,
        dataLoader: imageDataLoader,
      ));
    } catch (_) {
      value = const PostDetailViewState.failure(
          'Failed to load post. Please try again.');
    }
  }

  @override
  set value(PostDetailViewState newValue) {
    if (_disposed) return;
    super.value = newValue;
  }

  @override
  void dispose() {
    _loadOperation?.cancel();
    _disposed = true;
    super.dispose();
  }
}

typedef PostDetailViewData = ({
  String title,
  String body,
  String coverImage,
  String tags,
  String likeCount,
  String publishAt,
  String username,
  String userProfileImage,
  ImageDataLoader dataLoader,
});
