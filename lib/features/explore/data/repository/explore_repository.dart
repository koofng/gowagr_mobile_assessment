import 'package:gowagr_mobile_assessment/features/explore/domain/models/events_response_model.dart';

import '../../../../core/models/response_data.dart';

abstract class ExploreRepository {
  Future<ResponseData<EventsResponseModel>> getEvents({Map<String, dynamic>? query});
}
