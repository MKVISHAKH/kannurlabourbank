import 'dart:developer';
import 'package:panipura/core/hooks/hook.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class LabourDbFunction {
  Future addDistrict(Districtmodel newDistrict);
  Future<int> deleteDistrict();
  Future<List<Map<String, dynamic>>> getDistrict(
      Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getDistrictId(
      String? name, Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getDistrictName(
      int? id, Locale? locale, BuildContext context);

  Future addEducation(Educationmodel newEducation);
  Future<int> deleteEducation();
  Future<List<Map<String, dynamic>>> getEducation(
      Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getEduId(
      String? name, Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getEduName(
      int? id, Locale? locale, BuildContext context);

  Future addLocalbodyType(Localbdytypemodel newLocalbdyType);
  Future<int> deleteLocalbodyType();
  Future<List<Map<String, dynamic>>> getLocalbodyType(
      Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getLocalbdytypeId(
      String? name, Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getLocalbdytypeName(
      int? id, Locale? locale, BuildContext context);

  Future addGenderType(Gendermodel newgenderType);
  Future<int> deleteGender();
  Future<List<Map<String, dynamic>>> getGender(
      Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getGenderId(
      String? name, Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getGenderName(
      int? id, Locale? locale, BuildContext context);

  Future addLocalbodies(Localbodiesmodel localbodyname);
  Future<int> deleteLocalbodies();
  Future<List<Map<String, dynamic>>> getLocalbodies(
      int? distid, int? typeid, Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getLocalbodyId(int? distid, int? typeid,
      String? name, Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getLocalbodyName(
      int? distid, int? typeid, int? id, Locale? locale, BuildContext context);

  Future addOccupations(Occupationmodel localbodyname);
  Future<int> deleteOccupations();
  Future<List<Map<String, dynamic>>> getOccupations(
      Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getOccupationsId(
      String? name, Locale? locale, BuildContext context);
  Future<List<Map<String, Object?>>> getOccupationsName(
      int? id, Locale? locale, BuildContext context);
  // Future addLocalbodyType(Districtmodel newDistrict);
}

class LabourDb implements LabourDbFunction {
  late Database _db;
  //static final LabourDb db=LabourD
  LabourDb._internal();
  static LabourDb instance = LabourDb._internal();
  factory LabourDb() {
    return instance;
  }

  Future<Database> get database async {
    //if(_db != null) return _db;
    _db = await initializeDB();
    return _db;
  }

  Future initializeDB() async {
    String path = await getDatabasesPath();
    final dbpath = join(path, 'masters.db');
    log(path);

    // _db=await openDatabase(
    //   return await openDatabase(
    //   dbpath, version:4, onOpen:(instance){},
    //   onCreate: _createDb,

    // );
    // _db=await openDatabase(
    return await openDatabase(
      dbpath,
      version: 4,
      onOpen: (instance) {},
    );

    // (await _db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;'))
    // .forEach((row) {
    //   print(row.values);
    //  });
    // final values=await _db.rawQuery('SELECT * FROM LOCALBODIES');
    // print(values);
    // final values=await _db.rawQuery('SELECT * FROM EDUCATION');
    // print(values);
  }

  // void _createDb(_db,int version) async {

  //      Batch batch = _db.batch();
  //      batch.execute("CREATE TABLE DISTRICT(district_id INTEGER PRIMARY KEY ,name TEXT NOT NULL)");

  //      batch.execute("CREATE TABLE EDUCATION(education_id INTEGER PRIMARY KEY ,name TEXT NOT NULL)");

  //      batch.execute("CREATE TABLE LOCALBODYTYPE(lb_type_id INTEGER PRIMARY KEY ,name TEXT NOT NULL)");

  //      batch.execute("CREATE TABLE LOCALBODIES(localbody_id INTEGER PRIMARY KEY ,lb_type_id INTEGER,district_id INTEGER,name TEXT NOT NULL)");

  //      batch.execute("CREATE TABLE GENDER(gender_id INTEGER PRIMARY KEY ,name TEXT NOT NULL)");

  //      batch.execute("CREATE TABLE OCCUPATIONS(occupation_id INTEGER PRIMARY KEY ,name TEXT NOT NULL)");

  //      List<dynamic> res= await batch.commit();
  //     //    await database.execute(
  //     //      "CREATE TABLE DISTRICT(district_id INTEGER PRIMARY KEY ,name TEXT NOT NULL)",
  //     // );

  //     // await database.execute(
  //     //      "CREATE TABLE LOCALBODYTYPE(type_id INTEGER PRIMARY KEY ,type_name TEXT NOT NULL)",
  //     // );

  //     // await database.execute(
  //     //      "CREATE TABLE EDUCATION(education_id INTEGER PRIMARY KEY ,name TEXT NOT NULL)",
  //     // );
  //    }

  Future<bool> initializedatabase() async {
    _db = await initializeDB();

    // var rows=await getDistrict();

    // if(rows.isEmpty){

    // }
    return _db.isOpen;
  }
  /* District table entry*/

  @override
  Future addDistrict(Districtmodel newDistrict) async {
    await deleteDistrict();
    final db = await database;
    try {
      final res = await db.insert('districts', newDistrict.toJson());
      log('inserted');
      return res;
    } catch (e) {
      log('Error inserting district: $e');
      return 0;
    }
  }

  @override
  Future<int> deleteDistrict() async {
    final db = await database;
    try {
      final res = await db.rawDelete('DELETE FROM districts');

      return res;
    } catch (e) {
      log('Error deleting districts: $e');
      return 0;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDistrict(
      Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      return await _db
          .rawQuery('SELECT $column FROM districts ORDER BY $column ASC');
    } catch (e) {
      log('Error fetching districts: $e');

      String? message;

      final distval = await Labourdata().district();
      final resultAsjson = jsonDecode(distval.toString());
      final loginval =
          FetchDistrict.fromJson(resultAsjson as Map<String, dynamic>);
      if (distval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (distval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final distlist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
        return distlist!.map((datum) => datum.toJson()).toList();

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || distval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (distval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (distval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }

    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db
  //       .rawQuery('SELECT name_ml FROM districts ORDER BY name_ml ASC');
  // } else {
  //   return await _db.rawQuery('SELECT name FROM districts ORDER BY name ASC');
  // }

  @override
  Future<List<Map<String, Object?>>> getDistrictId(
      String? name, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      final listid = await _db
          .rawQuery("SELECT district_id FROM districts WHERE $column='$name'");
      return listid;
    } catch (e) {
      log('Error fetching district ID: $e');
      String? message;

      final distval = await Labourdata().district();
      final resultAsjson = jsonDecode(distval.toString());
      final loginval =
          FetchDistrict.fromJson(resultAsjson as Map<String, dynamic>);
      if (distval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (distval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final distlist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
        final matchingDistrict = distlist!.firstWhere(
          (datum) => locale == Locale('ml')
              ? datum.nameMl == name // Match Malayalam name
              : datum.name == name, // Match default name
          // orElse: () => [], // Return null if no match
        );

        // Return the matching district ID
        //if (matchingDistrict!=null) {
        return [
          {'district_id': matchingDistrict.districtId}
        ];
        //  }

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || distval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (distval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (distval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }

    return [];
  }
  // if (locale == Locale('ml')) {
  //   final listid=await _db
  //       .rawQuery("SELECT district_id FROM districts WHERE name_ml='$name'");
  //   return listid;
  // } else {
  //   final listid=await _db
  //       .rawQuery("SELECT district_id FROM districts WHERE name='$name'");
  //   return listid;
  // }

  @override
  Future<List<Map<String, Object?>>> getDistrictName(
      int? id, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      final listid = await _db
          .rawQuery("SELECT $column FROM districts WHERE district_id='$id'");
      return listid;
    } catch (e) {
      log('Error fetching District Name: $e');
      String? message;

      final distval = await Labourdata().district();
      final resultAsjson = jsonDecode(distval.toString());
      final loginval =
          FetchDistrict.fromJson(resultAsjson as Map<String, dynamic>);
      if (distval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (distval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final distlist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
        final matchingDist = distlist!.firstWhere(
          (datum) => datum.districtId == id,
          //orElse: () => null,
        );

        final column = locale == Locale('ml') ? 'name_ml' : 'name';

        // Return the gender name based on locale
        return [
          {
            column:
                locale == Locale('ml') ? matchingDist.nameMl : matchingDist.name
          }
        ];

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || distval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (distval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (distval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db
  //       .rawQuery("SELECT name_ml FROM districts WHERE district_id='$id'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT name FROM districts WHERE district_id='$id'");
  // }
  /* ********************************************* */

  /* Education details entry */
  @override
  Future addEducation(Educationmodel newEducation) async {
    await deleteEducation();
    final db = await database;
    try {
      final res = await db.insert('educations', newEducation.toJson());
      log('inserted');
      return res;
    } catch (e) {
      log('Error inserting Education: $e');
      return 0;
    }
  }

  @override
  Future<int> deleteEducation() async {
    final db = await database;
    try {
      final res = await db.rawDelete('DELETE FROM educations');

      return res;
    } catch (e) {
      log('Error delete Education: $e');
      return 0;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getEducation(
      Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      return await _db
          .rawQuery('SELECT $column FROM educations ORDER BY $column ASC');
    } catch (e) {
      log('Error fetching Education: $e');
      String? message;

      final eduval = await Labourdata().education();
      final resultAsjson = jsonDecode(eduval.toString());
      final loginval =
          Fetcheducation.fromJson(resultAsjson as Map<String, dynamic>);
      if (eduval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (eduval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final edulist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
        return edulist!.map((datum) => datum.toJson()).toList();

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || eduval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (eduval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (eduval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db
  //       .rawQuery('SELECT name_ml FROM educations ORDER BY name_ml ASC');
  // } else {
  //   return await _db
  //       .rawQuery('SELECT name FROM educations ORDER BY name ASC');
  // }

  @override
  Future<List<Map<String, Object?>>> getEduId(
      String? name, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      return await _db.rawQuery(
          "SELECT education_id FROM educations WHERE $column='$name'");
    } catch (e) {
      log('Error fetching Education id: $e');
      String? message;

      final eduval = await Labourdata().education();
      final resultAsjson = jsonDecode(eduval.toString());
      final loginval =
          Fetcheducation.fromJson(resultAsjson as Map<String, dynamic>);
      if (eduval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (eduval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final edulist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
        final matchingDistrict = edulist!.firstWhere(
          (datum) => locale == Locale('ml')
              ? datum.nameMl == name // Match Malayalam name
              : datum.name == name, // Match default name
          // orElse: () => [], // Return null if no match
        );

        // Return the matching district ID
        //if (matchingDistrict!=null) {
        return [
          {'education_id': matchingDistrict.educationId}
        ];
        //  }

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || eduval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (eduval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (eduval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db.rawQuery(
  //       "SELECT education_id FROM educations WHERE name_ml='$name'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT education_id FROM educations WHERE name='$name'");
  // }

  @override
  Future<List<Map<String, Object?>>> getEduName(
      int? id, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      return await _db
          .rawQuery("SELECT $column FROM educations WHERE education_id='$id'");
    } catch (e) {
      String? message;

      final eduval = await Labourdata().education();
      final resultAsjson = jsonDecode(eduval.toString());
      final loginval =
          Fetcheducation.fromJson(resultAsjson as Map<String, dynamic>);
      if (eduval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (eduval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final edulist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        final matchingEdu = edulist!.firstWhere(
          (datum) => datum.educationId == id,
          orElse: () =>
              Datum(educationId: -1, name: "Unknown", nameMl: "അജ്ഞാതം"),
        );

        final column = locale == Locale('ml') ? 'name_ml' : 'name';

        // Return the gender name based on locale
        return [
          {
            column:
                locale == Locale('ml') ? matchingEdu.nameMl : matchingEdu.name
          }
        ];

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || eduval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (eduval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (eduval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }

  // if (locale == Locale('ml')) {
  //   return await _db
  //       .rawQuery("SELECT name_ml FROM educations WHERE education_id='$id'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT name FROM educations WHERE education_id='$id'");
  // }

  /* ********************************************* */

  /*LOCALBODYTYPE */

  @override
  Future addLocalbodyType(Localbdytypemodel newLocalbdyType) async {
    await deleteLocalbodyType();
    final db = await database;
    try {
      final res = await db.insert('localbody_types', newLocalbdyType.toJson());
      log('inserted');
      return res;
    } catch (e) {
      log('Error inserting localbody: $e');
      return 0;
    }
  }

  @override
  Future<int> deleteLocalbodyType() async {
    final db = await database;
    try {
      final res = await db.rawDelete('DELETE FROM localbody_types');

      return res;
    } catch (e) {
      log('Error deleting localbody: $e');
      return 0;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLocalbodyType(
      Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';

      return await _db
          .rawQuery('SELECT $column FROM localbody_types ORDER BY $column ASC');
    } catch (e) {
      log('Error fetching localbody: $e');
      String? message;

      final loctypeval = await Labourdata().localbodytype();
      final resultAsjson = jsonDecode(loctypeval.toString());
      final loginval =
          FetchLocalType.fromJson(resultAsjson as Map<String, dynamic>);
      if (loctypeval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (loctypeval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final loctypelist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        // Return the matching district ID
        //if (matchingDistrict!=null) {
        return loctypelist!.map((datum) => datum.toJson()).toList();

        //  }

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || loctypeval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (loctypeval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (loctypeval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db
  //       .rawQuery('SELECT name_ml FROM localbody_types ORDER BY name_ml ASC');
  // } else {
  //   return await _db
  //       .rawQuery('SELECT name FROM localbody_types ORDER BY name ASC');
  // }

  @override
  Future<List<Map<String, Object?>>> getLocalbdytypeId(
      String? name, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      return await _db.rawQuery(
          "SELECT lb_type_id FROM localbody_types WHERE $column ='$name'");
    } catch (e) {
      log('Error fetching localbody id: $e');
      String? message;

      final loctypeval = await Labourdata().localbodytype();
      final resultAsjson = jsonDecode(loctypeval.toString());
      final loginval =
          FetchLocalType.fromJson(resultAsjson as Map<String, dynamic>);
      if (loctypeval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (loctypeval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final loctypelist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        final matchinglocaltype = loctypelist!.firstWhere(
          (datum) => locale == Locale('ml')
              ? datum.nameMl == name // Match Malayalam name
              : datum.name == name, // Match default name
          // orElse: () => [], // Return null if no match
        );

        // Return the matching district ID
        //if (matchingDistrict!=null) {
        return [
          {'lb_type_id': matchinglocaltype.lbTypeId}
        ];

        //  }

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || loctypeval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (loctypeval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (loctypeval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db.rawQuery(
  //       "SELECT lb_type_id FROM localbody_types WHERE name_ml='$name'");
  // } else {
  //   return await _db.rawQuery(
  //       "SELECT lb_type_id FROM localbody_types WHERE name='$name'");
  // }

  @override
  Future<List<Map<String, Object?>>> getLocalbdytypeName(
      int? id, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      return await _db.rawQuery(
          "SELECT $column FROM localbody_types WHERE lb_type_id='$id'");
    } catch (e) {
      log('Error fetching localbody name: $e');
      String? message;

      final loctypeval = await Labourdata().localbodytype();
      final resultAsjson = jsonDecode(loctypeval.toString());
      final loginval =
          FetchLocalType.fromJson(resultAsjson as Map<String, dynamic>);
      if (loctypeval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (loctypeval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final loctypelist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        final matchingLoctype = loctypelist!.firstWhere(
          (datum) => datum.lbTypeId == id,
          //orElse: () => null,
        );

        final column = locale == Locale('ml') ? 'name_ml' : 'name';

        // Return the gender name based on locale
        return [
          {
            column: locale == Locale('ml')
                ? matchingLoctype.nameMl
                : matchingLoctype.name
          }
        ];
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || loctypeval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (loctypeval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (loctypeval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db.rawQuery(
  //       "SELECT name_ml FROM localbody_types WHERE lb_type_id='$id'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT name FROM localbody_types WHERE lb_type_id='$id'");
  // }

  /* ********************************************* */

  /*GENDER */
  @override
  Future addGenderType(Gendermodel newgenderType) async {
    await deleteGender();
    final db = await database;
    try {
      final res = await db.insert('genders', newgenderType.toJson());
      log('inserted');
      return res;
    } catch (e) {
      log('Error inserting gender: $e');
      return 0;
    }
  }

  @override
  Future<int> deleteGender() async {
    final db = await database;
    try {
      final res = await db.rawDelete('DELETE FROM genders');

      return res;
    } catch (e) {
      log('Error deleting gender: $e');
      return 0;
    }
    // final res = await db.rawDelete('DELETE FROM genders');

    // return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getGender(
      Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';

      return await _db.rawQuery('SELECT $column FROM genders');
    } catch (e) {
      log('Error fetching gender: $e');
      String? message;

      final genderval = await Labourdata().gender();
      final resultAsjson = jsonDecode(genderval.toString());
      final loginval =
          Fetchgender.fromJson(resultAsjson as Map<String, dynamic>);
      if (genderval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (genderval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final genderlist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        return genderlist!.map((datum) => datum.toJson()).toList();

        //  }

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || genderval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (genderval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (genderval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db.rawQuery('SELECT name_ml FROM genders');
  // } else {
  //   return await _db.rawQuery('SELECT name FROM genders');
  // }

  @override
  Future<List<Map<String, Object?>>> getGenderId(
      String? name, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      return await _db
          .rawQuery("SELECT gender_id FROM genders WHERE $column='$name'");
    } catch (e) {
      log('Error fetching gender id: $e');
      String? message;

      final genderval = await Labourdata().gender();
      final resultAsjson = jsonDecode(genderval.toString());
      final loginval =
          Fetchgender.fromJson(resultAsjson as Map<String, dynamic>);
      if (genderval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (genderval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final genderlist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        final matchingGender = genderlist!.firstWhere(
          (datum) => locale == Locale('ml')
              ? datum.nameMl == name // Match Malayalam name
              : datum.name == name, // Match default name
          // orElse: () => [], // Return null if no match
        );

        // Return the matching district ID
        //if (matchingDistrict!=null) {
        return [
          {'gender_id': matchingGender.genderId}
        ];

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || genderval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (genderval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (genderval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db
  //       .rawQuery("SELECT gender_id FROM genders WHERE name_ml='$name'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT gender_id FROM genders WHERE name='$name'");
  // }

  @override
  Future<List<Map<String, Object?>>> getGenderName(
      int? id, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';

      return await _db
          .rawQuery("SELECT $column FROM genders WHERE gender_id='$id'");
    } catch (e) {
      log('Error fetching gender name: $e');
      String? message;

      final genderval = await Labourdata().gender();
      final resultAsjson = jsonDecode(genderval.toString());
      final loginval =
          Fetchgender.fromJson(resultAsjson as Map<String, dynamic>);
      if (genderval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (genderval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final genderlist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        final matchingGender = genderlist!.firstWhere(
          (datum) => datum.genderId == id,
          //orElse: () => null,
        );

        final column = locale == Locale('ml') ? 'name_ml' : 'name';

        // Return the gender name based on locale
        return [
          {
            column: locale == Locale('ml')
                ? matchingGender.nameMl
                : matchingGender.name
          }
        ];

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || genderval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (genderval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (genderval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db
  //       .rawQuery("SELECT name_ml FROM genders WHERE gender_id='$id'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT name FROM genders WHERE gender_id='$id'");
  // }

  /* ********************************************* */

  /*LocalBodies */
  @override
  Future addLocalbodies(Localbodiesmodel localbodyname) async {
    await deleteLocalbodies();
    final db = await database;
    try {
      final res = await db.insert('localbodies', localbodyname.toJson());
      log('inserted');
      return res;
    } catch (e) {
      log('Error inserting localbody: $e');
      return 0;
    }
  }

  @override
  Future<int> deleteLocalbodies() async {
    final db = await database;
    try {
      final res = await db.rawDelete('DELETE FROM localbodies');

      return res;
    } catch (e) {
      log('Error deleting localbody: $e');
      return 0;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLocalbodies(
      int? distid, int? typeid, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';

      final listbodies = await _db.rawQuery(
          "SELECT $column FROM localbodies WHERE district_id='$distid' AND lb_type_id='$typeid' ORDER BY $column ASC");
      return listbodies;
    } catch (e) {
      log('Error fetching localbody: $e');
      String? message;
      final locreqval = LocbodyReq(districtId: distid, lbTypeId: typeid);
      final loclbdyval = await Labourdata().localbodies(locreqval);
      final resultAsjson = jsonDecode(loclbdyval.toString());
      final loginval =
          Fetchlocalbody.fromJson(resultAsjson as Map<String, dynamic>);
      if (loclbdyval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (loclbdyval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final loclbdylist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        // Return the matching district ID
        //if (matchingDistrict!=null) {
        return loclbdylist!.map((datum) => datum.toJson()).toList();

        //  }

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || loclbdyval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (loclbdyval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (loclbdyval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   final listbodies=await _db.rawQuery(
  //       "SELECT name_ml FROM localbodies WHERE district_id='$distid' AND lb_type_id='$typeid' ORDER BY name_ml ASC");
  //   return listbodies;
  // } else {
  //   final listbodies=await _db.rawQuery(
  //       "SELECT name FROM localbodies WHERE district_id='$distid' AND lb_type_id='$typeid' ORDER BY name ASC");
  //   return listbodies;
  // }

  @override
  Future<List<Map<String, Object?>>> getLocalbodyId(int? distid, int? typeid,
      String? name, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';

      return await _db.rawQuery(
          "SELECT localbody_id FROM localbodies WHERE $column='$name'");
    } catch (e) {
      log('Error fetching localbody id: $e');
      String? message;
      final locreqval = LocbodyReq(districtId: distid, lbTypeId: typeid);
      final loclbdyval = await Labourdata().localbodies(locreqval);
      final resultAsjson = jsonDecode(loclbdyval.toString());
      final loginval =
          Fetchlocalbody.fromJson(resultAsjson as Map<String, dynamic>);
      if (loclbdyval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (loclbdyval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final loclbdylist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        final matchingLoclBdy = loclbdylist!.firstWhere(
          (datum) => locale == Locale('ml')
              ? datum.nameMl == name // Match Malayalam name
              : datum.name == name, // Match default name
          // orElse: () => [], // Return null if no match
        );

        // Return the matching district ID
        //if (matchingDistrict!=null) {
        return [
          {'localbody_id': matchingLoclBdy.localbodyId}
        ];

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || loclbdyval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (loclbdyval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (loclbdyval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db.rawQuery(
  //       "SELECT localbody_id FROM localbodies WHERE name_ml='$name'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT localbody_id FROM localbodies WHERE name='$name'");
  // }

  @override
  Future<List<Map<String, Object?>>> getLocalbodyName(int? distid, int? typeid,
      int? id, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';

      return await _db
          .rawQuery("SELECT $column FROM localbodies WHERE localbody_id='$id'");
    } catch (e) {
      log('Error fetching localbody name: $e');
      String? message;
      final locreqval = LocbodyReq(districtId: distid, lbTypeId: typeid);
      final loclbdyval = await Labourdata().localbodies(locreqval);
      final resultAsjson = jsonDecode(loclbdyval.toString());
      final loginval =
          Fetchlocalbody.fromJson(resultAsjson as Map<String, dynamic>);
      if (loclbdyval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (loclbdyval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final loclbdylist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        final matchingLoclBdy = loclbdylist!.firstWhere(
          (datum) => datum.localbodyId == id,
          //orElse: () => null,
        );

        final column = locale == Locale('ml') ? 'name_ml' : 'name';

        // Return the gender name based on locale
        return [
          {
            column: locale == Locale('ml')
                ? matchingLoclBdy.nameMl
                : matchingLoclBdy.name
          }
        ];

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' || loclbdyval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (loclbdyval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (loclbdyval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db
  //       .rawQuery("SELECT name_ml FROM localbodies WHERE localbody_id='$id'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT name FROM localbodies WHERE localbody_id='$id'");
  // }

  /* ********************************************* */

  /*Occupations */
  @override
  Future addOccupations(Occupationmodel occupationname) async {
    await deleteOccupations();
    final db = await database;
    try {
      final res = await db.insert('occupations', occupationname.toJson());
      log('inserted');
      return res;
    } catch (e) {
      log('Error inserting occupation: $e');
      return 0;
    }
  }

  @override
  Future<int> deleteOccupations() async {
    final db = await database;
    try {
      final res = await db.rawDelete('DELETE FROM occupations');

      return res;
    } catch (e) {
      log('Error delete occupation: $e');
      return 0;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getOccupations(
      Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      return await _db
          .rawQuery('SELECT $column FROM occupations ORDER BY $column ASC');
    } catch (e) {
      log('Error fetching occupation: $e');
      String? message;

      final occupationval = await Labourdata().occupations();
      final resultAsjson = jsonDecode(occupationval.toString());
      final loginval =
          Fetchoccupation.fromJson(resultAsjson as Map<String, dynamic>);
      if (occupationval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (occupationval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final occupationlist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        return occupationlist!.map((datum) => datum.toJson()).toList();

        //  }

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' ||
          occupationval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (occupationval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (occupationval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db
  //       .rawQuery('SELECT name_ml FROM occupations ORDER BY name_ml ASC');
  // } else {
  //   return await _db
  //       .rawQuery('SELECT name FROM occupations ORDER BY name ASC');
  // }

  @override
  Future<List<Map<String, Object?>>> getOccupationsId(
      String? name, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';
      return await _db.rawQuery(
          "SELECT occupation_id FROM occupations WHERE $column='$name'");
    } catch (e) {
      log('Error fetching occupation id: $e');
      String? message;

      final occupationval = await Labourdata().occupations();
      final resultAsjson = jsonDecode(occupationval.toString());
      final loginval =
          Fetchoccupation.fromJson(resultAsjson as Map<String, dynamic>);
      if (occupationval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (occupationval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final occupationlist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        final matchingOccupation = occupationlist!.firstWhere(
          (datum) => locale == Locale('ml')
              ? datum.nameMl == name // Match Malayalam name
              : datum.name == name, // Match default name
          // orElse: () => [], // Return null if no match
        );

        return [
          {'occupation_id': matchingOccupation.occupationId}
        ];
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' ||
          occupationval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (occupationval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (occupationval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db.rawQuery(
  //       "SELECT occupation_id FROM occupations WHERE name_ml='$name'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT occupation_id FROM occupations WHERE name='$name'");
  // }

  @override
  Future<List<Map<String, Object?>>> getOccupationsName(
      int? id, Locale? locale, BuildContext context) async {
    try {
      final column = locale == Locale('ml') ? 'name_ml' : 'name';

      return await _db.rawQuery(
          "SELECT $column FROM occupations WHERE occupation_id='$id'");
    } catch (e) {
      log('Error fetching occupation name: $e');
      String? message;

      final occupationval = await Labourdata().occupations();
      final resultAsjson = jsonDecode(occupationval.toString());
      final loginval =
          Fetchoccupation.fromJson(resultAsjson as Map<String, dynamic>);
      if (occupationval == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (occupationval.statusCode == 200 && loginval.success == true) {
        final msg = loginval.message;
        final occupationlist = loginval.data;
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);

        final matchingOccupation = occupationlist!.firstWhere(
          (datum) => datum.occupationId == id,
          //orElse: () => null,
        );

        final column = locale == Locale('ml') ? 'name_ml' : 'name';
        return [
          {
            column: locale == Locale('ml')
                ? matchingOccupation.nameMl
                : matchingOccupation.name
          }
        ];
      } else if (loginval.success == false) {
        final msg = loginval.message;

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' ||
          occupationval.statusCode == 401) {
        if (!context.mounted) return [];

        //CommonFun.instance.signout(context);
      } else if (occupationval.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (occupationval.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
    return [];
  }
  // if (locale == Locale('ml')) {
  //   return await _db.rawQuery(
  //       "SELECT name_ml FROM occupations WHERE occupation_id='$id'");
  // } else {
  //   return await _db
  //       .rawQuery("SELECT name FROM occupations WHERE occupation_id='$id'");
  // }
}

/* ********************************************* */
