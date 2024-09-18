import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/model/todolist/addtodolist/addtodolistreq.dart';
import 'package:panipura/model/todolist/addtodolistresp/addtodoresp.dart';
import 'package:panipura/provider/locale_provider.dart';
import '../../model/Eventmodel/event.dart';
import 'utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';
class EventEditingPage extends StatefulWidget {
  final Event? event;
  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;
  final _formkey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final discriptonController = TextEditingController();
  String? discrip;
  bool? status;
  String? message;
  int? todoId;

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      final event = widget.event!;
      titleController.text = event.title ?? ' ';
      fromDate = event.from;
      toDate = event.to;
      discriptonController.text = event.description ?? ' ';
      todoId = event.todolistId;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    discriptonController.dispose();
    super.dispose();
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Stack(
    key: _scaffoldKey,
        children: [
          const Screensbackground(),
          Scaffold(
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
                actions: buildEditngActions(),
                // centerTitle: true,
                //title:const Text("To do List",style: klogheaderText,),
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildTitle(),
                      const SizedBox(height: 12),
                      buildDateTimePickers(),
                      const SizedBox(height: 12),
                      buildDiscription(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  List<Widget> buildEditngActions() => [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: TextButton.icon(
              onPressed: saveForm,
              icon: const Icon(
                Icons.done,
                color: Color.fromARGB(255, 158, 89, 248),
              ),
              label: const Text(
                'SAVE',
                style: TextStyle(
                    color: Color.fromARGB(255, 158, 89, 248), fontSize: 18),
              )),
        ),
      ];

  Widget buildTitle() {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return TextFormField(
      style: L10n.getappbarSize(locale.languageCode),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: AppLocalizations.of(context)!.addtitle,
      ),
      onFieldSubmitted: (_) => saveForm(),
      validator: (title) =>
          title != null && title.isEmpty ? 'Title Cannot be empty' : null,
      controller: titleController,
    );
  }

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() => buildHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'TO',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeofDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeofDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeofDay.hour, minutes: timeofDay.minute);
      return date.add(time);
    }
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );

  Widget buildDiscription() {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return TextFormField(
      style: L10n.getappbarSize(locale.languageCode),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        fillColor: Colors.white,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: Appcolors.magenta,
            width: 1,
          ),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: Appcolors.magenta,
              width: 1,
            )),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: Appcolors.magenta,
            width: 1,
          ),
        ),

        hintText: AppLocalizations.of(context)!.discrip,
        //labelStyle: L10n.getappbarSize(locale.languageCode),
      ),
      onFieldSubmitted: (_) => saveForm(),
      // validator: (title)=>
      // title!=null && title.isEmpty ? 'Title Cannot be empty' : null,
      controller: discriptonController,
    );
  }

  Future saveForm() async {
    final isValid = _formkey.currentState!.validate();
    final discription = discriptonController.text;
    if (discription.isEmpty) {
      discrip = ' ';
    } else {
      discrip = discription;
    }

    if (isValid) {
      final event = Event(
        title: titleController.text,
        description: discrip,
        from: fromDate,
        to: toDate,
        isAllday: false,
      );

      final isEditing = widget.event != null;

      final provider = Provider.of<EventProvider>(context, listen: false);
      if (isEditing) {
        final frmdt = Utils.toDateTimedif(fromDate);
        log(frmdt);
        final List<String> frmval = frmdt.split(' ');
        final fromdate = frmval[0];
        final fromtime = frmval[1] + frmval[2];
        final todt = Utils.toDateTimedif(toDate);
        log(todt);
        final List<String> toval = todt.split(' ');
        final todate = toval[0];
        final totime = toval[1] + toval[2];

        final todoreq = Addtodolist.value(
            //todolistId: todoId,
            title: titleController.text,
            description: discrip,
            frmDt: fromdate,
            toDt: todate,
            frmTime: fromtime,
            toTime: totime);
        buildEdittodolist(todoreq, todoId);
        provider.editEvent(event, widget.event!);

        Navigator.of(context).pop();
      } else {
        final value = await Sharedata.instance.getdata();
        final usrId = value!.userid;
        final frmdt = Utils.toDateTimedif(fromDate);
        log(frmdt);
        final List<String> frmval = frmdt.split(' ');
        final fromdate = frmval[0];
        final fromtime = frmval[1] + frmval[2];
        final todt = Utils.toDateTimedif(toDate);
        log(todt);
        final List<String> toval = todt.split(' ');
        final todate = toval[0];
        final totime = toval[1] + toval[2];

        final todoreq = Addtodolist.value(
            userId: usrId,
            title: titleController.text,
            description: discrip,
            frmDt: fromdate,
            toDt: todate,
            frmTime: fromtime,
            toTime: totime);
        buildaddtodo(todoreq);

        provider.addEvent(event);
      }

      Navigator.of(_scaffoldKey.currentContext!).pop();
    }
  }

  Future buildaddtodo(Addtodolist addval) async {
    final addtodoresp = await Labourdata().addtodolist(addval);
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
      status = registerval.success;
      if (status == true) {
        message = registerval.message;
        Fluttertoast.showToast(
            msg: "$message",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        message = registerval.message;
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

  Future buildEdittodolist(Addtodolist editval, int? todoid) async {
    final addtodoresp = await Labourdata().edittodolist(editval, todoid);
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
