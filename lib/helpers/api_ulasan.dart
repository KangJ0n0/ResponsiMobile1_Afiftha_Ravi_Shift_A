import 'package:equatable/equatable.dart';

abstract class UlasanEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUlasanEvent extends UlasanEvent {}

class CreateUlasanEvent extends UlasanEvent {
  final String reviewer;
  final int rating;
  final String comments;

  CreateUlasanEvent({required this.reviewer, required this.rating, required this.comments});

  @override
  List<Object> get props => [reviewer, rating, comments];
}

class UpdateUlasanEvent extends UlasanEvent {
  final int id;
  final String reviewer;
  final int rating;
  final String comments;

  UpdateUlasanEvent({required this.id, required this.reviewer, required this.rating, required this.comments});

  @override
  List<Object> get props => [id, reviewer, rating, comments];
}

class DeleteUlasanEvent extends UlasanEvent {
  final int id;

  DeleteUlasanEvent({required this.id});

  @override
  List<Object> get props => [id];
}
