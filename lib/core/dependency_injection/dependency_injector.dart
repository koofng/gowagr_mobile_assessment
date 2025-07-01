import 'package:get_it/get_it.dart';
import 'package:gowagr_mobile_assessment/core/services/caching/cache_registry.dart';
import 'package:gowagr_mobile_assessment/core/services/caching/cache_service_abstract.dart';
import 'package:gowagr_mobile_assessment/core/services/caching/cache_service_impl.dart';
import 'package:gowagr_mobile_assessment/core/services/network/network_service_abstract.dart';
import 'package:gowagr_mobile_assessment/core/services/network/network_service_impl.dart';
import 'package:gowagr_mobile_assessment/features/explore/data/data_sources/explore_events_data_source_abstract.dart';
import 'package:gowagr_mobile_assessment/features/explore/data/data_sources/explore_events_data_source_impl.dart';
import 'package:gowagr_mobile_assessment/features/explore/data/local/explore_local_repository.dart';
import 'package:gowagr_mobile_assessment/features/explore/data/repository/explore_repository.dart';
import 'package:gowagr_mobile_assessment/features/explore/data/repository/explore_repository_impl.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/event_model.dart';

final di = GetIt.instance;

void setupDependencies() {
  setupCacheRegistry();

  // register base network class
  di.registerLazySingleton<NetworkServiceAbstract>(() => NetworkServiceImpl());

  // register cache service
  CacheRegistry.register<Event>(tableName: 'event_cache', fromJson: (json) => Event.fromJson(json), toJson: (event) => event.toJson());
  di.registerLazySingleton<CacheService<Event>>(() => CacheServiceImpl<Event>());

  // register all data sources
  di.registerLazySingleton<ExploreEventsDataSource>(() => ExploreEventsDataSourceImpl());

  // register all repository
  di.registerLazySingleton<ExploreRepository>(() => ExploreRepositoryImpl());
  di.registerLazySingleton<ExploreLocalRepository>(() => ExploreLocalRepository());
}

void setupCacheRegistry() {
  CacheRegistry.register<Event>(tableName: 'events_cache', fromJson: (map) => Event.fromJson(map), toJson: (event) => event.toJson());
}
