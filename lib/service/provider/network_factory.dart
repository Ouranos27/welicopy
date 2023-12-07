import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weli/page/profile/page/swipe-card/bloc/home_cubit.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/firebase_constant.dart';

/// Function firebase
class NetworkFactory {
  final _firebase = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  UserToken? user;

  NetworkFactory({this.user});

  /// return one-time read date
  Future<Map<String, dynamic>> getProfile() async {
    final profile = await _firebase.collection(FireConstant.PROFILES).doc(user!.uid).get();
    var data = {...?profile.data(), "id": profile.id};
    return data;
  }

  Future<Map<String, dynamic>> getProfileById(String uId) async {
    final profile = await _firebase.collection(FireConstant.PROFILES).doc(uId).get();
    var data = {...?profile.data(), "id": profile.id};
    return data;
  }

  /// return one-time read date
  Future<List<Map<String, dynamic>>> getCardsById(String userId) async {
    final data = await _firebase.collection(FireConstant.CARDS).where('userId', isEqualTo: userId).get();
    return data.docs.map((e) => {...e.data(), "id": e.id}).toList();
  }

  Future<void> deleteCardById(String cardId) async {
    await _firebase.collection(FireConstant.CARDS).doc(cardId).delete();
  }

  Future<List<Map<String, dynamic>>> getSwipeCards(String userId) async {
    final cardReactionsAsync = await _firebase.doc("${FireConstant.CARD_REACTIONS}/${user?.uid}").get();
    final allCardsAsync = await _firebase.collection(FireConstant.CARDS).where('userId', isEqualTo: userId).get();

    final cardReactions = cardReactionsAsync.data() ?? {};

    final allCards = allCardsAsync.docs.toList();
    final likes = cardReactions['likes'] ?? {};
    final dislikes = cardReactions['dislikes'] ?? {};

    final dataReturn = allCards
        .where(
          (card) => !(likes.containsKey(card.id) || dislikes.containsKey(card.id)),
        )
        .map(
          (e) => {...e.data(), "id": e.id},
        );

    return dataReturn.sorted(_lastActionCompare);
  }

  Future<List<Map<String, dynamic>>> getFavoriteCards(String userId) async {
    final cardReactionsAsync = await _firebase.doc("${FireConstant.CARD_REACTIONS}/${user?.uid}").get();

    final allCardsAsync = await _firebase.collection(FireConstant.CARDS).get();

    final cardReactions = cardReactionsAsync.data() ?? {};
    final allCards = allCardsAsync.docs.where((cardDoc) => cardDoc.data()['userId'] != userId).toList();

    final dataReturn = allCards
        .where(
          (card) => (cardReactions['likes']?? {}).containsKey(card.id),
        )
        .map(
          (e) => {...e.data(), "id": e.id},
        );

    return dataReturn.sorted(_lastActionCompare);
  }

  Future<void> reactCard(String userId, String cardId, ReactState state) async {
    var isLikeState = state == ReactState.like;

    await _firebase.doc("${FireConstant.CARD_REACTIONS}/$userId").set(
      {
        '${isLikeState ? 'likes' : 'dislikes'}': {cardId: FieldValue.serverTimestamp()},
        '${isLikeState ? 'dislikes' : 'likes'}': {cardId: FieldValue.delete()}
      },
      SetOptions(merge: true),
    );
  }

  Future<void> removeLikeCard(String userId, String cardId) async {
    return _firebase.doc('${FireConstant.CARD_REACTIONS}/$userId').set(
      {
        'likes': {cardId: FieldValue.delete()}
      },
      SetOptions(merge: true),
    );
  }

  int _lastActionCompare(Map<String, dynamic> card1, Map<String, dynamic> card2) => _lastActionTime(card1).compareTo(_lastActionTime(card2));

  Timestamp _lastActionTime(Map<String, dynamic> card) => card[_mostRecentTimeField(card)];

  String _mostRecentTimeField(Map<String, dynamic> card) {
    final orderedFields = ['publishedAt', 'rejectedAt', 'submittedAt', 'modifiedAt', 'createdAt'];
    for (final field in orderedFields) {
      if (card[field] != null) return field;
    }
    assert(false);
    return 'error';
  }

  Future<String?> uploadPicture({required File pic, required String userId, required String folder}) async {
    final fileName = pic.path.split('/').last;
    final ref = _firebaseStorage.ref().child('$folder/$userId/$fileName');
    await ref.putFile(pic).whenComplete(() => null);
    return await ref.getDownloadURL();
  }

  Future<void> upsertUser(String userId, Map<String, dynamic> data) {
    CollectionReference userProfile = FirebaseFirestore.instance.collection(FireConstant.PROFILES);
    return userProfile.doc(userId).set(data, SetOptions(merge: true)).catchError((error) {
      throw error;
    });
  }

  Future<void> createNewCard(Map<String, dynamic> data) async {
    await _firebase.collection(FireConstant.CARDS).add({...data, "createdAt": Timestamp.now()}).catchError((error) {
      throw error;
    });
  }

  Future<void> editCard(Map<String, dynamic> data, String cardId) async {
    await _firebase.collection(FireConstant.CARDS).doc(cardId).update({...data, "updatedAt": Timestamp.now()}).catchError((error) {
      throw error;
    });
  }

