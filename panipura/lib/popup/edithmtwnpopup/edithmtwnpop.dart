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
            const SizedBox(height: 10),
          Consumer<LoadingProvider>(
          builder: (context, loadingProvider, child) {
          return loadingProvider.isLoading
                ? const Center(
                child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 101, 47, 248),
                ),
                ),
              )
              : const SizedBox.shrink();
              }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Center(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    //const SizedBox(width: 15),
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
  final loadingProvider=context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
  final editresp = await Labourdata().edithometwn(val);
    loadingProvider.toggleLoading();

  log('$editresp');
  if (editresp == null) {
    if (!context.mounted) return;
    CommonFun.instance.showApierror(context, "Something went wrong");
  }
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

    if (!context.mounted) return;
    CommonFun.instance.showApierror(context, message);
    if (status == true) {
      if (!context.mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenLabProfile(
            usrId: val.userId,
            token: val.token,
          ),
        ),
      );
    }
  } else if (editresp.statusCode == 404) {
    if (!context.mounted) return;
    CommonFun.instance.showApierror(context, "No Data Found");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenLabProfile(
          usrId: val.userId,
          token: val.token,
        ),
      ),
    );
  } else if (editresp.statusCode == 500) {
    if (!context.mounted) return;
    CommonFun.instance.showApierror(context, "Sever Not Reachable");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            ScreenLabProfile(usrId: val.userId, token: val.token),
      ),
    );
    // showLoginerror(context, 3);
  } else if (editresp.statusCode == 408) {
    if (!context.mounted) return;
    CommonFun.instance.showApierror(context, "Connection time out");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            ScreenLabProfile(usrId: val.userId, token: val.token),
      ),
    );
    //showLoginerror(context, 4);
  } else {
    if (!context.mounted) return;
    CommonFun.instance.showApierror(context, "Something went wrong");
    //showLoginerror(context, 5);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            ScreenLabProfile(usrId: val.userId, token: val.token),
      ),
    );
  }
}
