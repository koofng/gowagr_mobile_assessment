import 'package:gowagr_mobile_assessment/core/models/response_data.dart';
import 'package:gowagr_mobile_assessment/core/services/network/api_response.dart';
import 'package:gowagr_mobile_assessment/features/explore/data/data_sources/explore_events_data_source_abstract.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/events_response_model.dart';

import '../../../../core/dependency_injection/dependency_injector.dart';
import '../../../../core/services/network/network_service_abstract.dart';

class ExploreEventsDataSourceImpl implements ExploreEventsDataSource {
  final _networkService = di.get<NetworkServiceAbstract>();
  @override
  Future<ResponseData<EventsResponseModel>> fetchAllEvents({Map<String, dynamic>? query}) async {
    ResponseData<EventsResponseModel> responseData;
    try {
      final ApiResponse response = await _networkService.get('events/public-events', queryParams: query);
      if (response.error != null) {
        responseData = ResponseData<EventsResponseModel>(success: false, message: response.error?['error'] as String?);
      } else {
        responseData = ResponseData<EventsResponseModel>(success: true, data: EventsResponseModel.fromJson(response.data));
      }
    } catch (e) {
      responseData = ResponseData<EventsResponseModel>(success: false, message: 'An Error Occurred');
    }
    return responseData;
  }
}
