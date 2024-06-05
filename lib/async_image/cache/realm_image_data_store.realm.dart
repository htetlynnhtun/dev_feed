// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_image_data_store.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmImageCache extends _RealmImageCache
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmImageCache(
    String url, {
    Uint8List? data,
  }) {
    RealmObjectBase.set(this, 'url', url);
    RealmObjectBase.set(this, 'data', data);
  }

  RealmImageCache._();

  @override
  String get url => RealmObjectBase.get<String>(this, 'url') as String;
  @override
  set url(String value) => RealmObjectBase.set(this, 'url', value);

  @override
  Uint8List? get data =>
      RealmObjectBase.get<Uint8List>(this, 'data') as Uint8List?;
  @override
  set data(Uint8List? value) => RealmObjectBase.set(this, 'data', value);

  @override
  Stream<RealmObjectChanges<RealmImageCache>> get changes =>
      RealmObjectBase.getChanges<RealmImageCache>(this);

  @override
  Stream<RealmObjectChanges<RealmImageCache>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmImageCache>(this, keyPaths);

  @override
  RealmImageCache freeze() =>
      RealmObjectBase.freezeObject<RealmImageCache>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'url': url.toEJson(),
      'data': data.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmImageCache value) => value.toEJson();
  static RealmImageCache _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'url': EJsonValue url,
        'data': EJsonValue data,
      } =>
        RealmImageCache(
          fromEJson(url),
          data: fromEJson(data),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmImageCache._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, RealmImageCache, 'RealmImageCache', [
      SchemaProperty('url', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('data', RealmPropertyType.binary, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
