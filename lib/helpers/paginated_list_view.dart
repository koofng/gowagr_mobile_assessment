import 'dart:async';
import 'package:flutter/material.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item, int index);

class PaginatedSliverListView<T> extends StatefulWidget {
  final List<T> items;
  final bool isLoading;
  final bool hasMore;
  final Future<void> Function() onFetchMore;
  final ItemBuilder<T> itemBuilder;
  final double scrollThreshold;
  final Duration debounceDuration;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final SliverGridDelegate? gridDelegate;
  final ScrollController scrollController;

  const PaginatedSliverListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.isLoading,
    required this.hasMore,
    required this.onFetchMore,
    required this.scrollController,
    this.scrollThreshold = 200,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.loadingWidget,
    this.errorWidget,
    this.errorMessage,
    this.onRetry,
    this.gridDelegate,
  });

  @override
  State<PaginatedSliverListView<T>> createState() => _PaginatedSliverListViewState<T>();
}

class _PaginatedSliverListViewState<T> extends State<PaginatedSliverListView<T>> {
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      final position = widget.scrollController.position;
      if (position.pixels >= position.maxScrollExtent - widget.scrollThreshold && !widget.isLoading && widget.hasMore) {
        if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
        _debounceTimer = Timer(widget.debounceDuration, widget.onFetchMore);
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    widget.scrollController.dispose();
    super.dispose();
  }

  Widget _buildErrorWidget() {
    return widget.errorWidget ??
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.errorMessage ?? 'Something went wrong'),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: widget.onRetry, child: const Text('Retry')),
              ],
            ),
          ),
        );
  }

  Widget _buildItem(int index, bool isStillLoading) {
    if (index < widget.items.length) {
      return widget.itemBuilder(context, widget.items[index], index);
    } else if (widget.errorMessage != null && widget.onRetry != null) {
      return _buildErrorWidget();
    } else {
      return isStillLoading
          ? widget.loadingWidget ??
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(child: CircularProgressIndicator()),
                )
          : const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(itemCount: widget.items.length + (widget.hasMore ? 1 : 0), itemBuilder: (context, index) => _buildItem(index, widget.isLoading));
  }
}