  Future<void> createNewSalons(Map<String, dynamic> data) async {
    await _firebase.collection(FireConstant.SALONS).add(data).catchError((error) {
      throw error;
    });
  }

  Future<List<Map<String, dynamic>>> getAllSalons() async {
    final data = await _firebase.collection(FireConstant.SALONS).orderBy('createdAt', descending: true).where('members', arrayContains: user!.uid).get();
    return data.docs.map((e) => {...e.data(), "id": e.id}).toList();
  }

  Future<List<Map<String, dynamic>>> getAllSalonsList() async {
    final data = await _firebase.collection(FireConstant.SALONS).orderBy('createdAt', descending: true).get();
    return data.docs.map((e) => {...e.data(), "id": e.id}).toList();
  }

  Stream<List<Map<String, dynamic>>> getUserSalonStream() {
    final data = _firebase.collection('${FireConstant.SALONS}').where('members', arrayContains: user!.uid).snapshots();

    return data.map((event) => event.docs.map((e) => {...e.data(), "id": e.id}).toList());
  }

  Stream<List<Map<String, dynamic>>> getAllSalonsStream() {
    final data = _firebase.collection('${FireConstant.SALONS}').orderBy('createdAt', descending: true).snapshots();

    return data.map((event) => event.docs.map((e) => {...e.data(), "id": e.id}).toList());
  }

  Future<Map<String, dynamic>?> getSalonById(String roomId) async {
    final data = await _firebase.doc('${FireConstant.SALONS}/$roomId').get();
    if (data.exists) {
      return {...?data.data(), "id": data.id};
    }
    return null;
  }

  Future<void> addToRoomMessages(String roomId, Map<String, dynamic> data) {
    return _firebase.collection('${FireConstant.SALONS}/$roomId/messages').add(data);
  }

  Stream<List<Map<String, dynamic>>> getListMessageByRoomId(String roomId, {required int limit}) {
    final data = _firebase.collection('${FireConstant.SALONS}/$roomId/messages').orderBy("sendDate", descending: true).limit(limit).snapshots();

    return data.map((event) => event.docs.map((e) => {...e.data(), "id": e.id}).toList());
  }

  Future<List<Map<String, dynamic>>> searchUser(String key) async {
    final data = await _firebase.collection('${FireConstant.PROFILES}').get();
    final users = data.docs.where((element) => ((element.data()['email'].toString()).contains(key) ||
        (element.data()['firstName'].toString()).contains(key) ||
        (element.data()['lastName'].toString()).contains(key)));
    final result = users.map((e) => {...e.data(), 'id': e.id}).toList();
    return result;
  }

  Future<void> deleteSalon(String salonId) async {
    await _firebase.collection(FireConstant.SALONS).doc(salonId).delete();
  }

  Future<void> removeMembersFromSalon({required List<String> memberIds, required String salonId}) async {
    final salon = await _firebase.collection(FireConstant.SALONS).doc(salonId).get();
    var members = (salon.data()!['members'] as List).cast<String>();
    memberIds.map((e) {
      final index = members.indexWhere((element) => element == e);
      return members.removeAt(index);
    }).toList();
    await _firebase.collection(FireConstant.SALONS).doc(salonId).update({'members': members}).catchError((error) {
      throw error;
    });
  }

  Future<void> addMembersToSalon({required List<String> memberIds, required String salonId}) async {
    final salon = await _firebase.collection(FireConstant.SALONS).doc(salonId).get();
    var members = (salon.data()!['members'] as List).cast<String>();
    members.addAll(memberIds);
    await _firebase.collection(FireConstant.SALONS).doc(salonId).update({'members': members}).catchError((error) {
      throw error;
    });
  }

  Future<List<Map<String, dynamic>>> getSalonIdByName(String salonName) async {
    final response = await _firebase.collection(FireConstant.SALONS).where('name', isEqualTo: salonName).get();
    return response.docs.map((e) => {...e.data(), "id": e.id}).toList();
  }

  Future<void> updateDeviceTokenToProfile(String token) async {
    await Future.wait([
      clearTokenWhenValidToOtherUser(token),
      _firebase.collection(FireConstant.PROFILES).doc("${user?.uid}").update({
        "deviceToken": FieldValue.arrayUnion([token]),
      })
    ]);
  }

  Future<void> clearTokenWhenValidToOtherUser(String token) async {
    final tokenExist = await _firebase.collection(FireConstant.PROFILES).where("deviceToken", arrayContains: token).get();

    if (tokenExist.docs.isEmpty) return;

    await Future.wait(
      tokenExist.docs.where((element) => element.id != user?.uid).map(
            (e) => _firebase.collection(FireConstant.PROFILES).doc("${e.id}").update(
              {
                "deviceToken": FieldValue.arrayRemove([token]),
              },
            ),
          ),
    );
  }

  Future<void> clearToken(String token) async {
    await _firebase.collection(FireConstant.PROFILES).doc("${user?.uid}").update({
      "deviceToken": FieldValue.arrayRemove([token]),
    });
  }
}
