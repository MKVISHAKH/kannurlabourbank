import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/l10n/l10n.dart';

import '../../core/hooks/hook.dart';

class ScreenRegister extends StatefulWidget {
  final int? category;

  const ScreenRegister({super.key, required this.category});

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  final _formkey = GlobalKey<FormState>();

  bool isVisible = true;

  final _namecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _placecontroller = TextEditingController();
  final _postcontroller = TextEditingController();
  final _pincodecontroller = TextEditingController();
  final _dobcontroller = TextEditingController();
  final _adhaarnocontroller = TextEditingController();
  final _mobilenocontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _cnfrmpasswordcontroller = TextEditingController();
  DateTime? selectedDob;
  String? dropdownxvalue;
  String? dropdownEduvalue;
  String? dropdowndistvalue;
  String? dropdownblockvalue;
  String? dropdownlocalvalue;
  String? name;
  String? address;
  String? place;
  String? post;
  String? pincode;
  String? sex;
  String? dob;
  String? adhaarno;
  String? mobile;
  String? education;
  String? district;
  String? block;
  String? localbody;
  bool passtoggle = true;
  bool cnfrmpasstoggle = true;
  int? genderId;
  int? districtId;
  int? localtypeId;
  int? localbdynameId;
  int? eduId;
  int? userId;
  bool? status;
  String? message;
  int? catval;
  String? mobileNo;
  bool? isTandC = false;
  late List<DropdownMenuItem<String>> distlist;
  late List<DropdownMenuItem<String>> edulist;
  late List<DropdownMenuItem<String>> locltypelist;
  late List<DropdownMenuItem<String>> genderlist;
  List<DropdownMenuItem<String>>? loclbdslist;
  final List<String> errors = [];
  Locale? localecode;
  //  late List<SearchFieldListItem<dynamic>> distlistval;

  Response<dynamic>? createusrval;
  // Createlabresp? registerval;

