import 'package:panipura/core/hooks/hook.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/src/theme/calendar_theme.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;
    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          'No Events Found',
          style: TextStyle(color: Appcolors.black, fontSize: 24),
        ),
      );
    }
    return SfCalendarTheme(
        data: SfCalendarThemeData(
          timeTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        child: SfCalendar(
          view: CalendarView.timelineDay,
          dataSource: EventDataSource(provider.events),
          initialDisplayDate: provider.selectedDate,
          appointmentBuilder: appointmentBuilder,
          headerHeight: 0,
          todayHighlightColor: Appcolors.black,
          selectionDecoration: const BoxDecoration(color: Colors.transparent),
          onTap: (details) {
            if (details.appointments == null) return;
            final event = details.appointments!.first;

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventViewingPage(event: event),
            ));
          },
        ));
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(event.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Appcolors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
