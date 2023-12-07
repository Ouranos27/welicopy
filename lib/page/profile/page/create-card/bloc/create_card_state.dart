part of 'create_card_cubit.dart';

@immutable
abstract class CreateCardState extends Equatable {}

class CreateCardInitial extends CreateCardState {
  @override
  List<Object?> get props => [];
}

class CreateCardLoading extends CreateCardState {
  @override
  List<Object?> get props => [];
}

class CreateCardSuccess extends CreateCardState {
  @override
  List<Object?> get props => [];
}

class CreateCardFailed extends CreateCardState {
  final String message;

  CreateCardFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class ImageLoading extends CreateCardState {
  @override
  List<Object?> get props => [];
}

class ImageLoaded extends CreateCardState {
  @override
  List<Object?> get props => [];
}
