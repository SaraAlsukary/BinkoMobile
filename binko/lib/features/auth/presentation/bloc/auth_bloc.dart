import 'dart:convert';

import 'package:binko/core/utils/request_status.dart';
import 'package:binko/core/utils/toaster.dart';
import 'package:binko/features/auth/data/datasources/remote_auth_datasource.dart';
import 'package:binko/features/auth/data/models/user_model.dart';
import 'package:binko/features/auth/data/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          AuthState(),
        ) {
    on<CheckAuthEvent>((event, emit) async {
      emit(state.copyWith(status: state.status));
    });
    on<LoginEvent>((event, emit) async {
      Toaster.showLoading();
      final result = await AuthRepo(datasource: RemoteAuthDatasource())
          .login(event.toMap());
      result.fold((left) {
        Toaster.showToast(left.message);
      }, (right) {
        emit(state.copyWith(status: RequestStatus.success, user: right));
      });
      Toaster.closeLoading();
    });
    on<LogoutEvent>((event, emit) async {
      emit(AuthState());
      clear();
    });
    on<CreateUserEvent>((event, emit) async {
      Toaster.showLoading();
      final result = await AuthRepo(datasource: RemoteAuthDatasource())
          .createUser(event.toMap());
      result.fold((left) {
        Toaster.showToast(left.message);
      }, (right) {
        emit(state.copyWith(user: right));
      });
      Toaster.closeLoading();
    });

    on<UpdateProfileEvent>((event, emit) async {
      Toaster.showLoading();
      final result = await AuthRepo(datasource: RemoteAuthDatasource())
          .updateProfile(state.user!.id!, event.toMap());
      result.fold((left) {
        Toaster.showToast(left.message);
      }, (right) {
        emit(state.copyWith(user: right));
      });
      Toaster.closeLoading();
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
