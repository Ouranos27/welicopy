import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';

class MessageRepository {
  final NetworkFactory _networkFactory;

  MessageRepository(this._networkFactory);

  Stream<List<MessageLightData>> loadChatDataByRoomId(String roomId, {required int limit}) {
    try {
      final response = _networkFactory.getListMessageByRoomId(roomId, limit: limit);

      final data = response.map((event) => event.map(MessageLightData.fromJson).toList());

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SalonLightData?> getPrivateRoomByUserId({required String uId, required String anotherUid}) async {
    final response = await _networkFactory.getAllSalons();
    final data = response.map(SalonLightData.fromJson).toList();
    final roomHasCurrentUid = data.where((element) {
      final isPrivateRoom = element.type == ChatroomMessageType.privateRoom;
      final contains1stId = element.members.any((id) => id == uId);
      final contains2ndId = element.members.any((id) => id == anotherUid);

      return isPrivateRoom && contains1stId && contains2ndId;
    });

    return roomHasCurrentUid.isNotEmpty ? roomHasCurrentUid.first : null;
  }

  Future<SalonLightData?> getRoomById(String id) async {
    final response = await _networkFactory.getSalonById(id);
    if (response != null) {
      return SalonLightData.fromJson(response);
    }
    return null;
  }

  Future<List<Profile>> getListProfileByListId(List<String> members) async {
    final response = await Future.wait(members.map(_networkFactory.getProfileById));
    return response.map(Profile.fromJson).toList();
  }

  Future<void> createPrivateRoomForUid({required String uId, required String anotherUid}) async {
    final data = <String, dynamic>{
      "members": [uId, anotherUid],
      "type": ChatroomMessageType.privateRoom.name,
      "createdAt": Timestamp.now(),
    };

    try {
      await _networkFactory.createNewSalons(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> sendMessage(String roomId, {required String message, required String uId}) async {
    final data = <String, dynamic>{
      "text": message,
      "senderData": uId,
      "sendDate": Timestamp.now(),
    };

    try {
      await _networkFactory.addToRoomMessages(roomId, data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> removeMembersFromSalon({required String salonId, required List<String> memberIds}) async {
    try {
      await _networkFactory.removeMembersFromSalon(memberIds: memberIds, salonId: salonId);
    } catch (e) {
      throw e.toString();
    }
  }
}
