import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';
import 'package:prophub/src/repository/auth/auth_repository.dart';
import 'package:prophub/src/state/auth/view_models/response/login_response.dart';

import '../../../domain/entities/auth/login_entity.dart';
import '../../onboarding/view_models/request/onboarding_request.dart';

final userLoginProvider = FutureProvider.family<Either<PropHubExceptions, LoginResponse>, LoginEntity>(
    (ref, request) async => await ref.read(authRepositoryProvider).login(request));

final signUpProvider = FutureProvider.family<Either<PropHubExceptions, LoginResponse>, OnBoardingRequest>(
    (ref, request) async => await ref.read(authRepositoryProvider).createAccount(request));
