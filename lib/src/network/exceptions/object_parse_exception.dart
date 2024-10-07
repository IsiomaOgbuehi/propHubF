import 'package:prophub/src/exceptions/ground_exception.dart';

class ObjectParseException extends PropHubExceptions {
  const ObjectParseException();

  @override
  String get message => 'We encountered a problem trying to reach the server. We are working to fix it...';

  @override
  List<Object?> get props => [message];
}
