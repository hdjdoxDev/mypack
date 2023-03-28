import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:flutter/material.dart';
import 'package:mypack/utils/time.dart';

import 'layout.dart';

class DateAndTimeField extends StatelessWidget {
  const DateAndTimeField(
      {Key? key,
      required this.dateController,
      required this.timeController,
      this.initialDateTime,
      required this.onChangeDate,
      required this.onChangeTime,
      required this.allowNoDate,
      required this.onEmptyDate})
      : super(key: key);
  final TextEditingController dateController;
  final TextEditingController timeController;
  final DateTime? initialDateTime;
  final void Function(DateTime?) onChangeDate;
  final void Function(DateTime?) onChangeTime;
  final void Function() onEmptyDate;
  final bool allowNoDate;
  @override
  Widget build(BuildContext context) {
    return SeparatedRow(
      children: [
        Expanded(
          flex: 3,
          child: DateTimeField(
            resetIcon: null,
            controller: dateController,
            textInputAction: TextInputAction.next,
            format: dateFormat,
            onShowPicker: (context, dt) => showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: dt ?? initialDateTime ?? now,
                lastDate: DateTime(2200)),
            onChanged: onChangeDate,
          ),
        ),
        Expanded(
          flex: 2,
          child: DateTimeField(
            resetIcon: null,
            controller: timeController,
            textInputAction: TextInputAction.next,
            format: timeFormat,
            onShowPicker: (BuildContext context, DateTime? dt) =>
                showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(dt ?? initialDateTime ?? now),
            ).then((value) =>
                    DateTimeField.combine(dt ?? initialDateTime ?? now, value)),
            onChanged: onChangeTime,
          ),
        ),
        if (allowNoDate)
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: onEmptyDate,
            ),
          ),
      ],
    );
  }
}
