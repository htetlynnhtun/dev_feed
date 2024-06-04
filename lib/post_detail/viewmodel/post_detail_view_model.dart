import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import 'package:dev_feed/constants.dart';
import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/post_detail/model/post_details.dart';
import 'package:dev_feed/shared/model/model.dart';
import 'package:dev_feed/shared/viewmodel/view_model.dart';

part 'post_detail_view_model.freezed.dart';
part 'post_detail_view_state.dart';

typedef PostDetailViewModelFactory = PostDetailViewModel Function();

class PostDetailViewModel extends ValueNotifier<PostDetailViewState> {
  final int postId;
  final ImageDataLoader imageDataLoader;

  PostDetailViewModel({
    required this.postId,
    required this.imageDataLoader,
  }) : super(const PostDetailViewState.loading());

  static final dateFormatter = DateFormat.yMMMd();

  Future<void> load() async {
    value = const PostDetailViewState.loading();
    await Future.delayed(const Duration(seconds: 1));
    final loadedDetails = PostDetails(
      id: postId,
      title:
          'Scaling Up Your Design System: From Seedling to Flourishing Forest',
      body:
          'Duis velit elit occaecat dolor ut tempor fugiat reprehenderit in in sit dolor nulla. Adipisicing id minim nostrud reprehenderit aute anim Lorem. Irure do ipsum elit in tempor nulla qui irure amet commodo consectetur labore officia sit. Qui do ea laboris dolor dolor cupidatat exercitation aliqua consequat qui.',
      coverImage:
          'https://media.dev.to/cdn-cgi/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fu3cois7z50sc2yykybns.png',
      likeCount: 7,
      publishedAt: DateTime.now().toUtc(),
      tagList: ['design', 'learning', 'ui'],
      user: User(
          name: 'Agbo, Daniel Onuoha ',
          profileImage:
              'https://media.dev.to/cdn-cgi/image/width=640,height=640,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Fuser%2Fprofile_image%2F261529%2F5d34c40d-8281-4116-8793-cb6ae717e56f.png'),
    );
    value = PostDetailViewState.loaded((
      title: loadedDetails.title,
      body: loadedDetails.body,
      coverImage: loadedDetails.coverImage ?? flutterImage,
      likeCount: loadedDetails.likeCount.toString(),
      publishAt: dateFormatter.format(loadedDetails.publishedAt),
      tags: loadedDetails.tagList.map((e) => '# $e').join(' '),
      username: loadedDetails.user.name,
      userProfileImage: loadedDetails.user.profileImage,
      asyncImageViewModelFactory: (url) => AsyncImageViewModel(
            imageURL: url,
            dataLoader: imageDataLoader,
          ),
    ));
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
  AsyncImageViewModelFactory asyncImageViewModelFactory,
});
