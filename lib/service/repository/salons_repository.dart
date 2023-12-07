import 'package:weli/page/message/page/type.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/util/logger.dart';

class SalonsRepository {
  final NetworkFactory _networkFactory;

  SalonsRepository(this._networkFactory);

  Future<void> createNewSalons(Map<String, dynamic> data) async {
    try {
      await _networkFactory.createNewSalons(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Profile>> getListProfileByListId(List<String> members) async {
    final response = await Future.wait(members.map(_networkFactory.getProfileById));
    return response.map(Profile.fromJson).toList();
  }

  Stream<List<SalonLightData>> getUserSalonList() {
    try {
      final response = _networkFactory.getUserSalonStream();

      final data = response.map((event) => event.map(SalonLightData.fromJson).toList());

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<List<SalonLightData>> getAllSalonsList() {
    try {
      final response = _networkFactory.getAllSalonsStream();

      final data = response.map((event) => event.map(SalonLightData.fromJson).toList());

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Profile>> searchUserByEmail(String key) async {
    try {
      var response = await _networkFactory.searchUser(key);
      final data = response.map(Profile.fromJson).toList();
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<SalonLightData>> searchSalon(String key) async {
    final keyConverted = key.replaceAll("[^\\p{ASCII}]", "").toLowerCase();
    try {
      final response = await _networkFactory.getAllSalonsList();
      final salonList = response.map(SalonLightData.fromJson).toList();
      return salonList
          .where((element) => element.name != null && element.name.toString().replaceAll("[^\\p{ASCII}]", "").toLowerCase().contains(keyConverted))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<SalonLightData>> getPrivateSalons() async {
    try {
      final response = await _networkFactory.getAllSalons();
      final salons = response.map(SalonLightData.fromJson).toList();

      final privateSalons = salons.where((element) => element.type == ChatroomMessageType.privateRoom && element.members.length == 2).toList();

      return privateSalons;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteSalon(String salonId) async {
    try {
      await _networkFactory.deleteSalon(salonId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addUsersToSalon(String salonId, List<String> userIds) async {
    try {
      await _networkFactory.addMembersToSalon(memberIds: userIds, salonId: salonId);
    } catch (e) {
      debugConsoleLog(e);
    }
  }
}
