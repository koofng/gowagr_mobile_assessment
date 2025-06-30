import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/event_model.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/pagination_model.dart';

part 'events_response_model.freezed.dart';
part 'events_response_model.g.dart';

@freezed
abstract class EventsResponseModel with _$EventsResponseModel {
  const factory EventsResponseModel({required List<Event> events, required Pagination pagination}) = _EventsResponseModel;

  factory EventsResponseModel.fromJson(Map<String, dynamic> json) => _$EventsResponseModelFromJson(json);
}
