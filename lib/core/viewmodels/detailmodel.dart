import 'viewmodel.dart';

abstract class DetailModelArgs<T> extends IModelArgs {
  final T? entry;
  DetailModelArgs({
    required this.entry,
  });
}

abstract class DetailModel<T extends DetailModelArgs> extends IModel<T> {}
