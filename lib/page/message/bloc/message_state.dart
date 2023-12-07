part of 'message_cubit.dart';

abstract class MessageState extends Equatable {
  const MessageState();
}

class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoaded extends MessageState {
  final List<MessageLightData> messages;

  const MessageLoaded(this.messages);

  @override
  List<Object?> get props => [messages.map((e) => e.toJson())];
}

class AllProfilesLoaded extends MessageState {
  final List<Profile> profiles;

  const AllProfilesLoaded(this.profiles);

  @override
  // TODO: implement props
  List<Object?> get props => [profiles.map((e) => e.toJson())];
}

class AllProfilesLoading extends MessageState {
  const AllProfilesLoading();

  @override
  List<Object?> get props => [];
}

class PrivateChatDataLoaded extends MessageState {
  final SalonLightData data;

  const PrivateChatDataLoaded(this.data);

  @override
  List<Object?> get props => [data.toJson()];
}

class MessageSent extends MessageState {
  final String text;

  MessageSent(this.text);

  @override
  List<Object?> get props => [text, DateTime.now()];
}
