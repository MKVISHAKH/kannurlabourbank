import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/database/labourdb.dart';
import 'package:panipura/functions/laborfn.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/model/deleteskill/deletereq/deletereq/deletereq.dart';
import 'package:panipura/model/dropdownId/occupationmodel.dart';
import 'package:panipura/model/dropdownname/namemdl.dart';
import 'package:panipura/provider/loadingprovider.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:panipura/provider/profilepicprovider.dart';
import 'package:panipura/screens/deleteaccount/deleteAccount.dart';
import 'package:panipura/screens/screenlabour/screeneditskill.dart';
import 'package:panipura/widgets/constants.dart';
import '../../model/get skill/skilllistmdlref/skillreflistmdl.dart';
import '../../model/upldimg/uploadimgresp/uploadimgresp.dart';
import '../../utils/app_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';
class ScreenLabProfile extends StatefulWidget {
  final int? usrId;
  final String? token;
  const ScreenLabProfile({super.key, required this.usrId, required this.token});

  @override
  State<ScreenLabProfile> createState() => _ScreenLabProfileState();
}

class _ScreenLabProfileState extends State<ScreenLabProfile> {
  final double coverwidth = double.infinity;
  final double coverHeight = 110;
  final double profileHeight = 80;
  String? name;
  String? place;
  String? mob;
  String? dob;
  String? sex;
  String? edu;
  String? skillname;
  bool isSkillnull = true;
  bool skillisNull = false;
  int? usrId;
  String? token;
  // int? districtId;
  int? wrkId;
  File? fileImage;
  //NetworkImage? _imageFile;
  String? langcode;
  Locale? localecode;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();
      profilepicload();
    });
    super.initState();
    usrId = widget.usrId;
    token = widget.token;
    getSkills();

    getUserdata();

    // getProfilePic();

    // Future.delayed(Duration.zero, () {
    //   var po = context.read<ProfilepicProvider>();
    //   po.updateProfilepic(usrId, token);
    // });

    //loadproPic();
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  void profilepicload(){
    final loadingProvider = Provider.of<LoadingProvider>(context,listen: false);
    loadingProvider.toggelLoading();
    final pro=Provider.of<ProfilepicProvider>(context,listen: false);
    // var po = context.read<ProfilepicProvider>();
      pro.updateProfilepic(usrId, token);
      loadingProvider.toggelLoading();
      setState(() {
        
      });
      
  }

  getSkills() async {
    final value = await Sharedata.instance.getdata();

    usrId = value!.userid;
    if (localecode == Locale('ml')) {
      langcode = langmal;
    } else {
      langcode = langeng;
    }
    await Labempfn.instance.refreshskillUI(usrId, langcode);
  }

  void getUserdata() async {
    final value = await Sharedata.instance.getdata();
    final nam = value!.name;
    final plac = value.place;
    final mobi = value.mobile;
    final dbirth = value.dob;
    log('$dbirth');
    DateTime dobdt = DateFormat("yyyy-MM-dd").parse(dbirth!);
    DateFormat dateFormat1 = DateFormat.yMMMMd();
    String birthdt = dateFormat1.format(dobdt);
    log(birthdt);
    String? eduName;
    final eduNameval = await LabourDb.instance
          .getEduName(value.educationId, localecode);

      for (var map in eduNameval) {
        final edu = Namemodel.fromMap(map);
        setState(() {
          if (localecode == Locale('ml')) {
            eduName = edu.nameml;
            log('$eduName');
          } else {
            eduName = edu.name;
            log('$eduName');
          }
        });
      }

      String? genderName;
      final genderNameval = await LabourDb.instance
          .getGenderName(value.genderId, localecode);

      for (var map in genderNameval) {
        final gender = Namemodel.fromMap(map);
        setState(() {
          if (localecode == Locale('ml')) {
            genderName = gender.nameml;
            log('$genderName');
          } else {
            genderName = gender.name;
            log('$genderName');
          }
        });
      }
    //final gender = value.gender;
    //final educat = value.education;

    setState(() {
      name = nam;
      place = plac;
      mob = mobi;
      sex = genderName;
      edu = eduName;
      dob = birthdt;

      name = name!.toUpperCase();
      sex = sex!.toUpperCase();
      place = place!.toUpperCase();
      mob = mob!.toUpperCase();
      edu = edu!.toUpperCase();
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _scaffoldKey,
      children: [
        const Screensbackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              buildtop(),
              buildContent(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildtop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(margin: EdgeInsets.only(bottom: bottom), child: buildCover()),
        Positioned(top: top, child: buildProfileImage()),
      ],
    );
  }

  Widget buildCover() {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    final double screenwidth = MediaQuery.of(context).size.width;
    return Container(
        //width:coverwidth,
        height: coverHeight,
        //color:Colors.white,
        decoration: const BoxDecoration(
            color: Appcolors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Screenlabhome(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Appcolors.fontclr,
                  )),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: screenwidth / 6),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.pro,
                    style: L10n.getappbarSize(locale.languageCode),
                  ),
                )),
          ],
        ));
  }

  Widget buildProfileImage() {
    final provider = Provider.of<ProfilepicProvider>(context);
    final imagepro = provider.imageFile;
    //var inputPro = context.read<ProfilepicProvider>();
    return Stack(children: [
      CircleAvatar(
          radius: profileHeight / 1.8,
          backgroundImage: imagepro,
          backgroundColor: Colors.white,
          child:Consumer<LoadingProvider>(builder: (context, loadingProvider, child) {
            return loadingProvider.isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 2, 128, 6)),
                  )
                : const SizedBox.shrink();
          }),),
      Positioned(
          bottom: 10.0,
          right: 10.0,
          child: InkWell(
            onTap: () {
              imgModelbottomSheet(propic);
            },
            child: const Icon(Icons.camera_alt,
                color: Color.fromARGB(255, 101, 47, 248), size: 25.0),
          ))
    ]);
  }

  //  getproimage()async{
  //   final value = await Sharedata.instance.getdata();

  //   final userId=value!.userid;
  //   final token=value.token;
  //  final img= Labourdata().getImage(userId,token);
  //  return img;
  // }

  Future imgModelbottomSheet(int picid) {
    return showModalBottomSheet(
        context: context,
        builder: ((builder) => Container(
            height: 150.0,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.choosepropic,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          var po = context.read<ProfilepicProvider>();
                          takePhoto(ImageSource.camera, picid, context,po);
                        },
                        icon: const Icon(
                          Icons.camera,
                          size: 30,
                        ),
                        label: const Text("Camera")),
                    TextButton.icon(
                        onPressed: () {
                          var po = context.read<ProfilepicProvider>();
                          takePhoto(ImageSource.gallery, picid, context,po);
                        },
                        icon: const Icon(Icons.image, size: 30),
                        label: const Text("Gallery"))
                  ],
                )
              ],
            ))));
  }

  Future takePhoto(ImageSource source, int typeid, BuildContext context,ProfilepicProvider provider) async {
    final pickedFile = await picker.pickImage(source: source);
    //final provider = Provider.of<ProfilepicProvider>(_scaffoldKey.currentContext!);
    final loadingProvider = Provider.of<LoadingProvider>(_scaffoldKey.currentContext!,listen:false);
    loadingProvider.toggelLoading();
    if (pickedFile != null) {
      var image = File(pickedFile.path.toString());
      final sizeInKbBefore = image.lengthSync() / 1024;
      log('Before Compress $sizeInKbBefore kb');
      final imagepath=image.absolute.path;
      final mimeType = lookupMimeType(imagepath);
      if(mimeType==null){
       Fluttertoast.showToast(
            msg: AppLocalizations.of(_scaffoldKey.currentContext!)!.errorpic,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        //showSnackBar(_scaffoldKey.currentContext!, text: "profile picture uploaded");
        Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScreenLabProfile(usrId: usrId, token: token),
          ),
        );
      }
      
      else if(mimeType=='image/jpeg'){
        log(mimeType);
        var compressedImage = await AppHelper.compress(image: image);
      final sizeInKbAfter = compressedImage!.lengthSync() / 1024;
      log('After Compress $sizeInKbAfter kb');
      var croppedImage = await AppHelper.cropImage(compressedImage);
      if (croppedImage == null) {
        return;
      }
      setState(() {
        final File imageFile = File(croppedImage.path);
        fileImage = imageFile;
      });
      final imgresp = await Labourdata().uploadimg(fileImage, usrId, typeid);
      loadingProvider.toggelLoading();
    if (imgresp == null) {
      Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (imgresp.statusCode == 200) {
      final resultAsjson = jsonDecode(imgresp.data);

      final imgval =
          Uploadimgresp.fromJson(resultAsjson as Map<String, dynamic>);
      final status = imgval.success;
      if (status == true) {
        provider.updateProfilepic(usrId, token);

        Fluttertoast.showToast(
            msg: AppLocalizations.of(_scaffoldKey.currentContext!)!.uploadpic,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        //showSnackBar(_scaffoldKey.currentContext!, text: "profile picture uploaded");
        Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScreenLabProfile(usrId: usrId, token: token),
          ),
        );
      } else {
        showSnackBar(_scaffoldKey.currentContext!,
            text: "something went wrong");
      }
    } else {
      showSnackBar(_scaffoldKey.currentContext!, text: "Server not reached");
    }
    log('$imgresp');

    setState(() {});
      }
      else{
        Fluttertoast.showToast(
            msg: AppLocalizations.of(_scaffoldKey.currentContext!)!.errorpic,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        //showSnackBar(_scaffoldKey.currentContext!, text: "profile picture uploaded");
        Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScreenLabProfile(usrId: usrId, token: token),
          ),
        );
      }
    }
    //if(pickedFile!.mimeType=='image/jpeg'|| pickedFile.mimeType=='image/png')
    // if(pickedFile != null){
    //   File imgfile=File(pickedFile.path);

    else{
        Fluttertoast.showToast(
            msg: AppLocalizations.of(_scaffoldKey.currentContext!)!.errorpic,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        //showSnackBar(_scaffoldKey.currentContext!, text: "profile picture uploaded");
        Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScreenLabProfile(usrId: usrId, token: token),
          ),
        );
      }
    
  }

  getImageFrom({required ImageSource source}) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      var image = File(pickedImage.path.toString());
      final sizeInKbBefore = image.lengthSync() / 1024;
      log('Before Compress $sizeInKbBefore kb');
      var compressedImage = await AppHelper.compress(image: image);
      final sizeInKbAfter = compressedImage!.lengthSync() / 1024;
      log('After Compress $sizeInKbAfter kb');
      var croppedImage = await AppHelper.cropImage(compressedImage);
      if (croppedImage == null) {
        return;
      }
      setState(() {
        final File imageFile = File(croppedImage.path);
        fileImage = imageFile;
      });
    }
  }

  Widget buildContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Center(
              child: Text(
            '$name',
            style: kHeaderText,
          )),
          //  const SizedBox(height: 8,),
          // const Center(child:  Text('Carpenter',style:kHeaderlightText)),
          const SizedBox(
            height: 16,
          ),
          const Divider(),
          const SizedBox(
            height: 16,
          ),
          buildskils(),
          buildAbout(),
        ],
      );

  Widget buildskils() {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.about,
              style: L10n.getappbarSize(locale.languageCode)),
          const SizedBox(
            height: 16,
          ),
          const Divider(),

          /******Work*******/

          Text(AppLocalizations.of(context)!.skill,
              style: L10n.getappbarSize(locale.languageCode)),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    //Navigator.push(context,Approutes().addSkillScreen);
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
                        builder: (ctx) => ScreenLabSkill(
                            distId: value!.distId,
                            usrID: widget.usrId,
                            token: widget.token),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 25,
                  )),
              // Text('Add Work',style:kscreenText),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.addskill,
                  style: L10n.getappbarSize(locale.languageCode),
                ),
                onPressed: () async {
                  //Navigator.push(context,Approutes().addSkillScreen);
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
                      builder: (ctx) => ScreenLabSkill(
                          distId: value!.distId,
                          usrID: widget.usrId,
                          token: widget.token),
                    ),
                  );
                },
              ),
            ],
          ),
          const Divider(),
          // skillisNull==isSkillnull?
          buildlistaddskill()
          //  :Container()
        ],
      ),
    );
  }

  Widget buildAbout() {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            const Divider(),
            /******Home town *******/

            Text(AppLocalizations.of(context)!.hmtown,
                style: L10n.getappbarSize(locale.languageCode)),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            ListTile(
              title: Text('$place ', style: kscreenText),
              subtitle: const Text('Current Location'),
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/background/homeimg.png'),
              ),
              trailing: IconButton(
                  onPressed: () {
                    final editreq =
                        Getskillreq.req(userId: usrId, token: widget.token);
                    showEditHometownpopup(context, editreq);
                  },
                  icon: const Icon(Icons.edit,
                      size: 30, color: Color.fromARGB(255, 158, 89, 248))),
            ),
            // ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),

            /******Contact info*******/
            Text(AppLocalizations.of(context)!.contact,
                style: L10n.getappbarSize(locale.languageCode)),
            const SizedBox(
              height: 8,
            ),

            const Divider(),
            ListTile(
              title: Text('$mob ', style: kscreenText),
              subtitle: const Text('Mobile'),
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/background/4392964.png'),
              ),
              //trailing: IconButton(onPressed: (){}, icon:const Icon(Icons.edit,color: Color.fromARGB(255, 158, 89, 248))),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),

            /******Basic info*******/
            Text(AppLocalizations.of(context)!.bsinfo,
                style: L10n.getappbarSize(locale.languageCode)),
            const SizedBox(
              height: 8,
            ),

            ListTile(
              title: Text('$sex ', style: kscreenText),
              subtitle: const Text('Gender'),
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                    'assets/background/user-icon-vector-9916742.jpg'),
              ),
              //trailing: IconButton(onPressed: (){}, icon:const Icon(Icons.edit,color: Color.fromARGB(255, 158, 89, 248))),
            ),
            const SizedBox(
              height: 8,
            ),

            const Divider(),

            ListTile(
              title: Text('$dob', style: kscreenText),
              subtitle: const Text('Date of Birth'),
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                    'assets/background/788-7885571_timing-icon-calendar-right-time-icon.png'),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),

            Text(AppLocalizations.of(context)!.educat,
                style: L10n.getappbarSize(locale.languageCode)),
            const SizedBox(
              height: 8,
            ),
            // Row(children: [
            //   IconButton(onPressed: (){

            //   }, icon:const Icon(Icons.add,size: 30)),
            // const Text('Education',style:kscreenText),
            // ],),
            const Divider(),
            ListTile(
              title: Text('$edu', style: kscreenText),
              subtitle: const Text('Qualification'),
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/background/education.png'),
              ),
              //trailing: IconButton(onPressed: (){}, icon:const Icon(Icons.add,color: Color.fromARGB(255, 158, 89, 248))),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            ListTile(
              title: Text(AppLocalizations.of(context)!.deleteac, style: kscreenText),
              subtitle: const Text('Delete your Account'),
              onTap: (){
                  Navigator.of(_scaffoldKey.currentContext!).push(
                      MaterialPageRoute(
                        builder: (ctx) => ScreenDeleteAccount(usrId: widget.usrId,token: widget.token,category: lab,)
                      ),
                    );
              },
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildlistaddskill() => ValueListenableBuilder(
      valueListenable: Labempfn.instance.getSkillListNotifier,
      builder:
          (BuildContext context, List<Getrefskillresplist> newList, Widget? _) {
        return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (ctx, index) {
              final value = newList[index];

              DateFormat dateFormat1 = DateFormat.yMMMMd();
              String jobdt = dateFormat1.format(value.createdAt!);

              final skillid = value.skillId;
              //String skillval = skillid.toString();

              final wrkname = value.occupationname;
              final userid = value.userId;
              final exp = value.experience;
              final wage = value.wages;
              final wageper = value.wPeriod;
              final otherdmnd = value.additionalInfo;
              final reference = value.references;
              // final tomapref=reference.toMap();
              final willingpanchayath = value.willingpanchayath;

              return Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  //borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.edit_document,
                      size: 30,
                      color: Color.fromARGB(255, 158, 89, 248),
                    ),
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
                      final occupationId = await LabourDb.instance
                          .getOccupationsId(wrkname, localecode);

                      for (var map in occupationId) {
                        final wrkval = WrkIdmodel.fromMap(map);
                        setState(() {
                          wrkId = wrkval.id;
                          log('$wrkId');
                        });
                      }

                      List<Map<String, Object?>> skilledit = [
                        {
                          'userId': widget.usrId,
                          'occupationId': wrkId,
                          'occupationname': wrkname,
                          'experience': exp,
                          'wages': wage,
                          'wPeriod': wageper,
                          'additionalInfo': otherdmnd,
                          'willing_panchayath': willingpanchayath,
                          'skillId': skillid,
                          // 'references':reference,
                          'token': widget.token,
                          'districtId': value!.distId
                        }
                      ];

                      Navigator.of(_scaffoldKey.currentContext!)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => ScreenEditSkill(
                            skilldet: skilledit,
                            reference: reference,
                          ),
                        ),
                      );
                    },
                    title: Text(wrkname!, style: kscreenText),
                    subtitle: Text(jobdt,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 47, 3, 100),
                        )),
                    trailing: IconButton(
                      onPressed: () async {
                        final deletereq =
                            Deletereq.req(userId: userid, skillId: skillid);

                        warningBox(context, deletereq);
                      },
                      icon: const Icon(Icons.delete,
                          size: 30, color: Color.fromARGB(255, 158, 89, 248)),
                    ),
                    //  onTap: () async{
                    //   final deletereq=Deletereq.req(userId: userid, skillId: skillid);

                    //   warningBox(context,deletereq);
                    //  }
                  ),
                ),
              );
            },
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 5,
                )),
            itemCount: newList.length);
      });

  Future warningBox(BuildContext context, Deletereq value) async =>
      showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                title: Center(
                    child: Text(AppLocalizations.of(context)!.delskill,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 101, 47, 248)))),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.no,
                        style: const TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                    ),
                    onPressed: () async {
                      builddeleteskill(context, value);
                    },
                    child: Text(AppLocalizations.of(context)!.yes,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ));

  Future builddeleteskill(BuildContext context, Deletereq value) async {
    final deleteresp = await Labourdata().deleteskill(value);

    log('$deleteresp');
    if (deleteresp == null) {
      Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (deleteresp.statusCode == 200) {
      final resultAsjson = jsonDecode(deleteresp.data);
      final searchval =
          Deleteresp.fromJson(resultAsjson as Map<String, dynamic>);
      final message = searchval.message;
      final status = searchval.success;
      if (status == true) {
        Fluttertoast.showToast(
            msg: message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Labempfn.instance.refreshskillUI;
        Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                ScreenLabProfile(usrId: widget.usrId, token: widget.token),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: message ?? "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                ScreenLabProfile(usrId: widget.usrId, token: widget.token),
          ),
        );
      }
    } else {
      Fluttertoast.showToast(
          msg: "Server error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              ScreenLabProfile(usrId: widget.usrId, token: widget.token),
        ),
      );
    }
  }
}

