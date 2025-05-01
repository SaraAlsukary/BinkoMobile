part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory LoginEvent.fromMap(Map<String, dynamic> map) {
    return LoginEvent(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginEvent.fromJson(String source) =>
      LoginEvent.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CreateUserEvent extends AuthEvent {
  final String name;
  final String username;
  final String password;
  final String confirmPassword;

  const CreateUserEvent(
      {required this.name,
      required this.username,
      required this.password,
      required this.confirmPassword});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory CreateUserEvent.fromMap(Map<String, dynamic> map) {
    return CreateUserEvent(
      name: map['name'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateUserEvent.fromJson(String source) =>
      CreateUserEvent.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UpdateProfileEvent extends AuthEvent {
  final String name;
  final String description;
  final String image;

  const UpdateProfileEvent(
      {required this.name, required this.description, required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
    };
  }

  Map<String, String> toFile() {
    return <String, String>{
      'image': image,
    };
  }
}

class LogoutEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {}
