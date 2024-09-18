import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  final String? uid;
  String? email;
  String? password;
  String? username;
  String? name;
  String? photourl;
  String? friendurl;
  String? frienduid;
  String? chatroomid;
  String? addresss;
  String? phone;
  DateTime? accountcreated;

  OurUser(
      {this.uid,
      this.addresss,
      this.email,
      this.password,
      this.username,
      this.name,
      this.photourl,
      this.friendurl,
      this.frienduid,
      this.chatroomid,
      this.phone,
      this.accountcreated});

  factory OurUser.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return OurUser(
      name: document.data()!['name'],
      addresss: document.data()!['location'],
      // photourl: document.data()!['imageUrl'],
    );
  }
}

