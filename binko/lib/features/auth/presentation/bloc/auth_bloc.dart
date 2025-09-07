import 'dart:convert';
import 'dart:io';

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
  AuthBloc() : super(AuthState()) {
    on<CheckAuthEvent>((event, emit) async {
      emit(state.copyWith(status: state.status));
    });
    on<LoginEvent>((event, emit) async {
      Toaster.showLoading();
      final result = await AuthRepo(datasource: RemoteAuthDatasource())
          .login(event.toMap());
      result.fold((left) {
        Toaster.showToast(left.message, isError: true);
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
      try {
        emit(state.copyWith(
            status: RequestStatus.loading,
            createUserState: RequestStatus.loading));
        Toaster.showLoading();

        final result = await AuthRepo(datasource: RemoteAuthDatasource())
            .createUser(event.toMap());

        result.fold(
          (failure) {
            Toaster.showToast(failure.message, isError: true);
            emit(state.copyWith(
                status: RequestStatus.failed,
                createUserState: RequestStatus.failed));
          },
          (user) {
            emit(state.copyWith(
              user: user,
              status: RequestStatus.success,
              createUserState: RequestStatus.success,
            ));
          },
        );
      } catch (e) {
        emit(state.copyWith(
            status: RequestStatus.failed,
            createUserState: RequestStatus.failed));
        Toaster.showToast("Something went wrong");
      } finally {
        Toaster.closeLoading();
      }
    });
    on<UpdateProfileInfo>((event, emit) async {
      emit(state.copyWith(updateProfileState: RequestStatus.loading));
      Toaster.showLoading();

      try {
        final userId = state.user?.id;
        if (userId == null) {
          Toaster.showToast("User not authenticated");
          emit(state.copyWith(updateProfileState: RequestStatus.failed));
          Toaster.closeLoading();
          return;
        }

        final result = await AuthRepo(datasource: RemoteAuthDatasource())
            .updateProfile(userId, event.body, image: event.image);

        result.fold((failure) {
          Toaster.showToast(failure.message, isError: true);
          emit(state.copyWith(updateProfileState: RequestStatus.failed));
        }, (updatedUser) {
          emit(state.copyWith(
            user: updatedUser,
            age: updatedUser.age,
            discriptions: updatedUser.discriptions,
            isReader: updatedUser.isReader,
            updateProfileState: RequestStatus.success,
          ));
          Toaster.showToast("Profile updated successfully");
        });
      } catch (e) {
        Toaster.showToast("Failed to update profile: $e");
        emit(state.copyWith(updateProfileState: RequestStatus.failed));
      } finally {
        Toaster.closeLoading();
      }
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      return AuthState.fromMap(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    try {
      return state.toMap();
    } catch (e) {
      return null;
    }
  }
}
