import 'package:panipura/l10n/l10n.dart';
import '../../core/hooks/hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';

class ScreenEditSkill extends StatefulWidget {
  const ScreenEditSkill(
      {super.key, required this.skilldet, required this.reference});
  final List<Map<String, dynamic>> skilldet;
  final List<SkillrefListmdl> reference;
  @override
  State<ScreenEditSkill> createState() => _ScreenLabSkillState();
}

class _ScreenLabSkillState extends State<ScreenEditSkill> {
  final _formkey4 = GlobalKey<FormState>();
  final _otherdmndcontroller = TextEditingController();
  final _wrknamecontroller = TextEditingController();
  final _remunerationcontroller = TextEditingController();
  final _mobileno1controller = TextEditingController();
  final _mobileno2controller = TextEditingController();
  final _referenceperson1controller = TextEditingController();
  final _referenceperson2controller = TextEditingController();
  String? dropdowncategoryvalue;
  String? dropdownexperiencevalue;
  String? dropdownpervalue;
  String? dropdowndistancevalue;
  String? remuneraion;
  String? otherdmnd;
  String? mobileno1;
  String? mobileno2;
  //  int? categoryId;
  int? usrId;
  bool? status;
  String? message;
  String? token;
  late List<int> dropdownpanchayathId;
  List<String> loclbdslist = [];
  List<String> dropdownpanchayathval = [];
  List<String> experiencelist = [];
  bool _showErrors = false;
  final List<String> errors = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int? distId;
  int? skillId;
  int? occupationId;
  List<SkillrefListmdl>? reference;
  List<dynamic>? willingpanchayath;
  Locale? localecode;
  String? langcode;
  @override
  void initState() {
    //checkUserLoggedIn();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();
    });
    super.initState();
    if (widget.reference.isEmpty) {
      _mobileno1controller.text = '';
      _mobileno2controller.text = '';
      _referenceperson1controller.text = '';
      _referenceperson2controller.text = '';
    } else {
      if (widget.reference.length == 2) {
        _referenceperson1controller.text = widget.reference[0].name!;
        _mobileno1controller.text = widget.reference[0].mobile!;
        _referenceperson2controller.text = widget.reference[1].name!;
        _mobileno2controller.text = widget.reference[1].mobile!;
      } else {
        _referenceperson1controller.text = widget.reference[0].name!;
        _mobileno1controller.text = widget.reference[0].mobile!;
        _referenceperson2controller.text = '';
        _mobileno2controller.text = '';
      }
    }

    dropdownlocalbodies();
    getskilldet();
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  void getskilldet() {
    for (var skillvalues in widget.skilldet) {
      final skilledit = GetEditskillresplist.fromJson(skillvalues);
      _wrknamecontroller.text = skilledit.occupationname!;
      dropdownexperiencevalue = skilledit.experience;
      _remunerationcontroller.text = skilledit.wages.toString();
      dropdownpervalue = skilledit.wPeriod;
      if (skilledit.additionalInfo == null) {
        _otherdmndcontroller.text = '';
      } else {
        _otherdmndcontroller.text = skilledit.additionalInfo!;
      }
      if (skilledit.willingpanchayath == null) {
        dropdownpanchayathval = [];
      } else {
        final dropdownpanchaval = skilledit.willingpanchayath!;

        dropdownpanchayathval = dropdownpanchaval;
      }

      occupationId = skilledit.occupationId;
      skillId = skilledit.skillId;
      distId = skilledit.districtId;
      usrId = skilledit.userId;
      token = skilledit.token;
    }
  }

  DropdownMenuItem<String> getLocalbdyDropDownWidget(Map<String, dynamic> map) {
    if (localecode == Locale('ml')) {
      return DropdownMenuItem<String>(
        value: map['name_ml'],
        child: Text(map['name_ml'], overflow: TextOverflow.ellipsis),
      );
    } else {
      return DropdownMenuItem<String>(
        value: map['name'],
        child: Text(map['name'], overflow: TextOverflow.ellipsis),
      );
    }
  }

  Future dropdownlocalbodies() async {
    loclbdslist = [];
    LabourDb.instance.initializedatabase().then((status) {
      if (status) {
        LabourDb.instance
            .getLocalbodies(distId, 2, localecode, context)
            .then((listMap) {
          listMap.map((map) {
            log(map.toString());
            return getLocalbdyDropDownWidget(map);
          }).forEach((dropDownItem) {
            loclbdslist.add(dropDownItem.value!);
          });
          setState(() {});
        });
      }
    });
  }

  final perlist = [
    'Hour',
    'Day',
  ];

  final workaroundlist = ['PANCHAYATH WISE', 'KILOMETER WISE'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    experiencelist = [
      AppLocalizations.of(context)!.below,
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      AppLocalizations.of(context)!.above,
    ];
    return Stack(
      key: _scaffoldKey,
      children: [
        const Screensbackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ScreenLabProfile(
                            usrId: usrId,
                            token: token,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 158, 89, 248),
                    )),
              ),
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.vweditskil,
                style: L10n.getappbarSize(locale.languageCode),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(50))),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.editskil,
                        style: L10n.getappbarSize(locale.languageCode),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //SizedBox(height:SizeConfig.screenHeight*0.05),
                Expanded(
                  child: Scrollablewidget(child: skillSetForm()),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget skillSetForm() {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Form(
      key: _formkey4,
      autovalidateMode:
          _showErrors ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Column(
        children: [
          /* Occupations */

          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: TextFormField(
                controller: _wrknamecontroller,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 158, 89, 248),
                        width: 1,
                      )),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.occup,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                ),
              ),
            ),
          ),
          /* ************************* */

          /* Experience */

          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: DropdownButtonFormField(
                style: const TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 101, 47, 248),
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 158, 89, 248),
                        width: 1,
                      )),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.exp,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
                items: experiencelist.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (newvalue) {
                  setState(() {
                    dropdownexperiencevalue = newvalue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return kexperienceNullError;
                  }
                  return null;
                },
                value: dropdownexperiencevalue,
              ),
            ),
          ),

          /* ************************** */

          /* Wages */
          SizedBox(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: TextFormField(
                controller: _remunerationcontroller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
                onSaved: (newValue) => remuneraion = newValue,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  fillColor: Colors.white,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    child: Text(
                      " (₹)",
                      style: TextStyle(
                          color: Color.fromARGB(255, 101, 47, 248),
                          fontSize: 17),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 158, 89, 248),
                        width: 1,
                      )),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.wage,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 101, 47, 248),
                    fontSize: 17,
                  ),
                ),
                // onChanged: (value) {
                //   setState(() {
                //   // Here you can check your conditio
                //   _conditionMet = value.length < 5; // Example condition
                // });
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return kremunerationNullError;
                  } else if (_remunerationcontroller.text.length >= 5) {
                    return kremunerationValidError;
                  }
                  return null;
                },
              ),
            ),
          ),
          /* *************************** */

          /* Wages per */

          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 50.0,
              ),
              child: DropdownButtonFormField(
                style: const TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 101, 47, 248),
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 158, 89, 248),
                        width: 1,
                      )),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.per,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
                items: perlist.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (newvalue) {
                  setState(() {
                    dropdownpervalue = newvalue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return kperNullError;
                  }
                  return null;
                },
                value: dropdownpervalue,
              ),
            ),
          ),

          /* Other demand */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: TextFormField(
                controller: _otherdmndcontroller,
                keyboardType: TextInputType.text,
                maxLines: 3,
                maxLength: 200,
                // style:kBodyText,
                style: const TextStyle(color: Colors.black),

                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.other,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                ),
              ),
            ),
          ),
          /* ************************* */
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.willingwrk,
                style: L10n.getappbarSize(locale.languageCode),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /* willing to work around */

          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  //color: const Color.fromARGB(255, 158, 89, 248),
                  border: Border.all(
                    color: const Color.fromARGB(255, 158, 89, 248),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: DropDownMultiSelect(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: AppLocalizations.of(context)!.panja,
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 101, 47, 248)),
                  ),
                  options: loclbdslist,
                  onChanged: (newvalue) async {
                    setState(() {
                      dropdownpanchayathval = newvalue;
                      log('$dropdownpanchayathval');
                    });
                  },
                  selectedValues: dropdownpanchayathval,
                ),
              ),
            ),
          ),

          /* *************************** */

          /* Reference Person1 */
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: TextFormField(
                controller: _referenceperson1controller,
                keyboardType: TextInputType.text,
                //style:kBodyText,
                style: const TextStyle(color: Colors.black),
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.reference1,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                ),
              ),
            ),
          ),

          /* **************************** */

          /* mobile number */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: TextFormField(
                controller: _mobileno1controller,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.black),
                //style:kBodyText,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onSaved: (newValue) => mobileno1 = newValue,
                validator: (value) {
                  if (_referenceperson1controller.text.isNotEmpty) {
                    if (value == null || value.isEmpty) {
                      return kMobileNullError;
                    } else if (_mobileno1controller.text.length < 10 ||
                        _mobileno1controller.text.length > 10) {
                      return kValidMobileError;
                    } else if (value.contains(' ')) {
                      showSnackBar(context, text: kSpaceMobileError);
                    }
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  fillColor: Colors.white,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    child: Text(
                      " (+91)",
                      style: TextStyle(
                          color: Color.fromARGB(255, 101, 47, 248),
                          fontSize: 17),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 158, 89, 248),
                        width: 1,
                      )),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.mobile,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                ),
              ),
            ),
          ),
          /* Reference Person2 */
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: TextFormField(
                controller: _referenceperson2controller,
                keyboardType: TextInputType.text,
                //style:kBodyText,
                style: const TextStyle(color: Colors.black),

                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.reference2,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                ),
              ),
            ),
          ),

          /* ********************** */

          /* mobile number */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: TextFormField(
                controller: _mobileno2controller,
                keyboardType: TextInputType.phone,
                //style:kBodyText,
                style: const TextStyle(color: Colors.black),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onSaved: (newValue) => mobileno2 = newValue,
                validator: (value) {
                  if (_referenceperson2controller.text.isNotEmpty) {
                    if (value == null || value.isEmpty) {
                      return kMobileNullError;
                    } else if (_mobileno2controller.text.length < 10 ||
                        _mobileno2controller.text.length > 10) {
                      return kValidMobileError;
                    } else if (value.contains(' ')) {
                      showSnackBar(context, text: kSpaceMobileError);
                    }
                  }

                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  fillColor: Colors.white,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    child: Text(
                      " (+91)",
                      style: TextStyle(
                          color: Color.fromARGB(255, 101, 47, 248),
                          fontSize: 17),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 158, 89, 248),
                        width: 1,
                      )),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 89, 248),
                      width: 1,
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.mobile,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                ),
              ),
            ),
          ),
          /* ************************* */

          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
            child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _showErrors =
                        true; // Set to true to display errors on submit
                  });
                  if (_formkey4.currentState!.validate()) {
                    //goto otp screen
                    await editLabourSkill(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                    fixedSize: const Size(200, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  AppLocalizations.of(context)!.updateskill,
                  style: L10n.getbuttonstyle(locale.languageCode),
                  textAlign: TextAlign.center,
                )),
          ),
          // Center(
          //     child: FormHelper.submitButton(
          //         AppLocalizations.of(context)!.updateskill,
          //          () async {
          //       if (_formkey4.currentState!.validate()) {
          //         //goto otp screen
          //         await editLabourSkill();
          //       }
          //     },
          //         borderColor: const Color.fromARGB(255, 158, 89, 248),
          //         btnColor: const Color.fromARGB(255, 158, 89, 248),
          //         txtColor: Colors.white,
          //         borderRadius: 20)),
        ],
      ),
    );
  }

  Future editLabourSkill(BuildContext context) async {
    final wages = _remunerationcontroller.text;
    final otherdmnd = _otherdmndcontroller.text;
    final person1 = _referenceperson1controller.text;
    final refmob1 = _mobileno1controller.text;
    final person2 = _referenceperson2controller.text;
    final refmob2 = _mobileno2controller.text;
    if (otherdmnd.isEmpty) {
      otherdmnd == '';
    }
    // final value = await Sharedata.instance.getdata();
    //  usrId=value!.userid;
    //  token=value.token;
    if (localecode == Locale('ml')) {
      langcode = langmal;
    } else {
      langcode = langeng;
    }
    final referperson = Addrefskilllist.req(
      userId: usrId,
      name: person1,
      mobile: refmob1,
    );
    final referperson1 = Addrefskilllist.req(
      userId: usrId,
      name: person2,
      mobile: refmob2,
    );
    // if(referperson1.mobile==null){

    // }

    final skillreq = Addrefskillreq.req(
      userId: usrId,
      skillId: skillId,
      occupationId: occupationId,
      experience: dropdownexperiencevalue,
      wages: wages,
      wperiod: dropdownpervalue,
      additionalInfo: otherdmnd,
      willingpanchayath: dropdownpanchayathval,
      references: [referperson, referperson1],
    );

    final editskillrslt = await Labourdata().editskill(skillreq, langcode);

    log('$editskillrslt');
    if (editskillrslt == null) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Something went wrong");
      }  else if (editskillrslt.statusCode == 200) {
      final resultAsjson = jsonDecode(editskillrslt.data);

      final registerval =
          Addskillresp.fromJson(resultAsjson as Map<String, dynamic>);
      status = registerval.success;
      if (status == true) {
        message = registerval.message;
        await showDialogsuccess(_scaffoldKey.currentContext, message);
      } else {
        message = registerval.message;
        await showDialogfail(_scaffoldKey.currentContext, message);
      }
    } else if (editskillrslt.statusCode == 404) {
      await showDialogError(_scaffoldKey.currentContext);
    }else if (editskillrslt.statusCode == 500) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (editskillrslt.statusCode == 408) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
  }

  Future showDialogsuccess(BuildContext? context, String? message) async =>
      showDialog(
          context: context!,
          builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.skilladdsuc,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 2, 129, 6),
                          fontFamily: 'RobotoSerif_28pt-Medium')),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => ScreenLabProfile(
                                  usrId: usrId,
                                  token: token,
                                ),
                              ),
                            ),
                        child: const Center(child: Text('OK'))),
                  ]));

  Future showDialogfail(BuildContext? context, String? message) async =>
      showDialog(
          context: context!,
          builder: (context) => AlertDialog(
                  title: Text(message ?? "something went wrong",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 241, 26, 10),
                          fontFamily: 'RobotoSerif_28pt-Medium')),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          if (message == "Occupation already added") {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => ScreenLabProfile(
                                  usrId: usrId,
                                  token: token,
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => ScreenEditSkill(
                                  skilldet: widget.skilldet,
                                  reference: widget.reference,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Center(child: Text('OK'))),
                  ]));

  Future showDialogError(BuildContext? context) async => showDialog(
      context: context!,
      builder: (context) => AlertDialog(
              title: const Text('Server Not reached',
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 26, 10),
                      fontFamily: 'RobotoSerif_28pt-Medium')),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => ScreenEditSkill(
                                skilldet: widget.skilldet,
                                reference: widget.reference),
                          ),
                        ),
                    child: const Center(child: Text('OK'))),
              ]));
}
