import 'package:freezed_annotation/freezed_annotation.dart';

part 'games.freezed.dart';
part 'games.g.dart';

@freezed
class Games with _$Games {
  const factory Games({
    required int? count,
    required String? next,
    required String? previous,
    required List<Results> results,
  }) = _Games;

  factory Games.fromJson(Map<String, dynamic> json) => _$GamesFromJson(json);
}


@freezed
class Results with _$Results {
  const factory Results({
    required int? id,
    required String? contribution,
    required int? maxPlayer,
    required String? image,
    required String? title,
    required String? startDate,
    required Duration duration,
    required int? existingPlayerCount,
    required Organizer organizer,
    required double? distanceFromUser,
  }) = _Results;

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);
}

@freezed
class Duration with _$Duration {
  const factory Duration({
    required double hours,
    required double minutes,
  }) = _Duration;

  factory Duration.fromJson(Map<String, dynamic> json) => _$DurationFromJson(json);
}

@freezed
class Organizer with _$Organizer {
  const factory Organizer({
    required int? id,
    required String? name,
    required String? surname,
    required String? photo,
    required String? username,
    required String? phoneNumber,
  }) = _Organizer;

  factory Organizer.fromJson(Map<String, dynamic> json) => _$OrganizerFromJson(json);
}