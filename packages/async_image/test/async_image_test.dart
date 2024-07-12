import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:async/src/cancelable_operation.dart';
import 'package:async_image/async_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  (AsyncImageView, ImageDataLoaderSpy) makeSUT({
    String imageUrl = 'a-url.com',
  }) {
    final dataLoaderSpy = ImageDataLoaderSpy();
    final sut = AsyncImageView(
      imageUrl: imageUrl,
      dataLoader: (url) => dataLoaderSpy.load(url).asStream(),
    );
    return (sut, dataLoaderSpy);
  }

  group('AsyncImageView', () {
    testWidgets('initially displays loading indicator', (tester) async {
      final (sut, _) = makeSUT();

      await tester.pumpWidget(Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: sut,
          ),
        ),
      ));

      expect(sut.loadingIndicator, findsOne);
    });

    testWidgets('requests data loader to load image data for the given url',
        (tester) async {
      const imageUrl = 'a-url.com';
      final (sut, imageDataLoaderSpy) = makeSUT(imageUrl: imageUrl);

      await tester.pumpWidget(Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: sut,
          ),
        ),
      ));

      expect(imageDataLoaderSpy.loadedImageUrls, [imageUrl]);
    });

    testWidgets('displays failure view on loader failure', (tester) async {
      const imageUrl = 'a-url.com';
      final (sut, imageDataLoaderSpy) = makeSUT(imageUrl: imageUrl);

      await tester.pumpWidget(Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: sut,
          ),
        ),
      ));

      imageDataLoaderSpy.completeImageLoadingWithException(at: 0);
      await tester.pump();

      expect(
        sut.failureView,
        findsOne,
        reason: 'Expected failure view on loader failrue',
      );
    });

    testWidgets('retrys loading on tapping retry view', (tester) async {
      const imageUrl = 'a-url.com';
      final (sut, imageDataLoaderSpy) = makeSUT(imageUrl: imageUrl);

      await tester.pumpWidget(Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: sut,
          ),
        ),
      ));

      imageDataLoaderSpy.completeImageLoadingWithException(at: 0);
      await tester.pump();
      await tester.tap(sut.retryView);

      expect(
        imageDataLoaderSpy.loadedImageUrls,
        [imageUrl, imageUrl],
        reason: 'Expected another load request on retry',
      );
    });

    testWidgets('displays image view with successfully loaded data', (tester) async {
      const imageUrl = 'a-url.com';
      final (sut, imageDataLoaderSpy) = makeSUT(imageUrl: imageUrl);

      await tester.pumpWidget(Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: sut,
          ),
        ),
      ));

      final imageData = await tester.runAsync(() => createRedImage(1, 1));
      imageDataLoaderSpy.completImageLoading(data: imageData!, at: 0);
      await tester.pump();

      expect(
        sut.imageWithData(imageData),
        findsOne,
        reason: 'Expected image view with correct data',
      );
    });
  });
}

extension on AsyncImageView {
  Finder get loadingIndicator =>
      find.byKey(const ValueKey('async-image-loading-indicator'));

  Finder get failureView =>
      find.byKey(const ValueKey('async-image-failure-view'));

  Finder get retryView => find.byKey(const ValueKey('retry-button'));

  Finder imageWithData(Uint8List data) => find.byKey(ValueKey(data));
}

class ImageDataLoaderSpy implements ImageDataLoader {
  final _imageRequests = <(String, Completer<Uint8List>)>[];
  final _cancelledImageURLs = <String>[];

  List<String> get loadedImageUrls => _imageRequests.map((e) => e.$1).toList();
  List<String> get cancelledImageURLs => _cancelledImageURLs;

  @override
  CancelableOperation<Uint8List> load(Uri url) {
    final urlString = url.toString();
    final completer = Completer<Uint8List>();
    _imageRequests.add((urlString, completer));
    return CancelableOperation.fromFuture(
      completer.future,
      onCancel: () {
        _cancelledImageURLs.add(urlString);
        completer.completeError('Operation cancelled');
      },
    );
  }

  void completImageLoading({required Uint8List data, required int at}) {
    _imageRequests[at].$2.complete(data);
  }

  void completeImageLoadingWithException({required int at}) {
    _imageRequests[at].$2.completeError(Exception('any'));
  }
}

Future<Uint8List> createRedImage(int width, int height) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(
    recorder,
    Rect.fromPoints(
      const Offset(0, 0),
      Offset(
        width.toDouble(),
        height.toDouble(),
      ),
    ),
  );

  final paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  canvas.drawRect(
      Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()), paint);

  final picture = recorder.endRecording();
  final img = await picture.toImage(width, height);
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
