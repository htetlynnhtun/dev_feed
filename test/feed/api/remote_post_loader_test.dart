import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:dev_feed/feed/api/api.dart';

import 'remote_post_loader_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('RemotePostLoader', () {
    test('load requests a get request to http client', () {
      final mockClient = MockClient();
      final sut = RemotePostLoader(client: mockClient);

      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response('[]', 200));
      sut.load();

      verify(mockClient.get(any)).called(1);
    });

    test('load throws a SocketException on network error', () {
      final mockClient = MockClient();
      final sut = RemotePostLoader(client: mockClient);

      when(mockClient.get(any)).thenThrow(
        const SocketException('Failed to connect'),
      );

      expect(sut.load(), throwsA(isA<SocketException>()));
    });
  });
}
