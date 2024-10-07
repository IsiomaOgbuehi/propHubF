import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/domain/entities/auth/login_entity.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';
import 'package:prophub/src/network/api_config.dart';
import 'package:prophub/src/network/network_provider.dart';
import 'package:prophub/src/state/auth/view_models/response/login_response.dart';
import 'package:prophub/src/utilities/data_transformer.dart';

abstract class AuthRepository {
  Future<Either<PropHubExceptions, LoginResponse>> login(LoginEntity loginData);
}

final authRepositoryProvider = Provider(
  (ref) => AuthRepositoryImp(AppNetworkProvider(ref: ref)),
);

class AuthRepositoryImp extends AuthRepository {
  final AppNetworkProvider _provider;
  AuthRepositoryImp(this._provider);

  @override
  Future<Either<PropHubExceptions, LoginResponse>> login(LoginEntity loginData) async {
    final response = await _provider.call(path: ApiConfig.login, method: RequestMethod.post, body: loginData.toJson());
    return await processData((p0) => LoginResponse.fromJson(p0), response);
  }
}
