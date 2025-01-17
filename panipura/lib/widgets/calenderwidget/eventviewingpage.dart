import 'package:panipura/core/hooks/hook.dart';

final scaffoldKeys = GlobalKey<ScaffoldState>();

class EventViewingPage extends StatelessWidget {
  final Event event;
  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(children: [
        const Screensbackground(),
        Scaffold(
            key: scaffoldKeys,
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                leading: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  child: CloseButton(),
                ),
                iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 158, 89, 248),
                ),
                actions: buildViewingActions(context, event),
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(32),
                children: [
                  buildDateTime(event),
                  const SizedBox(height: 32),
                  Text(
                    event.title ?? ' ',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    event.description ?? ' ',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            )),
      ]);

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllday ? 'All-day' : 'From', event.from),
        if (!event.isAllday) buildDate('To', event.to),
      ],
    );
  }

  Widget buildDate(String title, DateTime date) {
    const styleTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    const styleDate = TextStyle(fontSize: 18);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: styleTitle,
            ),
          ),
          Text(
            Utils.toDateTime(date),
            style: styleDate,
          )
        ],
      ),
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) => [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => EventEditingPage(event: event),
            ),
          ),
        ),
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final provider =
                  Provider.of<EventProvider>(context, listen: false);
              final value = await Sharedata.instance.getdata();
              final usrId = value!.userid;
              final todoid = event.todolistId;
              final deletereq =
                  Deletetodoreq(userId: usrId, todolistId: todoid);
        if (!context.mounted) return ;
              builddeletetodo(deletereq,context);
              provider.deleteEvent(event);
              Navigator.of(scaffoldKeys.currentContext!).pop();
            })
      ];

  Future builddeletetodo(Deletetodoreq deleteval,BuildContext context) async {
    final addtodoresp = await Labourdata().deletetodolist(deleteval);
    if (addtodoresp == null) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Something went wrong");
      }  else if (addtodoresp.statusCode == 200) {
      final resultAsjson = jsonDecode(addtodoresp.data);
      final registerval =
          Addtodoresp.fromJson(resultAsjson as Map<String, dynamic>);
      final status = registerval.success;
      if (status == true) {
        final message = registerval.message;

            if (!context.mounted) return;
        CommonFun.instance.showApierror(context,message);
      } else {
        final message = registerval.message;

            if (!context.mounted) return;
        CommonFun.instance.showApierror(context,message);
      }
    } else if (addtodoresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (addtodoresp.statusCode == 408) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
  }
}
