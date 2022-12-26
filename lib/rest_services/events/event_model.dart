import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String? user;
  String? title;
  String? location;
  String? dateAndTime;
  String? description;
  String? photo;
  int? status;
  Timestamp? createdAt;

  EventModel(
      {this.id,
      this.user,
      this.title,
      this.location,
      this.dateAndTime,
      this.description,
      this.photo,
      this.status,
      this.createdAt});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    user = json['user'] as String;
    title = json['title'] as String;
    location = json['location'] as String;
    dateAndTime = json['dateAndTime'] as String;
    description = json['description'] as String;
    photo = json['photo'] as String;
    status = json['status'] as int;
    createdAt = json['createdAt'] as Timestamp;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (user != null) data['user'] = user;
    if (title != null) data['title'] = title;
    if (location != null) data['location'] = location;
    if (dateAndTime != null) data['dateAndTime'] = dateAndTime;
    if (description != null) data['description'] = description;
    if (photo != null) data['photo'] = photo;
    if (status != null) data['status'] = status;
    if (createdAt != null) data['createdAt'] = createdAt;
    return data;
  }

  @override
  String toString() {
    return 'EventModel{id: $id, user: $user, title: $title, location: $location, dateAndTime: $dateAndTime, description: $description, photo: $photo, status: $status, createdAt: $createdAt}';
  }
}
