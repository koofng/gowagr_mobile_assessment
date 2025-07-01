import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gowagr_mobile_assessment/core/base/base_model.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/event_model.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/pagination_model.dart';

part 'explore_model.freezed.dart';

@freezed
abstract class ExploreModel with _$ExploreModel implements BaseModel {
  factory ExploreModel({
    @Default(<Event>[]) List<Event> events,
    @Default(false) bool hasError,
    @Default(false) bool loadingData,
    @Default(false) bool loadingMoreData,
    @Default(false) bool hasMore,
    Pagination? pagination,
  }) = _ExploreModel;
  const ExploreModel._();

  @override
  BaseModel shallowCopy() => copyWith();
}
