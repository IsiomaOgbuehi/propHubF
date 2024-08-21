
class GroundException extends PropHubExceptions {
  final String exception;
  const GroundException(this.exception);

  @override
  String get message => exception;
}

abstract class PropHubExceptions implements Exception {
  const PropHubExceptions();
  String get message => 'An Error Occurred';

  @override
  String toString() => message;
}

class EmptyException extends PropHubExceptions {
  const EmptyException();

  @override
  String get message => '';
}