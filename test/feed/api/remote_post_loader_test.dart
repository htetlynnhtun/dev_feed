import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:dev_feed/feed/api/api.dart';

import 'remote_post_loader_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  (RemotePostLoader, MockClient) makeSUT() {
    final mockClient = MockClient();
    return (RemotePostLoader(client: mockClient), mockClient);
  }

  group('RemotePostLoader', () {
    test('load requests a get request to http client', () {
      final (sut, mockClient) = makeSUT();

      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response('[]', 200));
      sut.load();

      verify(mockClient.get(any)).called(1);
    });

    test('load throws a SocketException on network error', () {
      final (sut, mockClient) = makeSUT();

      when(mockClient.get(any)).thenThrow(
        const SocketException('Failed to connect'),
      );

      expect(sut.load(), throwsA(isA<SocketException>()));
    });
  });
}
