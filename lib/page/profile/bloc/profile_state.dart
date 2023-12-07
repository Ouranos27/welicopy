part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class MyCardLoaded extends ProfileState {
  final List<CardData> cards;

  MyCardLoaded(this.cards);

  @override
  List<Object> get props => [cards.map((e) => e.toJson()).toString()];
}

class CurrentProfileCardLoaded extends ProfileState {
  final List<CardData> cards;

  CurrentProfileCardLoaded(this.cards);

  @override
  List<Object> get props => [cards.map((e) => e.toJson()).toString()];
}

class ProfileLoaded extends ProfileState {
  final Profile data;

  ProfileLoaded(this.data);

  @override
  List<Object> get props => [data.toJson()];
}
