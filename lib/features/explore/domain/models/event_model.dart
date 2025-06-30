import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/market_model.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
abstract class Event with _$Event {
  const factory Event({
    required String createdAt,
    required List<Market> markets,
    required String imageUrl,
    required String image128Url,
    required String id,
    required String title,
    required String type,
    required String description,
    required String category,
    @Default(['']) List<String>? hashtags,
    @Default(['']) List<String>? countryCodes,
    @Default(['']) List<String>? regions,
    @Default('') String? status,
    @Default(null) String? resolvedAt,
    @Default('') String? resolutionDate,
    @Default('') String? resolutionSource,
    @Default(0.0) double? totalVolume,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
