import 'package:flutter/material.dart';

import '../../../../helpers/paginated_list_view.dart';
import '../../domain/models/explore_model.dart';
import 'event_card_widget.dart';

class EventsListWidget extends StatefulWidget {
  const EventsListWidget({super.key, required this.model, required this.scrollController, required this.onFetchMore});

  final ExploreModel model;
  final ScrollController scrollController;

  final Future<void> Function() onFetchMore;

  @override
  State<EventsListWidget> createState() => _EventsListWidgetState();
}

class _EventsListWidgetState extends State<EventsListWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: [
        PinnedHeaderSliver(child: Placeholder()),
        PaginatedSliverListView(
          items: widget.model.events,
          hasMore: widget.model.hasMore,
          itemBuilder: (context, item, index) {
            return EventCardWidget(event: widget.model.events[index]);
          },
          isLoading: widget.model.loadingMoreData,
          scrollController: widget.scrollController,
          onFetchMore: () => widget.onFetchMore(),
        ),
      ],
    );
  }
}
