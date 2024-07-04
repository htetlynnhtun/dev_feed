import 'dart:async';

mixin SerialOperationQueueMixin {
  Future<void> _lastOperation = Future.value();

  Future<void> addOperation(Future<void> Function() operation) {
    _lastOperation = _lastOperation.then((_) => operation());
    return _lastOperation;
  }

  Future<T> addOperationWithResult<T>(Future<T> Function() operation) {
    final completer = Completer<T>();
    _lastOperation = _lastOperation.then((_) async {
      try {
        final result = await operation();
        completer.complete(result);
      } catch (error) {
        completer.completeError(error);
      }
    });
    return completer.future;
  }
}
