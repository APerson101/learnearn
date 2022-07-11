import 'dart:convert';

class BountiesModel {
  String title;
  String body;
  int views;
  int comments;
  String subject;
  int reward;
  DateTime? startTime;
  DateTime? endTime;
  String? id;
  bool open;
  BountiesModel({
    required this.title,
    required this.body,
    required this.views,
    required this.comments,
    required this.subject,
    required this.reward,
    this.startTime,
    this.endTime,
    this.id,
    required this.open,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'views': views,
      'comments': comments,
      'subject': subject,
      'reward': reward,
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'id': id,
      'open': open,
    };
  }

  factory BountiesModel.fromMap(Map<String, dynamic> map) {
    return BountiesModel(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      views: map['views']?.toInt() ?? 0,
      comments: map['comments']?.toInt() ?? 0,
      subject: map['subject'] ?? '',
      reward: map['reward']?.toInt() ?? 0,
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      id: map['id'],
      open: map['open'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory BountiesModel.fromJson(String source) =>
      BountiesModel.fromMap(json.decode(source));
}