// Future<String?> getskillname(int? wrkdid)async{
//    final skillNameval=await LabourDb.instance.getOccupationsName(wrkdid);

//                    for(var map in skillNameval){
//                               final skill=Namemodel.fromMap(map);
//                               setState(() {
//                                 skillname=skill.name;
//                                 print(skillname);
//                                 skillname=skillname!.toUpperCase();

//                               });
//                             return skillname;
//                    }
// }

// Widget bottomsheet(int picid){
//   return Container(
//     height: 100.0,
//     width: MediaQuery.of(context).size.width,
//     margin:const EdgeInsets.symmetric(
//       horizontal: 20,
//       vertical: 20,
//     ),
//     child:Column(children: [
//       const Text("Choose Profile Photo",
//       style:TextStyle(
//         fontSize: 20.0,
//         color:Color.fromARGB(255, 101, 47, 248),
//       ),

//       ),
//      const  SizedBox(height: 20,),
//        Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           TextButton.icon(
//             onPressed: (){
//               takePhoto(ImageSource.camera,picid);
//             },
//              icon:const Icon(Icons.camera,size: 30,),
//               label:const Text("Camera")
//               ),
//           TextButton.icon(
//             onPressed: (){
//               takePhoto(ImageSource.gallery,picid);
//             },
//              icon:const Icon(Icons.image,size:30),
//               label:const Text("Gallery")
//               )
//        ],)
//     ],)
//   );

// }
