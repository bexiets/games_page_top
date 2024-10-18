// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GamesImpl _$$GamesImplFromJson(Map<String, dynamic> json) => _$GamesImpl(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GamesImplToJson(_$GamesImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

_$ResultsImpl _$$ResultsImplFromJson(Map<String, dynamic> json) =>
    _$ResultsImpl(
      id: (json['id'] as num?)?.toInt(),
      contribution: json['contribution'] as String?,
      maxPlayer: (json['max_player'] as num?)?.toInt(),
      image: json['image'] as String?,
      title: json['title'] as String?,
      startDate: json['start_date'] as String?,
      duration: Duration.fromJson(json['duration'] as Map<String, dynamic>),
      existingPlayerCount: (json['existing_player_count'] as num?)?.toInt(),
      organizer: Organizer.fromJson(json['organizer'] as Map<String, dynamic>),
      distanceFromUser: (json['distance_from_user'] ?? 0.0) as double,
    );

Map<String, dynamic> _$$ResultsImplToJson(_$ResultsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contribution': instance.contribution,
      'maxPlayer': instance.maxPlayer,
      'image': instance.image,
      'title': instance.title,
      'startDate': instance.startDate,
      'duration': instance.duration,
      'existingPlayerCount': instance.existingPlayerCount,
      'organizer': instance.organizer,
      'distanceFromUser': instance.distanceFromUser,
    };

_$DurationImpl _$$DurationImplFromJson(Map<String, dynamic> json) =>
    _$DurationImpl(
      hours: (json['hours'] as num).toDouble(),
      minutes: (json['minutes'] as num).toDouble(),
    );

Map<String, dynamic> _$$DurationImplToJson(_$DurationImpl instance) =>
    <String, dynamic>{
      'hours': instance.hours,
      'minutes': instance.minutes,
    };

_$OrganizerImpl _$$OrganizerImplFromJson(Map<String, dynamic> json) =>
    _$OrganizerImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      photo: json['photo'] as String?,
      username: json['username'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$$OrganizerImplToJson(_$OrganizerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'photo': instance.photo,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
    };
