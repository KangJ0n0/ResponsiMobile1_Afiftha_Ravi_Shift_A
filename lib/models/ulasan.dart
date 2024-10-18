class Ulasan {
  int? id;
  String? reviewer;
  int? rating;
  String? comments;

  Ulasan({this.id, this.reviewer, this.rating, this.comments});

  factory Ulasan.fromJson(Map<String, dynamic> json) {
    return Ulasan(
      id: json['id'],
      reviewer: json['reviewer'],
      rating: json['rating'],
      comments: json['comments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reviewer': reviewer,
      'rating': rating,
      'comments': comments,
    };
  }
}
