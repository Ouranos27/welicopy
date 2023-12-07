import 'package:weli/config/data.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/page/message/page/type.dart';

class RoomChatArgument {
  final String roomId;
  final String roomName;
  final ChatroomMessageType roomType;
  final String? roomCreator;

  // final List<Profile>? members;
  final bool canPopBack;

  RoomChatArgument({
    required this.roomId,
    required this.roomType,
    this.roomCreator,
    required this.roomName,
    // this.members,
    this.canPopBack = true,
  });

  static final defaultRoom = RoomChatArgument(
    roomId: AppData.weliDefaultRoomId,
    roomType: ChatroomMessageType.generalRoom,
    roomName: S.current.generalChatroom,
    canPopBack: false,
  );
}
