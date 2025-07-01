import 'package:flutter/material.dart';
import 'package:gowagr_mobile_assessment/core/base/base_view.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/explore_model.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/search_query_model.dart';
import 'package:gowagr_mobile_assessment/features/explore/presentation/view_models/explore_viewmodel.dart';

import '../widgets/event_list_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final ExploreViewModel _viewModel;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = ExploreViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ExploreViewModel>(
      model: _viewModel,
      onModelReady: (viewModel) => viewModel.loadEvents(query: SearchQueryModel(trending: false, page: 1, size: 5)),
      builder: (context, vm, child) {
        final ExploreModel model = vm.getModel();
        // for showing loading state
        if (model.loadingData) return Center(child: CircularProgressIndicator());
        // for showing error
        if (model.hasError) return Center(child: Text('Sorry, an error occurred'));
        // for showing an empty state
        if (model.events.isEmpty && !model.hasError) return Center(child: Text('Events are currently empty'));
        // for showing a success state
        return EventsListWidget(
          model: model,
          scrollController: _scrollController,
          onFetchMore: () => vm.loadEvents(
            hasMore: model.hasMore,
            query: SearchQueryModel(page: model.pagination?.page),
          ),
        );
      },
    );
  }
}
