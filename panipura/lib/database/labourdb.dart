import 'dart:developer';

import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/model/districtmodel/districtmodel.dart';
import 'package:panipura/model/educationmdl/educationmodel.dart';
import 'package:panipura/model/localbodytype/loclbdytypmdl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/gendermdl/gendermodel.dart';
import '../model/localbodies/localbodies.dart';
import '../model/occupationmdl/occupationmdl.dart';

abstract class LabourDbFunction {
  Future addDistrict(Districtmodel newDistrict);
  Future<int> deleteDistrict();
  Future<List<Map<String, dynamic>>> getDistrict(Locale? locale);
  Future<List<Map<String, Object?>>> getDistrictId(
      String? name, Locale? locale);
  Future<List<Map<String, Object?>>> getDistrictName(int? id, Locale? locale);

  Future addEducation(Educationmodel newEducation);
  Future<int> deleteEducation();
  Future<List<Map<String, dynamic>>> getEducation(Locale? locale);
  Future<List<Map<String, Object?>>> getEduId(String? name, Locale? locale);
  Future<List<Map<String, Object?>>> getEduName(int? id, Locale? locale);

  Future addLocalbodyType(Localbdytypemodel newLocalbdyType);
  Future<int> deleteLocalbodyType();
  Future<List<Map<String, dynamic>>> getLocalbodyType(Locale? locale);
  Future<List<Map<String, Object?>>> getLocalbdytypeId(
      String? name, Locale? locale);
  Future<List<Map<String, Object?>>> getLocalbdytypeName(
      int? id, Locale? locale);

  Future addGenderType(Gendermodel newgenderType);
  Future<int> deleteGender();
  Future<List<Map<String, dynamic>>> getGender(Locale? locale);
  Future<List<Map<String, Object?>>> getGenderId(String? name, Locale? locale);
  Future<List<Map<String, Object?>>> getGenderName(int? id, Locale? locale);

  Future addLocalbodies(Localbodiesmodel localbodyname);
  Future<int> deleteLocalbodies();
  Future<List<Map<String, dynamic>>> getLocalbodies(
      int? distid, int? typeid, Locale? locale);
  Future<List<Map<String, Object?>>> getLocalbodyId(
      String? name, Locale? locale);
  Future<List<Map<String, Object?>>> getLocalbodyName(int? id, Locale? locale);

