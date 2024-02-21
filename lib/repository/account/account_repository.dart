import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/datasource/api_provider.dart';

import '../shared_preferences/sp_repository.dart';
import 'account_model.dart';

final accountRepoProvider = Provider(AccountRepository.new);

class AccountRepository {
  final Ref _ref;
  late final ApiProvider _api = _ref.read(apiProvider);

  final headUrl = '/account';
  AccountRepository(this._ref);

  Future<Either<String, UserResponse>> getUser() async {
    final spRepo = _ref.read(spRepoProvider);
    final queryParameters = <String, dynamic>{};
    queryParameters['session_id'] = await spRepo.getSessionId();
    final response =
        await _api.get('$headUrl/20938939', query: queryParameters);
    return await response.when(success: (json) async {
      final user = UserResponse.fromJson(json);
      await spRepo.setAccountId(user.id ?? -1);
      return Right(user);
    }, error: (error) {
      return Left(error);
    });
  }

  Future<Either<String, bool>> favoriteMovie(
      int movieId, bool isFavorite) async {
    final spRepo = _ref.read(spRepoProvider);
    final queryParameters = <String, dynamic>{};
    queryParameters['session_id'] = await spRepo.getSessionId();
    final body = <String, dynamic>{};
    body['media_type'] = 'movie';
    body['media_id'] = movieId;
    body['favorite'] = isFavorite;
    final response = await _api.post('$headUrl/20938939/favorite', body,
        query: queryParameters);
    return response.when(success: (json) {
      return const Right(true);
    }, error: (error) {
      return Left(error);
    });
  }
}
