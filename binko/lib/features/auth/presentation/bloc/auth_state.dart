// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState {
  final UserModel? user;
  final RequestStatus status;
  final int? age;
  final String? discriptions;
  final bool? isReader;
  final RequestStatus updateProfileState;
  final RequestStatus createUserState;

  const AuthState({
    this.createUserState = RequestStatus.init,
    this.age,
    this.discriptions,
    this.isReader,
    this.updateProfileState = RequestStatus.init,
    this.user,
    this.status = RequestStatus.init,
  });

  AuthState copyWith({
    UserModel? user,
    RequestStatus? status,
    int? age,
    String? discriptions,
    bool? isReader,
    RequestStatus? updateProfileState,
    RequestStatus? createUserState,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      age: age ?? this.age,
      discriptions: discriptions ?? this.discriptions,
      isReader: isReader ?? this.isReader,
      updateProfileState: updateProfileState ?? this.updateProfileState,
      createUserState: createUserState ?? this.createUserState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.index,
      'user': user?.toJson(),
      'age': age,
      'discriptions': discriptions,
      'isReader': isReader,
      'updateProfileState': updateProfileState.index,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      status: map.containsKey('status')
          ? RequestStatus.values[map['status'] as int]
          : RequestStatus.init,
      user: map['user'] == null
          ? null
          : UserModel.fromJson(Map<String, dynamic>.from(map['user'] as Map)),
      age: map['age'] as int?,
      discriptions: map['discriptions'] as String?,
      isReader: map['isReader'] as bool?,
      updateProfileState: map.containsKey('updateProfileState')
          ? RequestStatus.values[map['updateProfileState'] as int]
          : RequestStatus.init,
    );
  }

  String toJsonString() => json.encode(toMap());

  factory AuthState.fromJsonString(String source) =>
      AuthState.fromMap(json.decode(source) as Map<String, dynamic>);
}
