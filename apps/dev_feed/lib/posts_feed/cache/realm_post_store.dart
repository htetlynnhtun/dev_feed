import 'dart:async';

import 'package:realm/realm.dart' hide User;

import 'package:dev_feed/posts_feed/cache/post_store.dart';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/shared/model/model.dart';
import 'package:dev_feed/util/serial_operation_queue_mixin.dart';

part 'realm_post_store.realm.dart';

class RealmPostStore with SerialOperationQueueMixin implements PostStore {
  final Realm realm;

  RealmPostStore({required this.realm});

  @override
  Future<void> deleteCachedPosts() {
    return addOperation(() async {
      await realm.writeAsync(() {
        realm.deleteAll<RealmPost>();
      });
    });
  }

  @override
  Future<void> insert(List<Post> posts) async {
    return addOperation(() async {
      await realm.writeAsync(() {
        realm.deleteAll<RealmPost>();
        realm.addAll(posts.map(
          (e) => e._toRealmModel(),
        ));
      });
    });
  }

  @override
  Future<List<Post>> retrieve() async {
    return addOperationWithResult(() async {
      final result = realm.all<RealmPost>();
      return result.map((e) => e._toDomain()).toList();
    });
  }
}

@RealmModel()
class _RealmPost {
  @PrimaryKey()
  late int id;
  late String title;
  late String description;
  late String? coverImage;
  late List<String> tagList;
  late int readingTimeMinutes;
  late DateTime publishedAt;
  late int likeCount;
  late _RealmUser? user;
}

@RealmModel(ObjectType.embeddedObject)
class _RealmUser {
  late ObjectId id;
  late String name;
  late String profileImage;
}

extension on Post {
  RealmPost _toRealmModel() => RealmPost(
        id,
        title,
        description,
        readingTimeMinutes,
        publishedAt,
        likeCount,
        tagList: tagList,
        coverImage: coverImage,
        user: RealmUser(
          ObjectId(),
          user.name,
          user.profileImage,
        ),
      );
}

extension on RealmPost {
  Post _toDomain() => Post(
        id: id,
        title: title,
        description: description,
        coverImage: coverImage,
        tagList: tagList.toList(),
        readingTimeMinutes: readingTimeMinutes,
        publishedAt: publishedAt.toLocal(),
        likeCount: likeCount,
        user: user!._toDomain(),
      );
}

extension on RealmUser {
  User _toDomain() => User(name: name, profileImage: profileImage);
}
