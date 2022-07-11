import 'dart:convert';

class CommentModel {
  String comment;
  String userAddress;
  int votes;
  CommentModel({
    required this.comment,
    required this.userAddress,
    required this.votes,
  });

  CommentModel copyWith({
    String? comment,
    String? userAddress,
    int? votes,
  }) {
    return CommentModel(
      comment: comment ?? this.comment,
      userAddress: userAddress ?? this.userAddress,
      votes: votes ?? this.votes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'userAddress': userAddress,
      'votes': votes,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: map['comment'] ?? '',
      userAddress: map['userAddress'] ?? '',
      votes: map['votes']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CommentModel(comment: $comment, userAddress: $userAddress, votes: $votes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.comment == comment &&
        other.userAddress == userAddress &&
        other.votes == votes;
  }

  @override
  int get hashCode => comment.hashCode ^ userAddress.hashCode ^ votes.hashCode;
}
