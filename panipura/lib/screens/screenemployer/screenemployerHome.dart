
import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/functions/laborfn.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/model/searchlabour/searchlabourmdl/searchlabourmdl.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:panipura/widgets/navbar.dart';
import '../../database/labourdb.dart';
import '../../model/category/categorymdl.dart';
import '../../model/dropdownId/districtIdmodel.dart';
import '../../model/dropdownId/localbdyIdmodel.dart';
import '../../model/dropdownId/localtypeIdmodel.dart';
import '../../widgets/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';

class ScreenEmployerHome extends StatefulWidget {
  const ScreenEmployerHome({super.key});

  @override
  State<ScreenEmployerHome> createState() => _ScreenEmployerHomeState();
}

class _ScreenEmployerHomeState extends State<ScreenEmployerHome> {
  final _formkey2 = GlobalKey<FormState>();
  String? name;

  String? dropdownxvalue;
  String? dropdownskillvalue;
  String? dropdowndistvalue;
  String? dropdownblockvalue;
  String? dropdownlocalvalue;
  String? dropdownsexpvalue;
  String? dropdowncategoryvalue;
  int? categoryId;
  int? genderId;
  int? districtId;
  int? localtypeId;
  int? localbdynameId;
  int? skillId;
  String? gender;
  List<String> experiencelist = [];
  late List<DropdownMenuItem<String>> distlist;
  late List<DropdownMenuItem<String>> skilllist;
  late List<DropdownMenuItem<String>> locltypelist;
  late List<DropdownMenuItem<String>> genderlist;
  late List<DropdownMenuItem<String>> explist;
  List<DropdownMenuItem<String>>? loclbdslist;
  late List<DropdownMenuItem<String>> catelist;
  final List<String> errors = [];
  String? dropdownexperiencevalue;
  Locale? localecode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();
    });
    getUsername();
    dropdowndistrict();
    // dropdownEducation();
    dropdownLocalType();
    dropdownGender();
    dropdowncategory();
  }

  // final experiencelist = [
  //   'Below 1',
  //   '1',
  //   '2',
  //   '3',
  //   '4',
  //   '5',
  //   '6',
  //   '7',
  //   '8',
  //   '9',
  //   '10',
  //   'Above 10',
  // ];

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  void getUsername() async {
    final value = await Sharedata.instance.getdata();
    // final _sharedprefs = await SharedPreferences.getInstance();
    // bool CheckValue = _sharedprefs.containsKey('USERNAME');
    // print(CheckValue);
    final username = value!.name;
    gender = value.gender;
    genderId = value.genderId;
    setState(() {
      if (genderId == 1) {
        name = "Mr. $username";
        name = name!.toUpperCase();
      } else {
        name = "Ms. $username";
        name = name!.toUpperCase();
      }
    });
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
        child: Text(map['name_ml'], overflow: TextOverflow.ellipsis),
      );
    } else {
      return DropdownMenuItem<String>(
        value: map['name'],
        child: Text(map['name'], overflow: TextOverflow.ellipsis),
      );
    }
  }

  DropdownMenuItem<String> getEduDropDownWidget(Map<String, dynamic> map) {
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

  DropdownMenuItem<String> getTypeDropDownWidget(Map<String, dynamic> map) {
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

  DropdownMenuItem<String> getGenderDropDownWidget(Map<String, dynamic> map) {
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

  DropdownMenuItem<String> getCategoryDropDownWidget(Map<String, dynamic> map) {
    if (localecode == Locale('ml')) {
      return DropdownMenuItem<String>(
        value: map['name_ml'],
        child: Text(map['name_ml'],maxLines: 5, overflow: TextOverflow.ellipsis),
      );
    } else {
      return DropdownMenuItem<String>(
        value: map['name'],
        child: Text(map['name'],maxLines: 5, overflow: TextOverflow.ellipsis),
      );
    }
  }

  Future dropdowncategory() async {
    catelist = [];
    LabourDb.instance.initializedatabase().then((status) {
      if (status) {
        LabourDb.instance.getOccupations(localecode).then((listMap) {
          listMap.map((map) {
            log(map.toString());
            return getCategoryDropDownWidget(map);
          }).forEach((dropDownItem) {
            catelist.add(dropDownItem);
          });
          setState(() {});
        });
      }
    });
  }

  Future dropdowndistrict() async {
    distlist = [];
    LabourDb.instance.initializedatabase().then((status) {
      if (status) {
        LabourDb.instance.getDistrict(localecode).then((listMap) {
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

  // Future dropdownEducation() async{
  //         skilllist=[];
  //    LabourDb.instance.initializedatabase().then((status){
  //     if(status){
  //       LabourDb.instance.getEducation().then((listMap) {
  //         listMap.map((map){
  //           print(map.toString());
  //           return getEduDropDownWidget(map);
  //         }).forEach((dropDownItem) {
  //           skilllist.add(dropDownItem);
  //          });
  //          setState(() {

  //          });
  //       });
  //     }
  //    });
  // }

  Future dropdownLocalType() async {
    locltypelist = [];
    LabourDb.instance.initializedatabase().then((status) {
      if (status) {
        LabourDb.instance.getLocalbodyType(localecode).then((listMap) {
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
        LabourDb.instance.getGender(localecode).then((listMap) {
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
            .getLocalbodies(districtId, localtypeId, localecode)
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime timeBackPressed = DateTime.now();

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
        PopScope(        
          canPop: false,
          onPopInvoked: (bool didPop) async {
            if (!didPop){
              if (didPop) return;
               await warningBox(context);
            
            } 
             log('BackButton pressed!');
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: const Navbar(
              category: emp,
            ),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                iconTheme: const IconThemeData(color: Appcolors.magenta),
                // leading:IconButton(onPressed: (){}, icon:const Icon(Icons.menu,color:Color.fromARGB(255, 158, 89, 248))),
                actions: [
                  IconButton(
                      onPressed: () {
                        warningBox(context);
                        //signout(context);
                      },
                      icon: const Icon(Icons.exit_to_app,
                          color: Appcolors.magenta))
                ],
                // leading:  IconButton(
                //       onPressed: () {
                //         warningBox(context);
                //         //signout(context);
                //       },
                //       icon: const Icon(Icons.exit_to_app,
                //           color: Appcolors.magenta)),
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.buttonemployer,
                  style: L10n.getappbarSize(locale.languageCode),
                ),
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
                children: [
                  Container(
                    color: const Color(0xfff3f3f3),
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Text(
                                      "${AppLocalizations.of(context)!.wel} $name,",
                                      style: kbodyfont),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          labourSearchForm()
                          //  const Padding(
                          //    padding: EdgeInsets.all(20.0),
                          //    child: Gridlabview(),
                          //  ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget labourSearchForm() {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Form(
        key: _formkey2,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.searchlab,
                  style: L10n.getappbarSize(locale.languageCode),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            /* occupations */
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: DropdownButtonFormField(
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
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
                        color: Color.fromARGB(255, 101, 47, 248)),
                  ),
                  items: catelist,
                  // districtlist.map((e){
                  //   return DropdownMenuItem(
                  //    value: e,
                  //    child:Text(e));
                  // }).toList(),

                  //onSaved: (newValue) =>district=newValue,
                  onChanged: (newvalue) async {
                    setState(() {
                      dropdowncategoryvalue = newvalue;
                    });

                    final occupationIdval = await LabourDb.instance
                        .getOccupationsId(dropdowncategoryvalue, localecode);

                    for (var map in occupationIdval) {
                      final catval = CategoryIdmodel.fromMap(map);
                      setState(() {
                        categoryId = catval.id;
                        log('$categoryId');
                      });
                    }
                    //dropdownLocalType();
                    if (newvalue!.isNotEmpty) {
                      removeError(error: kcategoryNullError);
                    }
                    return;
                  },
                  validator: (value) {
                    if (value == null) {
                      addError(error: kcategoryNullError);
                      return "";
                    }
                    return null;
                  },

                  value: dropdowncategoryvalue,
                ),
              ),
            ),
            /* ************* */
            /* District */
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: DropdownButtonFormField(
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
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
                    labelText: AppLocalizations.of(context)!.district,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 101, 47, 248)),
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
                        .getDistrictId(dropdowndistvalue, localecode);

                    for (var map in districtIdval) {
                      final distval = DistricIdmodel.fromMap(map);
                      setState(() {
                        districtId = distval.id;
                        log('$districtId');
                      });
                    }
                    dropdownLocalType();
                    //  if(newvalue!.isNotEmpty){
                    // removeError(error: kDistrictNullError);
                    //     }
                    // return;
                  },
                  // validator: (value){
                  //    if(value==null){
                  //      addError(error: kDistrictNullError);
                  //       return "";
                  //      }
                  //    return null;

                  //  },

                  value: dropdowndistvalue,
                ),
              ),
            ),
            /* ************* */

            /* localbodytype */
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: DropdownButtonFormField(
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
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
                    labelText: AppLocalizations.of(context)!.localtype,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 101, 47, 248)),
                  ),
                  items: locltypelist,
                  // blocklist.map((e){
                  //   return DropdownMenuItem(
                  //    value: e,
                  //    child:Text(e));
                  // }).toList(),
                  // onSaved: (newValue) =>block=newValue,

                  onChanged: (newvalue) async {
                    if (dropdowndistvalue == null) {
                    // Show SnackBar if district is not selected
                    ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(
                        content: Text('Please select district'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    //return;
                    }
                    setState(() {
                      dropdownblockvalue = newvalue;
                      dropdownlocalvalue = null;
                    });

                    final typeIdval = await LabourDb.instance
                        .getLocalbdytypeId(dropdownblockvalue, localecode);

                    for (var map in typeIdval) {
                      final typeval = LocaltypeIdmodel.fromMap(map);
                      setState(() {
                        localtypeId = typeval.id;
                        log('$localtypeId');
                      });
                    }
                    // print(localtypeId);

                    dropdownlocalbodies();

                    //  if(newvalue!.isNotEmpty){
                    // removeError(error: kBlockNullError);
                    //     }
                    // return;
                  },
                  // validator: (value){
                  //    if(value==null){
                  //      addError(error: kBlockNullError);
                  //       return "";
                  //      }
                  //    return null;

                  //  },
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
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: DropdownButtonFormField(
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
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
                    labelText: AppLocalizations.of(context)!.localname,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 101, 47, 248)),
                  ),

                  items: loclbdslist,
                  // localbodylist.map((e){
                  //   return DropdownMenuItem(
                  //    value: e,
                  //    child:Text(e));
                  // }).toList(),
                  // onSaved: (newValue) =>localbody=newValue,
                  onChanged: (newvalue) async {
                    // if (dropdowndistvalue == null && dropdownblockvalue==null ) {
                    // // Show SnackBar if district is not selected
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //  const SnackBar(
                    //     content: Text('Please select district and local body type'),
                    //     backgroundColor: Colors.red,
                    //   ),
                    // );
                    // return;
                    // }
                    setState(() {
                      dropdownlocalvalue = newvalue;
                    });

                    final localbdyIdval = await LabourDb.instance
                        .getLocalbodyId(dropdownlocalvalue, localecode);

                    for (var map in localbdyIdval) {
                      final bdynameval = LocalbdyIdmodel.fromMap(map);
                      setState(() {
                        localbdynameId = bdynameval.id;
                        log('$localbdynameId');
                      });
                    }

                    //  if(newvalue!.isNotEmpty){
                    // removeError(error: kLocalbodyNullError);
                    //     }
                    // return;
                  },
                  // validator: (value){
                  //    if(value==null){
                  //      addError(error: kLocalbodyNullError);
                  //       return "";
                  //      }
                  //    return null;

                  //  },
                  value: dropdownlocalvalue,
                ),
              ),
            ),
            /* ************* */

            /* Experience */

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: DropdownButtonFormField(
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                  //onSaved: (newValue) =>sex=newValue,
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
                    labelText: AppLocalizations.of(context)!.expemp,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 101, 47, 248)),
                  ),
                  items: experiencelist.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),

                  onChanged: (newvalue) {
                    setState(() {
                      dropdownexperiencevalue = newvalue;
                    });
                    // if(newvalue !.isNotEmpty){
                    //               removeError(error: kexperienceNullError);
                    //             }
                    //             return ;
                  },
                  //  validator: (value){
                  //               if(value==null){
                  //                 addError(error: kexperienceNullError);
                  //                 return "";
                  //               }
                  //               return null;
                  //             },
                  value: dropdownexperiencevalue,
                ),
              ),
            ),



            /* Signup Button */
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formkey2.currentState!.validate()) {
                      await buildlabsearch();
                    }
                    
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                      fixedSize: const Size(200, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    AppLocalizations.of(context)!.search,
                    style: L10n.getbuttonstyle(locale.languageCode),
                  )),
            ),
            /* ************************************ */
          ],
        ));
  }

  void signout(BuildContext ctx) async {
    // final sharedprefs = await SharedPreferences.getInstance();
    // await sharedprefs.clear();
    await Sharedata.instance.cleardata();
    Navigator.of(_scaffoldKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => const ScreenLogin(category: emp)),
        (route) => false);
  }

  Future buildlabsearch() async {
    final occupationid = categoryId;
    final distId = districtId;
    if (distId == null) {
      setState(() {
        distId == null;
      });
    }
    final localtypeid = localtypeId;
    if (localtypeid == null) {
      setState(() {
        localtypeid == null;
      });
    }
    final localbdyid = localbdynameId;
    if (localbdyid == null) {
      setState(() {
        localbdyid == null;
      });
    }
    final exp = dropdownexperiencevalue;
    if (exp == null) {
      setState(() {
        exp == null;
      });
    }

    //final value = await Sharedata.instance.getdata();
    //final userid=value!.userid;
    //final token=value.token;
    final searchreq = Searchlabourmdl(
      occupationId: occupationid,
      districtId: distId,
      lbTypeId: localtypeid,
      localbodyId: localbdyid,
      experience: exp,
      //userId: userid,
      //token:token
    );

    await Labempfn.instance
        .getsearchdata(searchreq, _scaffoldKey.currentContext);
  }

  /* ************************************* */

  Future warningBox(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Center(
                child: Text(AppLocalizations.of(context)!.signout,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 101, 47, 248)))),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ScreenEmployerHome(),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.no,
                    style: const TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () => signout(context),
                child: Text(AppLocalizations.of(context)!.yes,
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ));
}
