import 'package:firebase_auth/firebase_auth.dart';

class UserToken {
  String? displayName;
  String? email;
  bool? emailVerified;
  bool? isAnonymous;
  String? phoneNumber;
  String? photoURL;
  String? refreshToken;
  String? tenantId;
  String? uid;

  UserToken(
      {this.displayName,
      this.email,
      this.emailVerified,
      this.isAnonymous,
      this.phoneNumber,
      this.photoURL,
      this.refreshToken,
      this.tenantId,
      this.uid});

  UserToken.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    isAnonymous = json['isAnonymous'];
    phoneNumber = json['phoneNumber'];
    photoURL = json['photoURL'];
    refreshToken = json['refreshToken'];
    tenantId = json['tenantId'];
    uid = json['uid'];
  }

  factory UserToken.fromUserFireBase(User user) {
    return UserToken(
        displayName: user.displayName,
        email: user.email,
        emailVerified: user.emailVerified,
        isAnonymous: user.isAnonymous,
        phoneNumber: user.phoneNumber,
        photoURL: user.photoURL,
        refreshToken: user.refreshToken,
        tenantId: user.tenantId,
        uid: user.uid);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName ?? "";
    data['email'] = email ?? "";
    data['emailVerified'] = emailVerified ?? "";
    data['isAnonymous'] = isAnonymous ?? "";
    data['phoneNumber'] = phoneNumber ?? "";
    data['photoURL'] = photoURL ?? "";
    data['refreshToken'] = refreshToken ?? "";
    data['tenantId'] = tenantId ?? "";
    data['uid'] = uid ?? "";
    return data;
  }
}
