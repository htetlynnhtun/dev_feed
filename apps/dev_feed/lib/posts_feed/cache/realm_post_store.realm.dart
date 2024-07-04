// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_post_store.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmPost extends _RealmPost
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmPost(
    int id,
    String title,
    String description,
    int readingTimeMinutes,
    DateTime publishedAt,
    int likeCount, {
    String? coverImage,
    Iterable<String> tagList = const [],
    RealmUser? user,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'coverImage', coverImage);
    RealmObjectBase.set<RealmList<String>>(
        this, 'tagList', RealmList<String>(tagList));
    RealmObjectBase.set(this, 'readingTimeMinutes', readingTimeMinutes);
    RealmObjectBase.set(this, 'publishedAt', publishedAt);
    RealmObjectBase.set(this, 'likeCount', likeCount);
    RealmObjectBase.set(this, 'user', user);
  }

  RealmPost._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String? get coverImage =>
      RealmObjectBase.get<String>(this, 'coverImage') as String?;
  @override
  set coverImage(String? value) =>
      RealmObjectBase.set(this, 'coverImage', value);

  @override
  RealmList<String> get tagList =>
      RealmObjectBase.get<String>(this, 'tagList') as RealmList<String>;
  @override
  set tagList(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  int get readingTimeMinutes =>
      RealmObjectBase.get<int>(this, 'readingTimeMinutes') as int;
  @override
  set readingTimeMinutes(int value) =>
      RealmObjectBase.set(this, 'readingTimeMinutes', value);

  @override
  DateTime get publishedAt =>
      RealmObjectBase.get<DateTime>(this, 'publishedAt') as DateTime;
  @override
  set publishedAt(DateTime value) =>
      RealmObjectBase.set(this, 'publishedAt', value);

  @override
  int get likeCount => RealmObjectBase.get<int>(this, 'likeCount') as int;
  @override
  set likeCount(int value) => RealmObjectBase.set(this, 'likeCount', value);

  @override
  RealmUser? get user =>
      RealmObjectBase.get<RealmUser>(this, 'user') as RealmUser?;
  @override
  set user(covariant RealmUser? value) =>
      RealmObjectBase.set(this, 'user', value);

  @override
  Stream<RealmObjectChanges<RealmPost>> get changes =>
      RealmObjectBase.getChanges<RealmPost>(this);

  @override
  Stream<RealmObjectChanges<RealmPost>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmPost>(this, keyPaths);

  @override
  RealmPost freeze() => RealmObjectBase.freezeObject<RealmPost>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'title': title.toEJson(),
      'description': description.toEJson(),
      'coverImage': coverImage.toEJson(),
      'tagList': tagList.toEJson(),
      'readingTimeMinutes': readingTimeMinutes.toEJson(),
      'publishedAt': publishedAt.toEJson(),
      'likeCount': likeCount.toEJson(),
      'user': user.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmPost value) => value.toEJson();
  static RealmPost _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'title': EJsonValue title,
        'description': EJsonValue description,
        'coverImage': EJsonValue coverImage,
        'tagList': EJsonValue tagList,
        'readingTimeMinutes': EJsonValue readingTimeMinutes,
        'publishedAt': EJsonValue publishedAt,
        'likeCount': EJsonValue likeCount,
        'user': EJsonValue user,
      } =>
        RealmPost(
          fromEJson(id),
          fromEJson(title),
          fromEJson(description),
          fromEJson(readingTimeMinutes),
          fromEJson(publishedAt),
          fromEJson(likeCount),
          coverImage: fromEJson(coverImage),
          tagList: fromEJson(tagList),
          user: fromEJson(user),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmPost._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, RealmPost, 'RealmPost', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('coverImage', RealmPropertyType.string, optional: true),
      SchemaProperty('tagList', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('readingTimeMinutes', RealmPropertyType.int),
      SchemaProperty('publishedAt', RealmPropertyType.timestamp),
      SchemaProperty('likeCount', RealmPropertyType.int),
      SchemaProperty('user', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmUser'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RealmUser extends _RealmUser
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  RealmUser(
    ObjectId id,
    String name,
    String profileImage,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'profileImage', profileImage);
  }

  RealmUser._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get profileImage =>
      RealmObjectBase.get<String>(this, 'profileImage') as String;
  @override
  set profileImage(String value) =>
      RealmObjectBase.set(this, 'profileImage', value);

  @override
  Stream<RealmObjectChanges<RealmUser>> get changes =>
      RealmObjectBase.getChanges<RealmUser>(this);

  @override
  Stream<RealmObjectChanges<RealmUser>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmUser>(this, keyPaths);

  @override
  RealmUser freeze() => RealmObjectBase.freezeObject<RealmUser>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'profileImage': profileImage.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmUser value) => value.toEJson();
  static RealmUser _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'profileImage': EJsonValue profileImage,
      } =>
        RealmUser(
          fromEJson(id),
          fromEJson(name),
          fromEJson(profileImage),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmUser._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.embeddedObject, RealmUser, 'RealmUser', [
      SchemaProperty('id', RealmPropertyType.objectid),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('profileImage', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
