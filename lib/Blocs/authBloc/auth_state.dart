part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


final class LoginInitial extends AuthState {}

final class LoginSuccsess extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginFailed extends AuthState {
  final String errMsg;
  LoginFailed({required this.errMsg});
}

final class RegisterInitial extends AuthState {}

final class RegisterFailed extends AuthState {
  final String errMsg;
  RegisterFailed(this.errMsg);
}

final class RegisterSuccess extends AuthState {}

final class RegisterLoading extends AuthState {}
