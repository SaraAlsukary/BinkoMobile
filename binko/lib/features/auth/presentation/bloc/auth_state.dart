// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState {
  final UserModel? user;
  final RequestStatus status;
  const AuthState({
    this.user,
    this.status = RequestStatus.init,
  });

  AuthState copyWith({
    UserModel? user,
    RequestStatus? status,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.index,
      'user': user?.toJson(),
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      status: RequestStatus.values[map['status']],
      user: map['user'] == null
          ? null
          : UserModel.fromJson(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source) as Map<String, dynamic>);
}
