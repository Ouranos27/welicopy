part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class SwipeCardLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class FavoriteCardLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class LikeCardRemoving extends HomeState {
  @override
  List<Object> get props => [];
}

class LikeCardRemoved extends HomeState {
  @override
  List<Object> get props => [];
}

class SwipeCardLoaded extends HomeState {
  final List<CardData> data;

  const SwipeCardLoaded(this.data);

  @override
  List<Object> get props => [data.map((e) => e.toJson())];
}

class FavoriteCardLoaded extends HomeState {
  final List<CardData> data;

  const FavoriteCardLoaded(this.data);

  @override
  List<Object> get props => [data.map((e) => e.toJson())];
}

class CardError extends HomeState {
  final Object error;

  CardError(this.error);

  @override
  List<Object?> get props => [error.hashCode];
}
