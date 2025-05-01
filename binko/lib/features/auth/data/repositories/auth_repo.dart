import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../../../core/utils/type_defs.dart';
import '../datasources/remote_auth_datasource.dart';
import '../models/user_model.dart';

class AuthRepo with HandlingExceptionManager {
  final RemoteAuthDatasource datasource;
  Future<Either<Failure, UserModel>> login(BodyMap body) async {
    return wrapHandling(tryCall: () async {
      return await datasource.login(body);
    });
  }

  Future<Either<Failure, UserModel>> createUser(BodyMap body) async {
    return wrapHandling(tryCall: () async {
      return await datasource.createUser(body);
    });
  }

  Future<Either<Failure, UserModel>> updateProfile(int id, BodyMap body) async {
    return wrapHandling(tryCall: () async {
      return await datasource.updateProfile(id, body);
    });
  }

  AuthRepo({required this.datasource});
}
