import '../enums/editmode.dart';
import 'viewmodel.dart';

abstract class EditModelArgs<T> extends IModelArgs {
  final int? id;
  final T? fields;
  final EditMode em;
  EditModelArgs({
    this.id,
    this.fields,
    required this.em,
  });
}

abstract class EditModel<T extends EditModelArgs> extends IModel<T> {}
