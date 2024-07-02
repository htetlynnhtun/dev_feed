import 'dart:typed_data';

import 'image_data_store.dart';
import 'package:realm/realm.dart';

part 'realm_image_data_store.realm.dart';

final class RealmImageDataStore implements ImageDataStore {
  final Realm realm;

  RealmImageDataStore(this.realm);

  @override
  Future<void> insert(Uint8List data, Uri url) async {
    await realm.writeAsync(() {
      realm.add(
        RealmImageCache(
          url.toString(),
          data: data,
        ),
        update: true,
      );
    });
  }

  @override
  Future<Uint8List?> retrieve(Uri url) async {
    final cache = realm.find<RealmImageCache>(url.toString());
    return cache?.data;
  }
}

@RealmModel()
class _RealmImageCache {
  @PrimaryKey()
  late String url;
  late Uint8List? data;
}
