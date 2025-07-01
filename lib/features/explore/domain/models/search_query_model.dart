import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_query_model.freezed.dart';
part 'search_query_model.g.dart';

@freezed
abstract class SearchQueryModel with _$SearchQueryModel {
  const factory SearchQueryModel({@Default('') String? keyword, @Default(true) bool? trending, @Default('') String? category, @Default(5) int? size, @Default(1) int? page}) = _SearchQueryModel;

  factory SearchQueryModel.fromJson(Map<String, dynamic> json) => _$SearchQueryModelFromJson(json);
}
