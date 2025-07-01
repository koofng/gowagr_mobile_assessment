import 'package:flutter/widgets.dart';
import 'package:gowagr_mobile_assessment/core/base/base_model.dart';

abstract class BaseViewModel<T extends BaseModel> extends ChangeNotifier {
  BaseViewModel(this.model);

  @protected
  T model;
  /*
  * Shared viewModel Functionality
  * */
  void setState() {
    notifyListeners();
  }

  T getModel();
  void setModel(T model) {
    final T old = this.model.shallowCopy() as T;
    this.model = model;
    modelUpdated(old);
  }

  void modelUpdated(T old) {}
}
