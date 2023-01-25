import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final dataPublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  Comment({
    required this.username,
    required this.comment,
    required this.dataPublished,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "profilePhoto": profilePhoto,
        "uid": uid,
        "id": id,
        "comment": comment,
        "likes": likes,
        "dataPublished": dataPublished,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      username: snapshot["username"],
      profilePhoto: snapshot["profilePhoto"],
      uid: snapshot["uid"],
      id: snapshot["id"],
      comment: snapshot["comment"],
      dataPublished: snapshot["dataPublished"],
      likes: snapshot["likes"],
    );
  }
}
