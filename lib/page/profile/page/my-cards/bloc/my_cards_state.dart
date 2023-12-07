part of 'my_cards_cubit.dart';

abstract class MyCardsState extends Equatable {
  const MyCardsState();
}

class MyCardsInitial extends MyCardsState {
  @override
  List<Object> get props => [];
}

class MyCardLoaded extends MyCardsState {
  final List<CardData> cards;

  MyCardLoaded(this.cards);

  @override
  List<Object> get props => [cards.map((e) => e.toJson()).toString()];
}

class MyCardLoading extends MyCardsState {
  MyCardLoading();

  @override
  List<Object> get props => [];
}
