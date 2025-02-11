import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';
import '../extensions/log_colors_extension.dart';
import '../services/shared_preferences_service.dart';

mixin HandlingExceptionManager {
  Future<Either<Failure, T>> wrapHandling<T>({
    required Future<T> Function() tryCall,
  }) async {
    try {
      final right = await tryCall();
      return Right(right);
    } on UnAuthenticatedException catch (e) {
      await SharedPreferencesService.removeToken();
      return Left(UnAuthenticatedFailure(e.message));
    } on TimeoutException {
      return Left(ServerFailure('Time Out'));
    } on ServerException catch (e) {
      log("<< ServerException >> ".logRed);
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("$e"));
    }
  }
}
