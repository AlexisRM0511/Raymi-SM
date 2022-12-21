class SueModel {
  String? id;
  String? user;
  String? title;
  String? location;
  String? dateAndTime;
  String? description;
  String? photo;
  int? status;
  bool? isKnown;
  DateTime? createdAt;

  SueModel(
      {this.id,
      this.user,
      this.title,
      this.location,
      this.dateAndTime,
      this.description,
      this.photo,
      this.status,
      this.isKnown,
      this.createdAt});

  SueModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    user = json['user'] as String;
    title = json['title'] as String;
    location = json['location'] as String;
    dateAndTime = json['dateAndTime'] as String;
    description = json['description'] as String;
    photo = json['photo'] as String;
    status = json['status'] as int;
    isKnown = json['isKnown'] as bool;
    createdAt = DateTime.parse(json['createdAt'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['_id'] = id;
    if (user != null) data['user'] = user;
    if (title != null) data['title'] = title;
    if (location != null) data['location'] = location;
    if (dateAndTime != null) data['dateAndTime'] = dateAndTime;
    if (description != null) data['description'] = description;
    if (photo != null) data['photo'] = photo;
    if (status != null) data['status'] = status.toString();
    if (isKnown != null) data['isKnown'] = isKnown.toString();
    return data;
  }

  @override
  String toString() {
    return 'SueModel{id: $id, user: $user, title: $title, location: $location, dateAndTime: $dateAndTime, description: $description, photo: $photo, status: $status}';
  }
}
