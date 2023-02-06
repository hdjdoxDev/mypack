import 'package:flutter/widgets.dart';
import '../enums/viewstate.dart';

abstract class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  int cont = 0;
  ViewState get state => _state;

  void loadModel();

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
