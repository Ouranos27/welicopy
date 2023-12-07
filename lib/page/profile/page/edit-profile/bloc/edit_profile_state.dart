part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState extends Equatable {}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object?> get props => [];
}

class EditProfileLoading extends EditProfileState {
  @override
  List<Object?> get props => [];
}

class ImageLoading extends EditProfileState {
  @override
  List<Object?> get props => [];
}

class ImageLoaded extends EditProfileState {
  @override
  List<Object?> get props => [];
}

class EditProfileSuccess extends EditProfileState {
  final List<String> investmentType;

  EditProfileSuccess(this.investmentType);
  @override
  List<Object?> get props => [];
}

class EditProfileFailed extends EditProfileState {
  final String message;

  EditProfileFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class Error extends EditProfileState {
  Error();

  @override
  List<Object?> get props => [];
}
