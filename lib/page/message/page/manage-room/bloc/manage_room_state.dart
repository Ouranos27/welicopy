part of 'manage_room_cubit.dart';

abstract class ManageRoomState extends Equatable {
  const ManageRoomState();
}

class ManageRoomInitial extends ManageRoomState {
  @override
  List<Object> get props => [];
}

class AllProfilesLoaded extends ManageRoomState {
  final List<Profile> profiles;

  const AllProfilesLoaded(this.profiles);

  @override
  // TODO: implement props
  List<Object?> get props => [profiles.map((e) => e.toJson())];
}

class AllProfilesLoading extends ManageRoomState {
  const AllProfilesLoading();

  @override
  List<Object?> get props => [];
}

class RoomDeleting extends ManageRoomState {
  const RoomDeleting();

  @override
  List<Object> get props => [];
}

class RoomDeleted extends ManageRoomState {
  const RoomDeleted();

  @override
  List<Object> get props => [];
}

class UserSearched extends ManageRoomState {
  const UserSearched();

  @override
  List<Object> get props => [];
}

class UserSearching extends ManageRoomState {
  const UserSearching();

  @override
  List<Object> get props => [];
}

class UserIdAdding extends ManageRoomState {
  const UserIdAdding();

  @override
  List<Object> get props => [];
}

class UserIdAdded extends ManageRoomState {
  const UserIdAdded();

  @override
  List<Object> get props => [];
}
