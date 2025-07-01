import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gowagr_mobile_assessment/core/dependency_injection/dependency_injector.dart';
import 'package:provider/provider.dart';

import 'package:gowagr_mobile_assessment/core/base/base_model.dart';

import 'base_view_model.dart';

class BaseView<T extends BaseViewModel<BaseModel>> extends StatefulWidget {
  const BaseView({super.key, required this.builder, this.onModelReady, this.onDispose, this.onModelUpdate, this.onModelDidChange, this.onPostBuild, this.model});

  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T)? onModelReady;
  final Function(T)? onDispose;
  final Function(T)? onModelUpdate;
  final Function(T, AppLifecycleState state)? onModelDidChange;
  final Function(T)? onPostBuild;
  final T? model;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late T model;

  @override
  void didUpdateWidget(BaseView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onModelUpdate != null) {
      widget.onModelReady!(model);
    }
  }

  @override
  void initState() {
    model = widget.model ?? di.get<T>();
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!(model);
    }
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (widget.onModelDidChange != null) {
      widget.onModelDidChange!(model, state);
    }
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.value(
    value: model,
    child: Consumer<T>(builder: (BuildContext context, T value, Widget? child) => widget.builder(context, value, child ?? Container())),
  );
}
