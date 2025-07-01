import 'package:flutter/foundation.dart';
import 'package:gowagr_mobile_assessment/core/base/base_view_model.dart';
import 'package:gowagr_mobile_assessment/core/dependency_injection/dependency_injector.dart';
import 'package:gowagr_mobile_assessment/core/models/response_data.dart';
import 'package:gowagr_mobile_assessment/features/explore/data/local/explore_local_repository.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/explore_model.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/pagination_model.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/search_query_model.dart';

import '../../data/repository/explore_repository.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/events_response_model.dart';

class ExploreViewModel extends BaseViewModel<ExploreModel> {
  ExploreViewModel({ExploreModel? model}) : super(model ?? ExploreModel());

  ExploreModel get _model => model;

  @override
  ExploreModel getModel() => _model;

  Future<void> loadEvents({SearchQueryModel? query, bool hasMore = false}) async {
    if (!hasMore) {
      model = _model.copyWith(loadingData: true);
      setState();
    }

    if (hasMore) {
      model = _model.copyWith(loadingMoreData: true);
      setState();
    }

    final ResponseData<EventsResponseModel> res = await di.get<ExploreRepository>().getEvents(query: query?.toJson());
    model = _model.copyWith(loadingData: false, loadingMoreData: false);
    setState();

    if (res.success == false) {
      final cacheData = di.get<ExploreLocalRepository>().readCacheEvents();
    }

    final EventsResponseModel data = res.data ?? EventsResponseModel(events: [], pagination: Pagination(lastPage: 0, page: 0, size: 0, totalCount: 0));
    final List<Event> listOfEvents = data.events;

    model = _model.copyWith(pagination: data.pagination, hasError: !res.success);
    setState();

    if ((model.events.length < (model.pagination?.totalCount ?? 0) && model.pagination!.page < model.pagination!.lastPage)) {
      model = _model.copyWith(
        hasMore: true,
        loadingData: false,
        loadingMoreData: false,
        pagination: _model.pagination?.copyWith(page: model.pagination!.page + 1),
        events: [..._model.events, ...listOfEvents],
      );
    }

    di.get<ExploreLocalRepository>().cacheEvents(_model.events);

    if (kDebugMode) {
      print('>>>>>>>>>>>>>>>>>>>>>> ${model.events.length} <<<<<<<<<<<<<<<<<<');
    }
  }
}
