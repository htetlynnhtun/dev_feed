import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart' as test;

import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/shared/model/model.dart';

@isTest
void valueNotifierTest<Notifier extends ValueNotifier<Value>, Value>(
  String description, {
  required Notifier Function() arrange,
  dynamic Function(Notifier notifier)? act,
  required List<Value> expectedValues,
  Object? skip,
}) {
  test.test(description, () async {
    final sut = arrange.call();
    final notifiedValues = <Value>[];
    sut.addListener(() {
      notifiedValues.add(sut.value);
    });

    await act?.call(sut);

    await Future.delayed(Duration.zero);

    sut.dispose();

    test.expect(notifiedValues, expectedValues);
  }, skip: skip);
}

Post makePost({
  required int id,
  String? coverImage,
  String? profileImage,
}) {
  return Post(
    id: id,
    title: 'title',
    description: 'description',
    coverImage: coverImage,
    tagList: ['a', 'b'],
    readingTimeMinutes: 1,
    publishedAt: DateTime.now(),
    likeCount: 1,
    user: User(name: 'name', profileImage: profileImage ?? 'image.com'),
  );
}

List<Post> uniquePosts() {
  return [
    makePost(id: 1),
    makePost(id: 2),
  ];
}

String generateRandomRealmName({int len = 10}) {
  final r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final nameBase =
      List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  return '$nameBase.realm';
}
