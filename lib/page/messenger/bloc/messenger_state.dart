part of 'messenger_cubit.dart';

abstract class MessengerState extends Equatable {
  const MessengerState();
}

class MessengerInitial extends MessengerState {
  @override
  List<Object> get props => [];
}

class MessengerLoading extends MessengerState {
  const MessengerLoading();

  @override
  List<Object> get props => [];
}

class MessengerDataLoaded extends MessengerState {
  final List<SalonLightData> privateRooms;
  final List<SalonLightData> customizeRooms;
  final List<Profile> profilePrivateRooms;
  final List<List<Profile>> profileCustomizeRooms;

  const MessengerDataLoaded({
    required this.privateRooms,
    required this.profilePrivateRooms,
    required this.customizeRooms,
    required this.profileCustomizeRooms,
  });

  @override
  List<Object?> get props => [
        privateRooms.map((e) => e.toJson()).toString(),
        customizeRooms.map((e) => e.toJson()).toString(),
      ];
}
