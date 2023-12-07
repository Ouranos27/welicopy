part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class MainLoaded extends MainState {
  final Profile profile;

  MainLoaded(this.profile);
}

class BottomNavBarIndexChanged extends MainState {
  final int index;

  BottomNavBarIndexChanged(this.index);
}
