import 'package:dev_feed/constants.dart';
import 'package:intl/intl.dart';

import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/shared/viewmodel/view_model.dart';

class PostItemViewModel {
  final Post _post;
  final AsyncImageViewModelFactory asyncImageViewModelFactory;
  // final AsyncImageViewModelFactory coverImageViewModelFactory;
  // final AsyncImageViewModelFactory userImageViewModelFactory;

  PostItemViewModel({
    required Post post,
    // required this.coverImageViewModelFactory,
    // required this.userImageViewModelFactory,
    required this.asyncImageViewModelFactory,
  }) : _post = post;

  static final dateFormatter = DateFormat.yMMMd();

  int get id => _post.id;
  String get title => _post.title;
  String get description => _post.description;
  String get tags => _post.tagList.take(3).map((tag) => '#$tag').join(' ');
  String get readingTime => '${_post.readingTimeMinutes} min read';
  String get username => _post.user.name;
  String get postedAt => dateFormatter.format(_post.publishedAt);
  String get likeCountLabel => '${_post.likeCount} likes';
  String get userProfileImageUrl => _post.user.profileImage;

  String coverImageUrl() {
    return _post.coverImage ?? flutterImage;
  }
}
