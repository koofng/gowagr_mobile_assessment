import 'dart:convert';
import 'dart:developer';

import 'package:gowagr_mobile_assessment/core/services/caching/cache_service_abstract.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/event_model.dart';

import '../../../../core/dependency_injection/dependency_injector.dart';

class ExploreLocalRepository {
  final cache = di<CacheService<Event>>();
  void cacheEvents(List<Event> events) async {
    // for (var event in events) {
    cache.insertItems('event', events);
    // }
  }

  Future<void> readCacheEvents() async {
    final res = await cache.getAllItems('event', (mp) {
      final parsedMap = mp.map((key, value) {
        return MapEntry('f', value);
      });

      print(parsedMap);
      log(parsedMap.toString());

      return Event.fromJson(parsedMap);
    });

    final _rev = (res as List).map((e) => Event.fromJson(e)).toList();

    print(_rev);

    // (event) {
    //   final _ev = event.map((k, v) => Event.fromJson());
    //   // final _ev = event.map((key, value) {
    //   //   log(value.toString());
    //   // });

    //   (map['events'] as List)
    // .map((e) => fromJson(Map<String, dynamic>.from(e)))
    // .toList();
    //   log(event.toString());
    //   return Event.fromJson(event);
    //   // return;
    // });

    log(res.toString());
    // return res;
  }
}
