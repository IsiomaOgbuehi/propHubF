import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';

import '../network/exceptions/object_parse_exception.dart';

// typedef EitherExceptionOrStringResponse = Either<PropHubExceptions, StringResponse>;
// typedef EitherExceptionOrSuccessResponse = Either<PropHubExceptions, SuccessfulAuthorizationResponse>;
typedef PropHubExceptionOr<T> = Either<PropHubExceptions, T>;
// typedef FutureAkuExceptionOr<T> = Future<AkuExceptionOr<T>>;

Either<PropHubExceptions, E> transform<E>(dynamic data, E Function(dynamic) transformer) {
  try {
    return Right(transformer(data));
  } on PropHubExceptions catch (e) {
    return Left(e);
  } on TypeError {
    return const Left(ObjectParseException());
  } on Exception catch (e) {
    return Left(GroundException(e.toString()));
  }
}

Either<PropHubExceptions, E> transformObject<E>(dynamic data, E Function(Object) transformer) {
  try {
    return Right(transformer(data));
  } on PropHubExceptions catch (e) {
    return Left(e);
  } on TypeError {
    return const Left(ObjectParseException());
  } on Exception catch (e) {
    return Left(GroundException(e.toString()));
  }
}

Future<PropHubExceptionOr<E>> processData<E>(
    E Function(dynamic) transformer, Either<PropHubExceptions, Response?> response) async {
  if (response.isLeft) return Left(response.left);

  return await compute((message) => transform(message, (p0) => transformer(p0)), response.right!.data);
}
