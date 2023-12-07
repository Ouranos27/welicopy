part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgotPasswordState extends Equatable {}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ForgotPasswordFailed extends ForgotPasswordState {
  final String message;

  ForgotPasswordFailed(this.message);

  @override
  List<Object?> get props => [message];
}
