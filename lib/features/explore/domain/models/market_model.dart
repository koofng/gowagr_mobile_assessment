import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_model.freezed.dart';
part 'market_model.g.dart';

@freezed
abstract class Market with _$Market {
  const factory Market({
    required String id,
    required String title,
    required String rules,
    required String imageUrl,
    required String image128Url,
    @Default(0.0) double? yesBuyPrice,
    @Default(0.0) double? noBuyPrice,
    @Default(0.0) double? yesPriceForEstimate,
    @Default(0.0) double? noPriceForEstimate,
    @Default('') String? status,
    @Default(null) String? resolvedOutcome,
    @Default(0.0) double? volumeValueYes,
    @Default(0.0) double? volumeValueNo,
    @Default(0.0) double? yesProfitForEstimate,
    @Default(0.0) double? noProfitForEstimate,
  }) = _Market;

  factory Market.fromJson(Map<String, dynamic> json) => _$MarketFromJson(json);
}
