import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/hooks/hook.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title ?? ' ';

  @override
  Color getColor(int index) => getEvent(index).backgroundColor;

//  @override
//  bool isAllday(int index)=>getEvent(index).isAllday;

  bool isAllday(int index) => getEvent(index).isAllday;
}