  @override
  void initState() {
    //checkUserLoggedIn();
    super.initState();
    Future.delayed(Duration.zero, () {
      var po = context.read<SignupProvider>();
      po.reset();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();
    });

    if (widget.category == lab) {
      isVisible = isVisible;
    } else {
      setState(() {
        isVisible = !isVisible;
      });
    }
    dropdowndistrict();
    dropdownEducation();
    dropdownLocalType();
    dropdownGender();
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  DropdownMenuItem<String> getDistDropDownWidget(Map<String, dynamic> map) {
    if (localecode == Locale('ml')) {
      return DropdownMenuItem<String>(
        value: map['name_ml'],
        child: Text(map['name_ml']),
      );
    } else {
      return DropdownMenuItem<String>(
        value: map['name'],
        child: Text(map['name']),
      );
    }
  }

// SearchFieldListItem<dynamic> getDistSearchDropDownWidget(Districtmodel map){
//   return SearchFieldListItem<dynamic>(
//     item:map.name,
//     child: Text(map['name']),
//     );
// }

  DropdownMenuItem<String> getEduDropDownWidget(Map<String, dynamic> map) {
    if (localecode == Locale('ml')) {
      return DropdownMenuItem<String>(
        value: map['name_ml'],
        child: Text(map['name_ml']),
      );
    } else {
      return DropdownMenuItem<String>(
        value: map['name'],
        child: Text(map['name']),
      );
    }
  }

  DropdownMenuItem<String> getTypeDropDownWidget(Map<String, dynamic> map) {
    if (localecode == Locale('ml')) {
      return DropdownMenuItem<String>(
        value: map['name_ml'],
        child: Text(map['name_ml']),
      );
    } else {
      return DropdownMenuItem<String>(
        value: map['name'],
        child: Text(map['name']),
      );
    }
  }

  DropdownMenuItem<String> getGenderDropDownWidget(Map<String, dynamic> map) {
    if (localecode == Locale('ml')) {
      return DropdownMenuItem<String>(
        value: map['name_ml'],
        child: Text(map['name_ml']),
      );
    } else {
      return DropdownMenuItem<String>(
        value: map['name'],
        child: Text(map['name']),
      );
    }
  }

  DropdownMenuItem<String> getLocalbdyDropDownWidget(Map<String, dynamic> map) {
    if (localecode == Locale('ml')) {
      return DropdownMenuItem<String>(
        value: map['name_ml'],
        child: Text(map['name_ml']),
      );
    } else {
      return DropdownMenuItem<String>(
        value: map['name'],
        child: Text(map['name']),
      );
    }
  }

// Future dropdownsearchdistrict() async{
//           distlistval=[];

//      LabourDb.instance.initializedatabase().then((status){
//       if(status){
//         LabourDb.instance.getDistrict().then((listMap) {
//           listMap.map((map){
//             print(map.toString());
//             final dist= Districtmodel.fromJson(map);
//             return getDistSearchDropDownWidget(dist);
//           }).forEach((dropDownItem) {
//             distlistval.add(dropDownItem);
//            });
//            setState(() {

//            });
//         });
//       }
//      });
//   }

  Future dropdowndistrict() async {
    distlist = [];
    LabourDb.instance.initializedatabase().then((status) {
      if (status) {
        LabourDb.instance.getDistrict(localecode, context).then((listMap) {
          listMap.map((map) {
            log(map.toString());
            return getDistDropDownWidget(map);
          }).forEach((dropDownItem) {
            distlist.add(dropDownItem);
          });
          setState(() {});
        });
      }
    });
  }

  Future dropdownEducation() async {
    edulist = [];
    LabourDb.instance.initializedatabase().then((status) {
      if (status) {
        LabourDb.instance.getEducation(localecode, context).then((listMap) {
          listMap.map((map) {
            log(map.toString());
            return getEduDropDownWidget(map);
          }).forEach((dropDownItem) {
            edulist.add(dropDownItem);
          });
          setState(() {});
        });
      }
    });
  }

  Future dropdownLocalType() async {
    locltypelist = [];
    LabourDb.instance.initializedatabase().then((status) {
      if (status) {
        LabourDb.instance.getLocalbodyType(localecode, context).then((listMap) {
          listMap.map((map) {
            log(map.toString());
            return getTypeDropDownWidget(map);
          }).forEach((dropDownItem) {
            locltypelist.add(dropDownItem);
          });
          setState(() {});
        });
      }
    });
  }

  Future dropdownGender() async {
    genderlist = [];
    LabourDb.instance.initializedatabase().then((status) {
      if (status) {
        LabourDb.instance.getGender(localecode, context).then((listMap) {
          listMap.map((map) {
            log(map.toString());
            return getGenderDropDownWidget(map);
          }).forEach((dropDownItem) {
            genderlist.add(dropDownItem);
          });
          setState(() {});
        });
      }
    });
  }

  Future dropdownlocalbodies() async {
    loclbdslist = [];
    LabourDb.instance.initializedatabase().then((status) {
      if (status) {
        LabourDb.instance
            .getLocalbodies(districtId, localtypeId, localecode, context)
            .then((listMap) {
          listMap.map((map) {
            log(map.toString());
            return getLocalbdyDropDownWidget(map);
          }).forEach((dropDownItem) {
            loclbdslist!.add(dropDownItem);
          });
          setState(() {});
        });
      }
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenLogin(
          category: widget.category,
        ),
      ),
    );
    return true;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Stack(
      key: _scaffoldKey,
      children: [
        const Screensbackground(),
        PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            if (!didPop) {
              if (didPop) return;
              await popscreen(context);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ScreenLogin(
                              category: widget.category,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: const Color.fromARGB(255, 158, 89, 248)),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.signuphd,
                        style: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.bold,
                          fontSize: L10n.getsignupFontSize(locale.languageCode),
                          color: const Color.fromARGB(255, 158, 89, 248),
                        ),
                        textScaler: TextScaler.noScaling,

                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.createfree,
                        style: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.bold,
                          fontSize: L10n.getbuttonFontSize(locale.languageCode),
                          color: const Color.fromARGB(255, 47, 3, 100),
                        ),
                  textScaler: TextScaler.noScaling,

                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //SizedBox(height:SizeConfig.screenHeight*0.05),
                  Expanded(
                    child: Scrollablewidget(child: registerationForm()),
                  )
                ])),
          ),
        ),
      ],
    );
  }

  Widget registerationForm() {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /*name */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: TextFormField(
                controller: _namecontroller,
                onSaved: (newValue) => name = newValue,

                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your Name";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black),
                //style:kBodyText,
                //textCapitalization: TextCapitalization.characters,

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
                  labelText: AppLocalizations.of(context)!.name,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
              ),
            ),
          ),
          /* ************* */

          /* Address */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: TextFormField(
                controller: _addresscontroller,
                keyboardType: TextInputType.text,
                //style:kBodyText,
                maxLength: 25,
                onSaved: (newValue) => address = newValue,
                // onChanged: (value) {
                //   if(value.isNotEmpty){
                //     removeError(error: kAddressNullError);
                //   }
                //   return ;
                // },

                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your Address";
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.black),
                //textCapitalization: TextCapitalization.characters,
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
                  labelText: AppLocalizations.of(context)!.address,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
              ),
            ),
          ),
          /* ************* */

          /* Place */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: TextFormField(
                controller: _placecontroller,
                keyboardType: TextInputType.name,
                //style:kBodyText,
                onSaved: (newValue) => place = newValue,
                // onChanged: (value) {
                //   if(value.isNotEmpty){
                //     removeError(error: kPlaceNullError);
                //   }
                //   return ;
                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your place";
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.black),
                //textCapitalization: TextCapitalization.characters,
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
                  labelText: AppLocalizations.of(context)!.place,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
              ),
            ),
          ),
          /* ************* */

          /* Post */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: TextFormField(
                controller: _postcontroller,
                keyboardType: TextInputType.name,
                //style:kBodyText,
                onSaved: (newValue) => post = newValue,
                // onChanged: (value) {
                //   if(value.isNotEmpty){
                //     removeError(error: kPostNullError);
                //   }
                //   return ;
                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your post";
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.black),
                //textCapitalization: TextCapitalization.characters,
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
                  labelText: AppLocalizations.of(context)!.post,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
              ),
            ),
          ),
          /* ************* */

          /* PIN code */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: TextFormField(
                controller: _pincodecontroller,
                keyboardType: TextInputType.number,
                //style:kBodyText,

                onSaved: (newValue) => pincode = newValue,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kPINCodeNullError);
                  } else if (pincode!.length == 6) {
                    removeError(error: kPINCodeValidError);
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter PIN number";
                  } else if (_pincodecontroller.text.length < 6 ||
                      _pincodecontroller.text.length > 6) {
                    return "Enter valid PIN number";
                  } else if (value.contains(' ')) {
                    showSnackBar(context,
                        text: "Remove Space from  PIN number");
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.black),
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
                  labelText: AppLocalizations.of(context)!.pin,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
              ),
            ),
          ),
          /* ************* */

          /* Sex */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: DropdownButtonFormField(
                isExpanded: true,
                //onSaved: (newValue) =>sex=newValue,
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
                  labelText: AppLocalizations.of(context)!.gender,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
                items: genderlist,
                // xlist.map((e){
                //   return DropdownMenuItem(
                //    value: e,
                //    child:Text(e));
                // }).toList(),
                onChanged: (newvalue) async {
                  setState(() {
                    dropdownxvalue = newvalue;
                  });
                  final genderIdval = await LabourDb.instance
                      .getGenderId(dropdownxvalue, localecode, context);

                  for (var map in genderIdval) {
                    final gender = GenderIdmodel.fromMap(map);
                    setState(() {
                      genderId = gender.id;
                      log('$genderId');
                    });
                  }
                  if (newvalue!.isNotEmpty) {
                    removeError(error: kSexNullError);
                  }
                  return;
                },
                validator: (value) {
                  if (value == null) {
                    addError(error: kSexNullError);
                    return "";
                  }
                  return null;
                },
                value: dropdownxvalue,
              ),
            ),
          ),
          /* ************* */

          /* District */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: DropdownButtonFormField(
                isExpanded: true,
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
                  labelText: AppLocalizations.of(context)!.district,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
                items: distlist,
                // districtlist.map((e){
                //   return DropdownMenuItem(
                //    value: e,
                //    child:Text(e));
                // }).toList(),

                //onSaved: (newValue) =>district=newValue,

                onChanged: (newvalue) async {
                  setState(() {
                    dropdowndistvalue = newvalue;
                    dropdownblockvalue = null;
                    dropdownlocalvalue = null;
                  });

                  final districtIdval = await LabourDb.instance
                      .getDistrictId(dropdowndistvalue, localecode, context);

                  for (var map in districtIdval) {
                    final distval = DistricIdmodel.fromMap(map);
                    setState(() {
                      districtId = distval.id;
                      log('$districtId');
                    });
                  }
                  dropdownLocalType();
                  if (newvalue!.isNotEmpty) {
                    removeError(error: kDistrictNullError);
                  }
                  return;
                },
                validator: (value) {
                  if (value == null) {
                    addError(error: kDistrictNullError);
                    return "";
                  }
                  return null;
                },

                value: dropdowndistvalue,
              ),
            ),
          ),
          /* ************* */

          /*searchDistrict */

          //         SizedBox(
          //   width:MediaQuery.of(context).size.width,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 50.0),
          //     child: SearchField(
          //       // style:const TextStyle(color:Colors.black),
          //       // dropdownColor: Colors.white,
          //       //     icon:const Icon(
          //       //       Icons.arrow_drop_down,
          //       //       color: Color.fromARGB(255, 101, 47, 248),
          //       //     ),
          //        searchInputDecoration:const InputDecoration(
          //         contentPadding: EdgeInsets.symmetric(horizontal: 25),
          //         focusedBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.all(Radius.circular(25)),
          //                       borderSide: BorderSide(
          //                         color: Color.fromARGB(255, 158, 89, 248),
          //                         width:1,
          //                       ),
          //                     ) ,
          //                     border:OutlineInputBorder(
          //                       borderRadius: BorderRadius.all(Radius.circular(25)),
          //                         borderSide: BorderSide(
          //                           color:Color.fromARGB(255, 158, 89, 248),
          //                           width:1,
          //                         )
          //                       ),
          //                     enabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.all(Radius.circular(25)),
          //                       borderSide: BorderSide(
          //                         color: Color.fromARGB(255, 158, 89, 248),
          //                         width:1,
          //                       ),
          //                     ),
          //         labelText:  "District*",
          //                     labelStyle: TextStyle(color: Color.fromARGB(255, 101, 47, 248)),

          //     ),
          //     suggestions: distlistval,
          //     // districtlist.map((e){
          //     //   return DropdownMenuItem(
          //     //    value: e,
          //     //    child:Text(e));
          //     // }).toList(),

          //     //onSaved: (newValue) =>district=newValue,

          //     onChanged: (newvalue)async{
          //       setState(() {
          //         dropdowndistvalue=newvalue;
          //         dropdownblockvalue=null;
          //         dropdownlocalvalue=null;
          //       });

          //       final districtIdval=await LabourDb.instance.getDistrictId(dropdowndistvalue);

          //          for(var map in districtIdval){
          //                     final distval=DistricIdmodel.fromMap(map);
          //                     setState(() {
          //                       districtId=distval.id;
          //                       print(districtId);
          //                     });

          //          }
          //         dropdownLocalType();
          //        if(newvalue!.isNotEmpty){
          //       removeError(error: kDistrictNullError);
          //           }
          //       return;
          //     },
          //     validator: (value){
          //        if(value==null){
          //          addError(error: kDistrictNullError);
          //           return "";
          //          }
          //        return null;

          //      },

          //     value:dropdowndistvalue,
          //   ),
          // ),
          //  ),
          /* *********************** */

          /* localbodytype */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: DropdownButtonFormField(
                isExpanded: true,
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
                  labelText: AppLocalizations.of(context)!.localtype,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
                items: locltypelist,
                // blocklist.map((e){
                //   return DropdownMenuItem(
                //    value: e,
                //    child:Text(e));
                // }).toList(),
                // onSaved: (newValue) =>block=newValue,

                onChanged: (newvalue) async {
                  setState(() {
                    dropdownblockvalue = newvalue;
                    dropdownlocalvalue = null;
                  });

                  final typeIdval = await LabourDb.instance.getLocalbdytypeId(
                      dropdownblockvalue, localecode, context);

                  for (var map in typeIdval) {
                    final typeval = LocaltypeIdmodel.fromMap(map);
                    setState(() {
                      localtypeId = typeval.id;
                      log('$localtypeId');
                    });
                  }
                  // print(localtypeId);

                  dropdownlocalbodies();

                  if (newvalue!.isNotEmpty) {
                    removeError(error: kBlockNullError);
                  }
                  return;
                },
                validator: (value) {
                  if (value == null) {
                    addError(error: kBlockNullError);
                    return "";
                  }
                  return null;
                },
                value: dropdownblockvalue,
              ),
            ),
          ),
          /* ************* */

          /* localbodyname */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: DropdownButtonFormField(
                isExpanded: true,
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
                  labelText: AppLocalizations.of(context)!.localname,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),

                items: loclbdslist,
                // localbodylist.map((e){
                //   return DropdownMenuItem(
                //    value: e,
                //    child:Text(e));
                // }).toList(),
                // onSaved: (newValue) =>localbody=newValue,
                onChanged: (newvalue) async {
                  setState(() {
                    dropdownlocalvalue = newvalue;
                  });

                  final localbdyIdval = await LabourDb.instance.getLocalbodyId(
                      districtId,
                      localtypeId,
                      dropdownlocalvalue,
                      localecode,
                      context);

                  for (var map in localbdyIdval) {
                    final bdynameval = LocalbdyIdmodel.fromMap(map);
                    setState(() {
                      localbdynameId = bdynameval.id;
                      log('loclbodyId:$localbdynameId');
                    });
                  }

                  if (newvalue!.isNotEmpty) {
                    removeError(error: kLocalbodyNullError);
                  }
                  return;
                },
                validator: (value) {
                  if (value == null) {
                    addError(error: kLocalbodyNullError);
                    return "";
                  }
                  return null;
                },
                value: dropdownlocalvalue,
              ),
            ),
          ),
          /* ************* */

          /* Dob */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: GestureDetector(
                onTap: () => _selectedDOB(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dobcontroller,
                    keyboardType: TextInputType
                        .text, // Switch to "text" to allow "/" character
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9/]')), // Allow numbers and "/"
                    ],
                    style: const TextStyle(color: Colors.black),

                    onSaved: (newValue) => dob = newValue,
                    // onChanged: (value) {
                    //   if(value.isNotEmpty){
                    //     removeError(error: kDobNullError);
                    //   }
                    //   return ;
                    // },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter date of birth";
                      }
                      return null;
                      // else if(_passwordcontroller.text.length < 8){
                      //   return "Password Length should be more than 8 characters";
                      // }
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 25),
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
                        labelText: AppLocalizations.of(context)!.dob,
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 101, 47, 248)),
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          color: Color.fromARGB(255, 101, 47, 248),
                        )),
                  ),
                ),
              ),
            ),
          ),
          /* ************* */

          /* AdhaarNO */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: TextFormField(
                controller: _adhaarnocontroller,
                keyboardType: TextInputType.number,
                //style:kBodyText,
                style: const TextStyle(color: Colors.black),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(12),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onSaved: (newValue) => adhaarno = newValue,
                // onChanged: (value) {
                //   // if(value.isNotEmpty){
                //   //   removeError(error: kAdhaarNullError);
                //   // }else if(adhaarno!.length==12){
                //   //   removeError(error: kValidAdhaarError);
                //   // }
                //   if(_adhaarnocontroller.text.length < 12 || _adhaarnocontroller.text.length > 12){
                //   return "Enter valid Aadhaar Number";
                // }

                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Aadhaar Number";
                  } else if (_adhaarnocontroller.text.length < 12 ||
                      _adhaarnocontroller.text.length > 12) {
                    return "Enter valid Aadhaar Number";
                  } else if (value.contains(' ')) {
                    showSnackBar(context,
                        text: "Remove Space from  Aadhaar number");
                  }
                  return null;
                },

                //textCapitalization: TextCapitalization.characters,
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
                  labelText: AppLocalizations.of(context)!.adhaar,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
              ),
            ),
          ),
          /* ************* */

          /*education feild only visible for employer registration */
          Visibility(
            visible: isVisible,
            child: buildeductionfield(),
          ),
          /* ************* */

          /* MobileNo */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: TextFormField(
                controller: _mobilenocontroller,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.black),
                // style:kBodyText,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onSaved: (newValue) => mobile = newValue,
                // onChanged: (value) {
                //   if(value.isNotEmpty){
                //     removeError(error: kMobileNullError);
                //   }else if(mobile!.length==10){
                //     removeError(error: kValidMobileError);
                //   }

                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter mobile Number";
                  } else if (_mobilenocontroller.text.length < 10 ||
                      _mobilenocontroller.text.length > 10) {
                    return "Enter valid Mobile number";
                  } else if (value.contains(' ')) {
                    showSnackBar(context,
                        text: "Remove Space from  Mobile number");
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
                  textScaler: TextScaler.noScaling,
                          
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
                  labelText: AppLocalizations.of(context)!.mob,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                ),
              ),
            ),
          ),
          /* ************* */

          /* Password */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: TextFormField(
                // maxLines: 1,
                // maxLength: 10,
                controller: _passwordcontroller,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                //style:kBodyText,
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
                  labelText: AppLocalizations.of(context)!.pswrd,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.lock,
                        color: Color.fromARGB(255, 101, 47, 248)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passtoggle = !passtoggle;
                      });
                    },
                    child: Icon(
                      passtoggle ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromARGB(255, 101, 47, 248),
                    ),
                  ),
                ),
                obscureText: passtoggle,
                textInputAction: TextInputAction.done,

                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Password";
                  } else if (_passwordcontroller.text.length < 8) {
                    return "Please Enter more than 8 characters";
                  } else if (_passwordcontroller.text.contains(' ')) {
                    return "Remove space from password";
                  }
                  return null;
                },
                // onChanged: (String value){
                //   if(value.length>9){
                //     mobileNo=value;
                //   }
                // },
              ),
            ),
          ),

          /* ************* */

          /* Confirm Password */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              child: TextFormField(
                // maxLines: 1,
                // maxLength: 10,
                controller: _cnfrmpasswordcontroller,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                // style:kBodyText,
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
                  labelText: AppLocalizations.of(context)!.cnfmpswd,
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.lock,
                        color: Color.fromARGB(255, 101, 47, 248)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        cnfrmpasstoggle = !cnfrmpasstoggle;
                      });
                    },
                    child: Icon(
                      cnfrmpasstoggle ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromARGB(255, 101, 47, 248),
                    ),
                  ),
                ),
                obscureText: cnfrmpasstoggle,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please re enter password";
                  } else if (value != _passwordcontroller.text) {
                    return "Password mismatch";
                  }
                  return null;
                },

                // onChanged: (String value){
                //   if(value.length>9){
                //     mobileNo=value;
                //   }
                // },
              ),
            ),
          ),

          /* ************* */

          buildTandC(context),

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
          /* Signup Button */
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
            child: ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    var pro = context.read<SignupProvider>();
                    final value = pro.isAccepted;
                    //goto otp screen
                    if (value == true) {
                      await buildcreatelabour(context);
                    } else {
                      if (!context.mounted) return;

                      await showDialogcheckbox(context);
                    }
                    // Navigator.of(context).pushReplacement(
                    //                           MaterialPageRoute(
                    //                             builder: (ctx) =>  ScreenOtpverify(category: widget.category,),
                    //                           ),
                    //                         );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                    fixedSize: const Size(200, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  AppLocalizations.of(context)!.signupbtn,
                  style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: L10n.getHeadFontSize(locale.languageCode),
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  textScaler: TextScaler.noScaling,

                )),
          ),
          /* ************* */

          /* Login Button */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.alreadyac,
                    style: kBodyText,
                  textScaler: TextScaler.noScaling,

                  ),
                ),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: const TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 20,
                      color: Appcolors.labelclr,
                    ),
                  textScaler: TextScaler.noScaling,

                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => ScreenLogin(
                          category: widget.category,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          /* ************* */

          // SizedBox(
          //         width:MediaQuery.of(context).size.width,
          //           child:const Text("By continuing your SingUp that you agree",style: kBodyText,
          //               textAlign: TextAlign.center,),
          //       ),

          /* Term and condition Button */
          // SizedBox(
          //         //height:5,
          //         width:MediaQuery.of(context).size.width,
          //          child:Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //            children: [
          //              const Text("with our",style: kBodyText,
          //               textAlign: TextAlign.center,),
          //               TextButton(
          //               child: const Text("Term and Condition",style:TextStyle(
          //                           fontFamily: 'Oswald',
          //                           fontSize: 18,
          //                           color: Colors.blue,
          //                         ),),
          //              onPressed: (){},),
          //            ],
          //          )
          //       ),
          /* ************* */
        ],
      ),
    );
  }

  /* Eductional feild */
  SizedBox buildeductionfield() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
        child: DropdownButtonFormField(
                isExpanded: true,
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
            labelText: AppLocalizations.of(context)!.edu,
            labelStyle:
                const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
          ),
          items: edulist,
          // edulist.map((e){
          //   return DropdownMenuItem(
          //    value: e,
          //    child:Text(e));
          // }).toList(),

          // onSaved: (newValue) =>education=newValue,

          onChanged: (newvalue) async {
            setState(() {
              dropdownEduvalue = newvalue;
            });
            final eduIdval = await LabourDb.instance
                .getEduId(dropdownEduvalue, localecode, context);

            for (var map in eduIdval) {
              final eduval = EduIdmodel.fromMap(map);
              setState(() {
                eduId = eduval.id;
                log('$eduId');
              });
            }
            if (newvalue!.isNotEmpty) {
              removeError(error: kEducationNullError);
            }
            return;
          },
          validator: (value) {
            if (value == null) {
              addError(error: kEducationNullError);
              return "";
            }
            return null;
          },
          value: dropdownEduvalue,
        ),
      ),
    );
  }
  /* ************* */

  @override
  void dispose() {
    super.dispose();
  }

  /* Dob datepick funcion */
  _selectedDOB(BuildContext context) async {
    final DateTime? selectedfromdatepick = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 365 * 100),
      ),
      lastDate: DateTime.now(),
      keyboardType:
          TextInputType.text, // Switch to "text" to allow "/" character
      fieldHintText: 'dd/mm/yyyy',
      locale: localecode,

      // locale: localecode==const Locale('en')?const Locale('en', 'GB'):const Locale('ml', 'GB'),
    );
    if (selectedfromdatepick == null) {
      return;
    } else {
      log(selectedfromdatepick.toString());
      setState(() {
        selectedDob = selectedfromdatepick;
        var formattedDate =
            DateFormat('dd/MM/yyyy').format(selectedfromdatepick);

        _dobcontroller.text = formattedDate;
        // var date =
        //     "${selectedfromdatepick.toLocal().day}-${selectedfromdatepick.toLocal().month}-${selectedfromdatepick.toLocal().year}";
        // _dobcontroller.text = date;
        log(formattedDate);
      });
    }
  }
  /* ************* */

  /* register category function */
  Future buildcreatelabour(BuildContext context) async {
    final loadingProvider=context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final name = _namecontroller.text;
    final address = _addresscontroller.text;
    final place = _placecontroller.text;
    final post = _postcontroller.text;
    final pincode = _pincodecontroller.text;
    final dob = _dobcontroller.text;
    final adhaarno = _adhaarnocontroller.text;
    final mobile = _mobilenocontroller.text;
    final password = _passwordcontroller.text;
    final cnfrmpswrd = _cnfrmpasswordcontroller.text;

    DateTime dobdt = DateFormat("dd/MM/yyyy").parse(dob);
    DateFormat dateFormat1 = DateFormat("yyyy-MM-dd");
    String birthdt = dateFormat1.format(dobdt);
    if (adhaarno.isEmpty) {
      setState(() {
        adhaarno == '';
      });
    }

    final createreq = Createlabreq.req(
        name: name,
        address: address,
        place: place,
        post: post,
        pin: pincode,
        genderId: genderId,
        districtId: districtId,
        blockId: localtypeId,
        localbodyId: localbdynameId,
        dob: birthdt,
        aadhaar: adhaarno,
        mobile: mobile,
        educationId: eduId,
        category: widget.category,
        password: password,
        cPassword: cnfrmpswrd);

    if (widget.category == 1) {
      final createlabrespval = await Labourdata().createlabour(createreq);
    loadingProvider.toggleLoading();

      if (createlabrespval == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (createlabrespval.statusCode == 200) {
        final resultAsjson = jsonDecode(createlabrespval.data);
        if (!context.mounted) return;
        buildlabour(resultAsjson, context);
      } else if (createlabrespval.statusCode == 404) {
        if (!context.mounted) return;

        await showDialogError(context);
      } else if (createlabrespval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (createlabrespval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } else {
      final createlabrespval = await Labourdata().createemp(createreq);
    loadingProvider.toggleLoading();

      if (createlabrespval == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (createlabrespval.statusCode == 200) {
        final resultAsjson = jsonDecode(createlabrespval.data);
        if (!context.mounted) return;

        buildlabour(resultAsjson, context);
      } else if (createlabrespval.statusCode == 404) {
        if (!context.mounted) return;

        await showDialogError(context);
      } else if (createlabrespval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (createlabrespval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
  }

  /* ************************************* */

  Future buildlabour(dynamic createusrvalue, BuildContext context) async {
    final address = _addresscontroller.text;
    final place = _placecontroller.text;
    final post = _postcontroller.text;
    final pincode = _pincodecontroller.text;
    final gender = dropdownxvalue;
    final district = dropdowndistvalue;
    final localtype = dropdownblockvalue;
    final localbody = dropdownlocalvalue;
    final dob = _dobcontroller.text;
    final adhaarno = _adhaarnocontroller.text;
    final education = dropdownEduvalue;
    final cnfrmpswrd = _cnfrmpasswordcontroller.text;

    final registerval =
        Createlabresp.fromJson(createusrvalue as Map<String, dynamic>);
    status = registerval.success;
    message = registerval.message;
    DateTime dobdt = DateFormat("dd/MM/yyyy").parse(dob);
    DateFormat dateFormat1 = DateFormat("yyyy-MM-dd");
    String birthdt = dateFormat1.format(dobdt);
    if (status == true) {
      final token = registerval.data!.token;
      final name = registerval.data!.name;
      mobileNo = registerval.data!.mobile;
      if (widget.category == 1) {
        userId = registerval.data!.userId;
      } else {
        userId = registerval.data!.empId;
      }

      catval = widget.category;
      final sharedval = SharedtokenM.values(
          userid: userId,
          token: token,
          name: name,
          mobile: mobileNo,
          address: address,
          place: place,
          post: post,
          pin: pincode,
          gender: gender,
          genderId: genderId,
          district: district,
          distId: districtId,
          block: localtype,
          blockId: localtypeId,
          localbody: localbody,
          localbodyId: localbdynameId,
          dob: birthdt,
          aadhaar: adhaarno,
          education: education,
          educationId: eduId,
          category: catval,
          password: cnfrmpswrd);
      //set data into shared preference
      await Sharedata.instance.setdata(sharedval);
      /* ************* */

      message = registerval.message;
      if (!context.mounted) return;

      await showDialogsuccess(context, mobileNo, catval);
    } else {
      if (!context.mounted) return;
      await showDialogfail(context, message);
    }
  }

  Future showDialogsuccess(
          BuildContext? context, String? mobile, int? catrslt) async =>
      showDialog(
          barrierDismissible: false,
          context: context!,
          builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.vrfyotp,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 2, 129, 6),
                          fontFamily: 'RobotoSerif_28pt-Medium'),
                          textScaler: TextScaler.noScaling,),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          log('$catrslt');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => Screenotpvfy(
                                mobileNo: mobile,
                                category: catrslt,
                                pending: otpvrfy,
                              ),
                            ),
                          );
                        },
                        child: const Center(child: Text('OK',textScaler: TextScaler.noScaling,))),
                  ]));

  Future showDialogfail(BuildContext? context, String? message) async => showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (context) => AlertDialog(
              title: Text(message!,textScaler: TextScaler.noScaling,),
              // const Text(
              //   "Already Registered MobileNo \n Please Enter valid MobileNo",
              //   style:
              //   TextStyle(
              //     color:Color.fromARGB(255, 241, 26, 10),
              //     fontFamily: 'RobotoSerif_28pt-Medium')),
              actions: [
                ElevatedButton(
                    onPressed: () =>
                        // Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //         builder: (ctx) => ScreenRegister(
                        //           category: widget.category,
                        //         ),
                        //       ),
                        //     ),
                        Navigator.of(context).pop(),
                    child: const Center(child: Text('OK',textScaler: TextScaler.noScaling,))),
              ]));

  Future showDialogError(BuildContext? context) async => showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (context) => AlertDialog(
              title: const Text('No Data Found',
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 26, 10),
                      fontFamily: 'RobotoSerif_28pt-Medium'),
                  textScaler: TextScaler.noScaling,
                      ),
              actions: [
                ElevatedButton(
                    onPressed: () =>
                        // Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //         builder: (ctx) => ScreenRegister(
                        //           category: widget.category,
                        //         ),
                        //       ),
                        //     ),
                        Navigator.of(context).pop(),
                    child: const Center(child: Text('OK',textScaler: TextScaler.noScaling,))),
              ]));

  Widget buildTandC(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ScreenEmpTandC(
                    category: widget.category,
                  ),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(
                      unselectedWidgetColor:
                          const Color.fromARGB(255, 101, 47, 248)),
                  child: Consumer<SignupProvider>(
                    builder: (context, check, _) => Checkbox(
                        value: check.isAccepted,
                        checkColor: const Color.fromARGB(255, 101, 47, 248),
                        activeColor: Colors.white,
                        onChanged: (value) {
                          log('$value');
                          check.setAccepted(value!);
                          Navigator.of(_scaffoldKey.currentContext!).push(
                            MaterialPageRoute(
                              builder: (ctx) => ScreenEmpTandC(
                                category: widget.category,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Expanded(
                    child: Text(
                  AppLocalizations.of(context)!.accepttc,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                  textScaler: TextScaler.noScaling,

                ))
              ],
            ),
          )),
    );
  }

  Future showDialogcheckbox(BuildContext? context) async => showDialog(
      context: context!,
      builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.readtc,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontFamily: 'RobotoSerif_28pt-Medium'),
                  textScaler: TextScaler.noScaling,
                      ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Center(child: Text('OK',
                  textScaler: TextScaler.noScaling,
                    ))),
              ]));
}
