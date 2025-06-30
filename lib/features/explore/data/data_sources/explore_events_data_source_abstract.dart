import 'package:gowagr_mobile_assessment/core/models/response_data.dart';

import '../../domain/models/events_response_model.dart';

abstract class ExploreEventsDataSource {
  Future<ResponseData<EventsResponseModel>> fetchAllEvents({Map<String, dynamic>? query});
}
