part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class InitMain extends MainEvent {}

class ChangeNavbar extends MainEvent {
  final int index;

  ChangeNavbar(this.index);
}
