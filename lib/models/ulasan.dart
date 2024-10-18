class Ulasan {
  int? id; // Change to int
  String? reviewer;
  int? rating; // Keep as int since rating is Integer
  String? comments;

  Ulasan({this.id, this.reviewer, this.rating, this.comments});

  factory Ulasan.fromJson(Map<String, dynamic> json) {
    return Ulasan(
      id: json['id'], // No change needed here
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
