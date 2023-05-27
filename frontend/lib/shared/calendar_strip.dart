import 'package:flutter/material.dart';

class CalendarStrip extends StatefulWidget {
  final void Function(DateTime) onDateSelected;
  final void Function(DateTime)? onWeekSelected;
  final DateTime? firstSelectedDate;
  final Widget Function({
    required DateTime date,
    int rowIndex,
    String dayName,
    bool isSelected,
    bool isOutOfRange,
    bool isMarked,
  })? dateTileBuilder;
  final BoxDecoration? containerDecoration;
  final double? containerHeight;
  final Widget Function(String)? monthNameWidget;
  final Color iconColor;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<DateTime>? markedDates;
  final bool addSwipeGesture;
  final bool? weekStartsOnSunday;
  final Icon? rightIcon;
  final Icon? leftIcon;

  const CalendarStrip({
    required this.onDateSelected,
    this.firstSelectedDate,
    this.onWeekSelected,
    this.startDate,
    this.endDate,
    this.dateTileBuilder,
    this.addSwipeGesture = false,
    this.weekStartsOnSunday = false,
    this.containerDecoration,
    this.containerHeight,
    this.monthNameWidget,
    this.iconColor = Colors.black,
    this.markedDates,
    this.rightIcon,
    this.leftIcon,
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarStrip> createState() => CalendarStripState();
}

class CalendarStripState extends State<CalendarStrip>
    with TickerProviderStateMixin {
  late DateTime selectedDate;

  // first day of showed week
  late DateTime rowStartingDate;

  List<String> monthLabels = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> dayLabels = ["Mon", "Tue", "Wed", "Thr", "Fri", "Sat", "Sun"];

  CalendarStripState();

  @override
  void initState() {
    super.initState();

    if (widget.firstSelectedDate == null ||
        checkOutOfRange(startOfDay(widget.firstSelectedDate!))) {
      if (widget.startDate != null) {
        selectedDate = startOfDay(widget.startDate!);
      } else if (widget.endDate != null) {
        selectedDate = startOfDay(widget.endDate!);
      } else {
        selectedDate = startOfDay(DateTime.now());
      }
    } else {
      selectedDate = startOfDay(widget.firstSelectedDate!);
    }

    int subtractDuration =
        widget.weekStartsOnSunday != null && widget.weekStartsOnSunday == true
            ? selectedDate.weekday
            : selectedDate.weekday - 1;

    rowStartingDate = selectedDate.subtract(Duration(days: subtractDuration));
  }

  String getMonthName(DateTime date) {
    return monthLabels[date.month - 1];
  }

  Widget monthLabelWidget() {
    DateTime firstDay = rowStartingDate,
        lastDay = rowStartingDate.add(const Duration(days: 6));
    String label;
    if (firstDay.month == lastDay.month) {
      label = "${getMonthName(firstDay)} ${firstDay.year}";
    } else {
      String firstDayYear =
          "${firstDay.year == lastDay.year ? "" : firstDay.year}";
      label =
          "${getMonthName(firstDay)} $firstDayYear / ${getMonthName(lastDay)} ${lastDay.year}";
    }
    return widget.monthNameWidget != null
        ? widget.monthNameWidget!(label)
        : Container(
            padding: const EdgeInsets.only(top: 7, bottom: 3),
            child: Text(label,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)));
  }

  bool isDateBefore(DateTime date1, DateTime date2) {
    return startOfDay(date1).isBefore(startOfDay(date2));
  }

  bool isDateAfter(DateTime date1, DateTime date2) {
    return startOfDay(date1).isAfter(startOfDay(date2));
  }

  DateTime startOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  bool isDateMarked(DateTime date) {
    date = startOfDay(date);
    return widget.markedDates == null
        ? false
        : widget.markedDates!.contains(date);
  }

  void changeRow(int weekDelta) {
    setState(() {
      rowStartingDate = rowStartingDate.add(Duration(days: 7 * weekDelta));
      onDateTap(rowStartingDate.add(Duration(days: weekDelta > 0 ? 0 : 6)));
      if (widget.onWeekSelected != null) {
        widget.onWeekSelected!(rowStartingDate);
      }
    });
  }

  bool get isOnEndingWeek => widget.endDate == null
      ? false
      : rowStartingDate
          .add(const Duration(days: 7))
          .isAfter(startOfDay(widget.endDate!));

  bool get isOnStartingWeek => widget.startDate == null
      ? false
      : rowStartingDate
          .subtract(const Duration(days: 1))
          .isBefore(startOfDay(widget.startDate!));

  Widget rightIconWidget() {
    if (!isOnEndingWeek) {
      return InkWell(
        onTap: () => changeRow(1),
        splashColor: Colors.black26,
        child: widget.rightIcon ??
            Icon(
              Icons.chevron_right,
              size: 30,
              color: widget.iconColor,
            ),
      );
    } else {
      return Container(width: 20);
    }
  }

  Widget leftIconWidget() {
    if (!isOnStartingWeek) {
      return InkWell(
        onTap: () => changeRow(-1),
        splashColor: Colors.black26,
        child: widget.leftIcon ??
            Icon(
              Icons.chevron_left,
              size: 30,
              color: widget.iconColor,
            ),
      );
    } else {
      return Container(width: 20);
    }
  }

  bool checkOutOfRange(DateTime date) {
    date = startOfDay(date);
    if (widget.startDate != null &&
        isDateBefore(date, startOfDay(widget.startDate!))) {
      return true;
    }
    if (widget.endDate != null &&
        isDateAfter(date, startOfDay(widget.endDate!))) {
      return true;
    }
    return false;
  }

  void onStripDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0) return;

