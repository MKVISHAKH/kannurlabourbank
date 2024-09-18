import 'package:intl/intl.dart';
import 'package:panipura/core/hooks/hook.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:panipura/popup/edithmtwnpopup/edithmtwnpop.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/model/Eventmodel/event.dart';
import 'package:panipura/model/todolist/addtodolistresp/addtodoresp.dart';
import 'package:panipura/provider/locale_provider.dart';
import '../screens/screenlabour/screenlabTodolist.dart';
import '../screens/screenlabour/screenrating.dart';
class Gridlabview extends StatefulWidget {
  const Gridlabview({
    super.key,
  });

  @override
  State<Gridlabview> createState() => _GridlabviewState();
}

class _GridlabviewState extends State<Gridlabview> {
  int? districtId;
  int? usrID;
  String? token;
  String? name;
  bool? status;
  String? message;
  late EventProvider provider;
  Locale? localecode;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();
    });
    super.initState();
    getUsername();
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  void getUsername() async {
    final value = await Sharedata.instance.getdata();
    // final _sharedprefs = await SharedPreferences.getInstance();
    // bool CheckValue = _sharedprefs.containsKey('USERNAME');
    // print(CheckValue)
    token = value!.token;
    usrID = value.userid;
    name = value.name;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<EventProvider>(context, listen: false);
    return GridView(
      key: _scaffoldKey,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 200),
      children: [
        InkWell(
          splashColor: const Color.fromARGB(255, 158, 89, 248),
          highlightColor: const Color.fromARGB(255, 47, 3, 100),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ScreenLabProfile(usrId: usrID, token: token),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    "assets/background/22989318.jpg",
                    fit: BoxFit.contain,
                    width: 80,
                    height: 80,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.viewpro,
                  style: kbodyfont,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: const Color.fromARGB(255, 158, 89, 248),
          highlightColor: const Color.fromARGB(255, 47, 3, 100),
          onTap: () async {
            final value = await Sharedata.instance.getdata();
            // final districtIdval = await LabourDb.instance
            //     .getDistrictId(value!.district, localecode);

            // for (var map in districtIdval) {
            //   final distval = DistricIdmodel.fromMap(map);
            //   setState(() {
            //     districtId = distval.id;
            //     log('$districtId');
            //   });
            // }

            Navigator.of(_scaffoldKey.currentContext!).push(
              MaterialPageRoute(
                builder: (context) => ScreenLabSkill(
                  distId: value!.distId,
                  usrID: usrID,
                  token: token,
                ),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    "assets/background/skills-icon-check-sign-skilled-260nw-1283634085.jpg",
                    fit: BoxFit.contain,
                    width: 100,
                    height: 100,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.addskill,
                  style: kbodyfont,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: const Color.fromARGB(255, 158, 89, 248),
          highlightColor: const Color.fromARGB(255, 47, 3, 100),
          onTap: () {
            buildEvents();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ScreenLabTodoList(),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    "assets/background/istockphoto-1163732070-612x612.jpg",
                    fit: BoxFit.contain,
                    width: 90,
                    height: 90,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.todolist,
                  style: kbodyfont,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: const Color.fromARGB(255, 158, 89, 248),
          highlightColor: const Color.fromARGB(255, 47, 3, 100),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ScreenViewrating(usrId: usrID, token: token, name: name),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    "assets/background/rating-icon-free-vector.jpg",
                    fit: BoxFit.contain,
                    width: 80,
                    height: 80,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.rate,
                  style: kbodyfont,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future buildEvents() async {
    final value = await Sharedata.instance.getdata();
    final usrId = value!.userid;
    final addtodoresp = await Labourdata().gettodolist(usrId);
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
        final data = registerval.data;
        if (data == []) {
          Fluttertoast.showToast(
              msg: "No Events Found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          provider.removeallEvent();
          for (var model in data!) {
            final frmdt = model.frmDt;
            final frmtm = model.startTime;
            final todt = model.toDt;
            final totime = model.endTime;
            final fromDt = '${frmdt!} ${frmtm!}';
            final DateTime fromDate =
                DateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDt);
            final toDat = '${todt!} ${totime!}';
            final DateTime toDate =
                DateFormat("yyyy-MM-dd HH:mm:ss").parse(toDat);
            final event = Event.val(
                title: model.title,
                description: model.description,
                from: fromDate,
                to: toDate,
                todolistId: model.todolistId);
            provider.addEvent(event);
          }

          // final event=Event.val(
          // title: data!.single.title,
          //  description: data.single.description,
          //   from: from,
          //    to: to,
          //     todolistId: todolistId);
        }

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
}

// class Choice{
//   const Choice({required this.title,required this.image});
//   final String title;
//   final IconData image;
// }
// const List<Choice> choices=const<Choice>[
//   const Choice(title: 'View/ \nEdit \nProfile', image: image)
// ]