  Future addOccupations(Occupationmodel localbodyname);
  Future<int> deleteOccupations();
  Future<List<Map<String, dynamic>>> getOccupations(Locale? locale);
  Future<List<Map<String, Object?>>> getOccupationsId(
      String? name, Locale? locale);
  Future<List<Map<String, Object?>>> getOccupationsName(
      int? id, Locale? locale);
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
    final res = await db.insert('DISTRICTS', newDistrict.toJson());
    log('inserted');
    return res;
  }

  @override
  Future<int> deleteDistrict() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM DISTRICTS');

    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getDistrict(Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db
          .rawQuery('SELECT name_ml FROM DISTRICTS ORDER BY name_ml ASC');
    } else {
      return await _db.rawQuery('SELECT name FROM DISTRICTS ORDER BY name ASC');
    }
  }

  @override
  Future<List<Map<String, Object?>>> getDistrictId(
      String? name, Locale? locale) async {
    if (locale == Locale('ml')) {
      final listid=await _db
          .rawQuery("SELECT district_id FROM DISTRICTS WHERE name_ml='$name'");
      return listid;
    } else {
      final listid=await _db
          .rawQuery("SELECT district_id FROM DISTRICTS WHERE name='$name'");
      return listid;
    }
  }

  @override
  Future<List<Map<String, Object?>>> getDistrictName(
      int? id, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db
          .rawQuery("SELECT name_ml FROM DISTRICTS WHERE district_id='$id'");
    } else {
      return await _db
          .rawQuery("SELECT name FROM DISTRICTS WHERE district_id='$id'");
    }
  }
  /* ********************************************* */

  /* Education details entry */
  @override
  Future addEducation(Educationmodel newEducation) async {
    await deleteEducation();
    final db = await database;
    final res = await db.insert('EDUCATIONS', newEducation.toJson());
    log('inserted');
    return res;
  }

  @override
  Future<int> deleteEducation() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM EDUCATIONS');

    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getEducation(Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db
          .rawQuery('SELECT name_ml FROM EDUCATIONS ORDER BY name_ml ASC');
    } else {
      return await _db
          .rawQuery('SELECT name FROM EDUCATIONS ORDER BY name ASC');
    }
  }

  @override
  Future<List<Map<String, Object?>>> getEduId(
      String? name, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db.rawQuery(
          "SELECT education_id FROM EDUCATIONS WHERE name_ml='$name'");
    } else {
      return await _db
          .rawQuery("SELECT education_id FROM EDUCATIONS WHERE name='$name'");
    }
  }

  @override
  Future<List<Map<String, Object?>>> getEduName(int? id, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db
          .rawQuery("SELECT name_ml FROM EDUCATIONS WHERE education_id='$id'");
    } else {
      return await _db
          .rawQuery("SELECT name FROM EDUCATIONS WHERE education_id='$id'");
    }
  }
  /* ********************************************* */

  /*LOCALBODYTYPE */

  @override
  Future addLocalbodyType(Localbdytypemodel newLocalbdyType) async {
    await deleteLocalbodyType();
    final db = await database;
    final res = await db.insert('LOCALBODY_TYPES', newLocalbdyType.toJson());
    log('inserted');
    return res;
  }

  @override
  Future<int> deleteLocalbodyType() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM LOCALBODY_TYPES');

    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getLocalbodyType(Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db
          .rawQuery('SELECT name_ml FROM LOCALBODY_TYPES ORDER BY name_ml ASC');
    } else {
      return await _db
          .rawQuery('SELECT name FROM LOCALBODY_TYPES ORDER BY name ASC');
    }
  }

  @override
  Future<List<Map<String, Object?>>> getLocalbdytypeId(
      String? name, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db.rawQuery(
          "SELECT lb_type_id FROM LOCALBODY_TYPES WHERE name_ml='$name'");
    } else {
      return await _db.rawQuery(
          "SELECT lb_type_id FROM LOCALBODY_TYPES WHERE name='$name'");
    }
  }

  @override
  Future<List<Map<String, Object?>>> getLocalbdytypeName(
      int? id, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db.rawQuery(
          "SELECT name_ml FROM LOCALBODY_TYPES WHERE lb_type_id='$id'");
    } else {
      return await _db
          .rawQuery("SELECT name FROM LOCALBODY_TYPES WHERE lb_type_id='$id'");
    }
  }
  /* ********************************************* */

  /*GENDER */
  @override
  Future addGenderType(Gendermodel newgenderType) async {
    await deleteGender();
    final db = await database;
    final res = await db.insert('GENDERS', newgenderType.toJson());
    log('inserted');
    return res;
  }

  @override
  Future<int> deleteGender() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM GENDERS');

    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getGender(Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db.rawQuery('SELECT name_ml FROM GENDERS');
    } else {
      return await _db.rawQuery('SELECT name FROM GENDERS');
    }
  }

  @override
  Future<List<Map<String, Object?>>> getGenderId(
      String? name, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db
          .rawQuery("SELECT gender_id FROM GENDERS WHERE name_ml='$name'");
    } else {
      return await _db
          .rawQuery("SELECT gender_id FROM GENDERS WHERE name='$name'");
    }
  }

  @override
  Future<List<Map<String, Object?>>> getGenderName(
      int? id, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db
          .rawQuery("SELECT name_ml FROM GENDERS WHERE gender_id='$id'");
    } else {
      return await _db
          .rawQuery("SELECT name FROM GENDERS WHERE gender_id='$id'");
    }
  }
  /* ********************************************* */

  /*LocalBodies */
  @override
  Future addLocalbodies(Localbodiesmodel localbodyname) async {
    await deleteLocalbodies();
    final db = await database;
    final res = await db.insert('LOCALBODIES', localbodyname.toJson());
    log('inserted');
    return res;
  }

  @override
  Future<int> deleteLocalbodies() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM LOCALBODIES');

    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getLocalbodies(
      int? distid, int? typeid, Locale? locale) async {
    if (locale == Locale('ml')) {
      final listbodies=await _db.rawQuery(
          "SELECT name_ml FROM LOCALBODIES WHERE district_id='$distid' AND lb_type_id='$typeid' ORDER BY name_ml ASC");
      return listbodies;
    } else {
      final listbodies=await _db.rawQuery(
          "SELECT name FROM LOCALBODIES WHERE district_id='$distid' AND lb_type_id='$typeid' ORDER BY name ASC");
      return listbodies;
    }
  }

  @override
  Future<List<Map<String, Object?>>> getLocalbodyId(
      String? name, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db.rawQuery(
          "SELECT localbody_id FROM LOCALBODIES WHERE name_ml='$name'");
    } else {
      return await _db
          .rawQuery("SELECT localbody_id FROM LOCALBODIES WHERE name='$name'");
    }
  }

  @override
  Future<List<Map<String, Object?>>> getLocalbodyName(
      int? id, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db
          .rawQuery("SELECT name_ml FROM LOCALBODIES WHERE localbody_id='$id'");
    } else {
      return await _db
          .rawQuery("SELECT name FROM LOCALBODIES WHERE localbody_id='$id'");
    }
  }

  /* ********************************************* */

  /*Occupations */
  @override
  Future addOccupations(Occupationmodel occupationname) async {
    await deleteOccupations();
    final db = await database;
    final res = await db.insert('OCCUPATIONS', occupationname.toJson());
    log('inserted');
    return res;
  }

  @override
  Future<int> deleteOccupations() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM OCCUPATIONS');

    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getOccupations(Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db
          .rawQuery('SELECT name_ml FROM OCCUPATIONS ORDER BY name_ml ASC');
    } else {
      return await _db
          .rawQuery('SELECT name FROM OCCUPATIONS ORDER BY name ASC');
    }
  }

  @override
  Future<List<Map<String, Object?>>> getOccupationsId(
      String? name, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db.rawQuery(
          "SELECT occupation_id FROM OCCUPATIONS WHERE name_ml='$name'");
    } else {
      return await _db
          .rawQuery("SELECT occupation_id FROM OCCUPATIONS WHERE name='$name'");
    }
  }

  @override
  Future<List<Map<String, Object?>>> getOccupationsName(
      int? id, Locale? locale) async {
    if (locale == Locale('ml')) {
      return await _db.rawQuery(
          "SELECT name_ml FROM OCCUPATIONS WHERE occupation_id='$id'");
    } else {
      return await _db
          .rawQuery("SELECT name FROM OCCUPATIONS WHERE occupation_id='$id'");
    }
  }

  /* ********************************************* */
}