    if (details.primaryVelocity! < 0) {
      if (!isOnEndingWeek) {
        changeRow(1);
      }
    } else {
      if (!isOnStartingWeek) {
        changeRow(-1);
      }
    }
  }

  void onDateTap(DateTime date) {
    if (!checkOutOfRange(date)) {
      setState(() {
        selectedDate = date;
        widget.onDateSelected(date);
      });
    }
  }

  Widget buildDateRow() {
    List<Widget> currentWeekRow = [];

    for (var eachDay = 0; eachDay < 7; eachDay++) {
      var date = rowStartingDate.add(Duration(days: eachDay));
      currentWeekRow.add(dateTileBuilder(
          date: date,
          isSelected: selectedDate.compareTo(date) == 0,
          rowIndex: eachDay));
    }

    return Column(children: [
      monthLabelWidget(),
      Padding(
          padding: const EdgeInsets.all(0),
          child: GestureDetector(
            onHorizontalDragEnd: widget.addSwipeGesture
                ? (DragEndDetails details) => onStripDrag(details)
                : (detalis) {},
            child: Row(children: [
              leftIconWidget(),
              Expanded(child: Row(children: currentWeekRow)),
              rightIconWidget()
            ]),
          ))
    ]);
  }

  Widget dateTileBuilder({
    required DateTime date,
    required bool isSelected,
    required int rowIndex,
  }) {
    bool isDateOutOfRange = checkOutOfRange(date);
    String dayName = dayLabels[date.weekday - 1];

    return Expanded(
      child: SlideFadeTransition(
        delay: 30 + (30 * rowIndex),
        id: "${date.day}${date.month}${date.year}",
        curve: Curves.ease,
        child: InkWell(
          onTap: () => onDateTap(date),
          child: (widget.dateTileBuilder != null)
              ? widget.dateTileBuilder!(
                  date: date,
                  isSelected: isSelected,
                  rowIndex: rowIndex,
                  dayName: dayName,
                  isMarked: isDateMarked(date),
                  isOutOfRange: isDateOutOfRange)
              : DefaultDateTile(
                  isSelected: isSelected,
                  isMarked: isDateMarked(date),
                  label: dayLabels[date.weekday - 1],
                  day: date.day),
        ),
      ),
    );
  }

  @override
  build(BuildContext context) {
    return Container(
      height: widget.containerHeight ?? 135.0,
      decoration: widget.containerDecoration ?? const BoxDecoration(),
      child: Column(children: [
        buildDateRow(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              const Spacer(),
              TextButton(
                  onPressed: () {
                    onDateTap(startOfDay(DateTime.now()));

                    int subtractDuration = widget.weekStartsOnSunday != null &&
                            widget.weekStartsOnSunday == true
                        ? selectedDate.weekday
                        : selectedDate.weekday - 1;

                    rowStartingDate =
                        selectedDate.subtract(Duration(days: subtractDuration));
                  },
                  // style: ButtonStyle(
                  //     textStyle: MaterialStateProperty.all(
                  //         (const TextStyle(color: Colors.white))),
                  //     backgroundColor: MaterialStateProperty.all(
                  //         Theme.of(context).primaryColor)),
                  child: const Text(
                    'Today',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        )
      ]),
    );
  }
}

class SlideFadeTransition extends StatefulWidget {
  final Widget child;
  final int delay;
  final String id;
  final Curve? curve;

  const SlideFadeTransition({
    required this.child,
    required this.id,
    this.delay = 2,
    this.curve,
    Key? key,
  }) : super(key: key);

  @override
  SlideFadeTransitionState createState() => SlideFadeTransitionState();
}

class SlideFadeTransitionState extends State<SlideFadeTransition>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    final curve = CurvedAnimation(
        curve: widget.curve != null ? widget.curve! : Curves.decelerate,
        parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero)
            .animate(curve);

    _animController.reset();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      _animController.forward();
    });
  }

  @override
  void didUpdateWidget(SlideFadeTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.id != oldWidget.id) {
      _animController.reset();
      Future.delayed(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animController,
      child: SlideTransition(position: _animOffset, child: widget.child),
    );
  }
}

class DefaultDateTile extends StatelessWidget {
  const DefaultDateTile({
    Key? key,
    required this.isSelected,
    required this.isMarked,
    required this.label,
    required this.day,
  }) : super(key: key);
  final bool isSelected;
  final bool isMarked;
  final String label;
  final int day;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color:
            !isSelected ? Colors.transparent : Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.5,
              color: !isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Text("$day",
              style: !isSelected
                  ? TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor)
                  : const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          Container(
            margin: const EdgeInsets.only(left: 1, right: 1),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: !isMarked
                    ? Colors.transparent
                    : isSelected
                        ? Colors.white
                        : Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
