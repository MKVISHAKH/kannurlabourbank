import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/model/Eventmodel/event.dart';
import 'package:panipura/model/todolist/addtodolistresp/addtodoresp.dart';
import 'package:panipura/model/todolist/deletetodoreq/deletetodoreq.dart';
import 'package:panipura/widgets/calenderwidget/eventeditingpage.dart';
import 'package:panipura/widgets/calenderwidget/utils.dart';
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
              builddeletetodo(deletereq);
              provider.deleteEvent(event);
              Navigator.of(scaffoldKeys.currentContext!).pop();
            })
      ];

  Future builddeletetodo(Deletetodoreq deleteval) async {
    final addtodoresp = await Labourdata().deletetodolist(deleteval);
    if (addtodoresp == null) {
      Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (addtodoresp.statusCode == 200) {
      final resultAsjson = jsonDecode(addtodoresp.data);
      final registerval =
          Addtodoresp.fromJson(resultAsjson as Map<String, dynamic>);
      final status = registerval.success;
      if (status == true) {
        final message = registerval.message;
        Fluttertoast.showToast(
            msg: "$message",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        final message = registerval.message;
        Fluttertoast.showToast(
            msg: "$message",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Server not reached",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
