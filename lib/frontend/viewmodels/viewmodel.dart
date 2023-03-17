import 'package:flutter/material.dart';

import '../enums/viewstate.dart';

abstract class IModelArgs {
  IModelArgs();
}

class NoModelArgs implements IModelArgs {
  const NoModelArgs();
}

class IModel<T extends IModelArgs> extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  int cont = 0;
  ViewState get state => _state;

  void init({required T args}) {}

  void setState(ViewState viewState) {
    if (viewState == ViewState.busy) {
      cont++;
    } else {
      cont--;
    }
    if (cont > 0) {
      _state = ViewState.busy;
    } else {
      _state = ViewState.idle;
    }
    notifyListeners();
  }
}
