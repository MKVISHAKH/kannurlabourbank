import 'package:panipura/core/hooks/hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';

final _scaffoldKey = GlobalKey<ScaffoldState>();
final _formkey = GlobalKey<FormState>();
Future showEditHometownpopup(BuildContext context, Getskillreq editval) async {
  final placeEditingController = TextEditingController();
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          key: _scaffoldKey,
          title: Center(
              child: Text(
            AppLocalizations.of(context)!.edithome,
            style: const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
          )),
          children: [
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: placeEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.placeemp,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 158, 89, 248),
                        width: 1,
                      ),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 158, 89, 248),
                          width: 1,
                        )),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 158, 89, 248),
                        width: 1,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.enterhome;
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Center(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 158, 89, 248),
                        ),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text(AppLocalizations.of(context)!.cncl,
                            style: const TextStyle(color: Colors.white))),
                    const SizedBox(width: 15),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 158, 89, 248),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            final usrid = editval.userId;
                            final token = editval.token;
                            final place = placeEditingController.text;
                            final editreq = Edithmtwnreq.req(
                                userId: usrid, place: place, token: token);
                            buildedithmtwn(ctx, editreq);
                          } else {
                            return;
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.updt,
                            style: const TextStyle(color: Colors.white)))
                  ],
                ),
              ),
            )
          ],
        );
      });
}

Future buildedithmtwn(BuildContext context, Edithmtwnreq val) async {
  final editresp = await Labourdata().edithometwn(val);
  log('$editresp');
  if (editresp!.statusCode == 200) {
    final resultAsjson = jsonDecode(editresp.data);
    final searchval =
        Edithmtwnresp.fromJson(resultAsjson as Map<String, dynamic>);
    final place = searchval.place;
    final value = await Sharedata.instance.getdata();
    final usrID = value!.userid;
    final token = value.token;
    final name = value.name;
    final mobile = value.mobile;
    final address = value.address;
    final adhaar = value.aadhaar;
    final post = value.post;
    final pincode = value.pin;
    final gender = value.gender;
    final genderid = value.genderId;
    final district = value.district;
    final districtid = value.distId;
    final block = value.block;
    final blockid = value.blockId;
    final localbody = value.localbody;
    final localbodyid = value.localbodyId;
    final dob = value.dob;
    final education = value.education;
    final educationid = value.educationId;
    final category = value.category;
    final passwrd = value.password;
    final sharedval = SharedtokenM.values(
        userid: usrID,
        token: token,
        name: name,
        mobile: mobile,
        address: address,
        place: place,
        post: post,
        pin: pincode,
        gender: gender,
        genderId: genderid,
        district: district,
        distId: districtid,
        block: block,
        blockId: blockid,
        localbody: localbody,
        localbodyId: localbodyid,
        dob: dob,
        aadhaar: adhaar,
        education: education,
        educationId: educationid,
        category: category,
        password: passwrd);
    await Sharedata.instance.setdata(sharedval);
    final status = searchval.success;

    final message = searchval.message;
    Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    if (status == true) {
      Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenLabProfile(
            usrId: val.userId,
            token: val.token,
          ),
        ),
      );
    }
  } else if (editresp.statusCode == 404) {
    // final _resultAsjson = jsonDecode(editresp.data);
    //   final searchval= Deleteresp.fromJson(_resultAsjson as Map<String, dynamic>);
    //       final message=searchval.message;
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenLabProfile(
          usrId: val.userId,
          token: val.token,
        ),
      ),
    );
  } else {
    Fluttertoast.showToast(
        msg: "Server not reached",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            ScreenLabProfile(usrId: val.userId, token: val.token),
      ),
    );
  }
}
