import 'package:gowagr_mobile_assessment/core/models/response_data.dart';
import 'package:gowagr_mobile_assessment/features/explore/data/repository/explore_repository.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/events_response_model.dart';

import '../../../../core/dependency_injection/dependency_injector.dart';
import '../data_sources/explore_events_data_source_abstract.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  @override
  Future<ResponseData<EventsResponseModel>> getEvents({Map<String, dynamic>? query}) {
    return di.get<ExploreEventsDataSource>().fetchAllEvents(query: query);
  }
}
