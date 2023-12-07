part of 'salons_cubit.dart';

abstract class SalonsState extends Equatable {
  const SalonsState();
}

class SalonsInitial extends SalonsState {
  @override
  List<Object> get props => [];
}

class SalonsLoaded extends SalonsState {
  final List<SalonLightData> customizeRooms;
  final List<SalonLightData> generalRooms;
  final List<SalonLightData> otherRooms;
  final List<List<Profile>> profileGeneralRooms;
  final List<List<Profile>> profileCustomizeRooms;
  final List<List<Profile>> profileOtherRooms;

  const SalonsLoaded({
    required this.customizeRooms,
    required this.generalRooms,
    required this.profileCustomizeRooms,
    required this.profileGeneralRooms,
    required this.otherRooms,
    required this.profileOtherRooms,
  });

  @override
  List<Object> get props => [DateTime.now()];
}

class SalonsLoading extends SalonsState {
  const SalonsLoading();

  @override
  List<Object> get props => [];
}

class SalonsSearching extends SalonsState {
  const SalonsSearching();

  @override
  List<Object> get props => [];
}

class UserSearching extends SalonsState {
  const UserSearching();

  @override
  List<Object> get props => [];
}

class UserSearched extends SalonsState {
  const UserSearched();

  @override
  List<Object> get props => [];
}

class UserIdAdding extends SalonsState {
  const UserIdAdding();

  @override
  List<Object> get props => [];
}

class UserIdAdded extends SalonsState {
  const UserIdAdded();

  @override
  List<Object> get props => [];
}

class SalonCreating extends SalonsState {
  const SalonCreating();

  @override
  List<Object> get props => [];
}

class SalonCreated extends SalonsState {
  const SalonCreated();

  @override
  List<Object> get props => [];
}
