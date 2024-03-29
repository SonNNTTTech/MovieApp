import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/datasource/api_provider.dart';
import 'package:test_app/repository/auth/auth_model.dart';
import 'package:test_app/shared/app_helper.dart';

import '../shared_preferences/sp_repository.dart';

final authRepoProvider = Provider(AuthRepository.new);

class AuthRepository {
  final Ref _ref;
  late final ApiProvider _api = _ref.read(apiProvider);

  final headUrl = '/authentication';
  AuthRepository(this._ref);

  Future<Either<String, bool>> validateWithLogin(
      {required String userName, required String password}) async {
    try {
      final spRepo = _ref.read(spRepoProvider);
      final body = {
        'username': userName,
        'password': password,
        'request_token': await spRepo.getRequestToken(),
      };
      final response =
          await _api.post('$headUrl/token/validate_with_login', body);
      return await response.when(success: (json) async {
        return const Right(true);
      }, error: (error) {
        return Left(error);
      });
    } catch (e) {
      AppHelper.myLog('validateWithLogin: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> createRequestToken() async {
    try {
      final spRepo = _ref.read(spRepoProvider);
      final response = await _api.get('$headUrl/token/new');
      return await response.when(success: (json) async {
        final token =
            CreateRequestTokenResponse.fromJson(json).requestToken ?? '';
        await spRepo.setRequestToken(token);
        return Right(token);
      }, error: (error) {
        return Left(error);
      });
    } catch (e) {
      AppHelper.myLog('createRequestToken: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> createSessionId() async {
    final spRepo = _ref.read(spRepoProvider);
    final body = {'request_token': await spRepo.getRequestToken()};
    final response = await _api.post('$headUrl/session/new', body);
    return await response.when(success: (json) async {
      final sessionId = CreateSessionIdResponse.fromJson(json).sessionId!;
      await spRepo.setSessionId(sessionId);
      return Right(sessionId);
    }, error: (error) async {
      spRepo.deleteRequestToken();
      return Left(error);
    });
  }

  Future<Either<String, String>> createGuestSession() async {
    final spRepo = _ref.read(spRepoProvider);
    final response = await _api.get('$headUrl/guest_session/new');
    return await response.when(success: (json) async {
      final sessionId =
          CreateGuestSessionResponse.fromJson(json).guestSessionId!;
      await spRepo.setGuestSessionId(sessionId);
      return Right(sessionId);
    }, error: (error) {
      return Left(error);
    });
  }

  Future<Either<String, bool>> deleteSession() async {
    final spRepo = _ref.read(spRepoProvider);
    final body = {'session_id': await spRepo.getSessionId()};
    final response = await _api.delete('$headUrl/session', body);
    return await response.when(success: (json) async {
      return const Right(true);
    }, error: (error) async {
      return Left(error);
    });
  }
}
