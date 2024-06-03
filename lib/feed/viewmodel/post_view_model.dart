import 'package:intl/intl.dart';

import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed/viewmodel/async_image_view_model.dart';

class PostViewModel {
  final Post _post;
  final AsyncImageViewModelFactory coverImageViewModelFactory;
  final AsyncImageViewModelFactory userImageViewModelFactory;

  PostViewModel({
    required Post post,
    required this.coverImageViewModelFactory,
    required this.userImageViewModelFactory,
  }) : _post = post;

  static final dateFormatter = DateFormat.yMMMd();

  int get id => _post.id;
  String get title => _post.title;
  String get description => _post.description;
  String? get coverImage => _post.coverImage;
  String get tags => _post.tagList.take(3).map((tag) => '#$tag').join(' ');
  String get readingTime => '${_post.readingTimeMinutes} min read';
  String get username => _post.user.name;
  String get userProfileImage => _post.user.profileImage;
  String get postedAt => dateFormatter.format(_post.publishedAt);
  String get likeCountLabel => '${_post.likeCount} likes';
}
