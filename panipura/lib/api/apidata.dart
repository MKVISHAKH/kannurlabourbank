import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:panipura/api/url.dart';
import 'package:panipura/database/labourdb.dart';
import 'package:panipura/model/contactlog/contactlog.dart';
import 'package:panipura/model/createlabour/createlabreq/createlabreq.dart';
import 'package:panipura/model/districtmodel/districtmodel.dart';
import 'package:panipura/model/edithometown/edithmtwnreq/edithmtwnreq.dart';
import 'package:panipura/model/localbodytype/loclbdytypmdl.dart';
import 'package:panipura/model/loginmodel/loginreq/loginreq.dart';
import 'package:panipura/model/otpresend/otprsndreq/otprsndreq.dart';
import 'package:panipura/model/otpvfy/otpvrfyreq/otpvrfyreq.dart';
import 'package:panipura/model/otpvfy/rstpswrdvrfy/rstpswrdvrfy.dart';
import 'package:panipura/model/searchlabour/searchlabourmdl/searchlabourmdl.dart';
import 'package:panipura/model/todolist/addtodolist/addtodolistreq.dart';
import 'package:panipura/model/todolist/deletetodoreq/deletetodoreq.dart';
import '../model/addrefskill/addrefskillreq/addrefskillreq.dart';
import '../model/deleteskill/deletereq/deletereq/deletereq.dart';
import '../model/educationmdl/educationmodel.dart';
import '../model/gendermdl/gendermodel.dart';
import '../model/get skill/getskillreq/getskillreq.dart';
import '../model/getskillrate/getskillratereq/getskillratereq.dart';
import '../model/localbodies/localbodies.dart';
import '../model/occupationmdl/occupationmdl.dart';
import '../model/ratingmdl/ratingreqmdl/ratingreqmdl.dart';
import '../sharedpref/sharedprefdata.dart';

abstract class Apicalls {
  Future<Response<dynamic>?> createlabour(Createlabreq value);

  Future<Response<dynamic>?> createemp(Createlabreq value);

  Future<Response<dynamic>?> login(Loginreq value);

  Future<Response<dynamic>?> emplogin(Loginreq value);

  Future<List<Districtmodel?>> district();

  Future<List<Educationmodel?>> education();

  Future<List<Localbdytypemodel?>> localbodytype();

  Future<List<Gendermodel?>> gender();

  Future<List<Localbodiesmodel?>> localbodies();

  Future<List<Occupationmodel?>> occupations();

  Future<Response<dynamic>?> addskill(Addrefskillreq value, String? locale);

  Future<Response<dynamic>?> editskill(Addrefskillreq value, String? locale);

  Future<Response<dynamic>?> getskill(Getskillreq value);

  Future<Response<dynamic>?> searchlab(Searchlabourmdl value);

  Future<Response<dynamic>?> viewProfile(Getskillreq value);

  Future<Response<dynamic>?> deleteskill(Deletereq value);

  Future<Response<dynamic>?> edithometwn(Edithmtwnreq value);

  Future<Response<dynamic>?> otpresend(Otprsndreq value);

  Future<Response<dynamic>?> empotpresend(Otprsndreq value);

  Future<Response<dynamic>?> otpvrfy(Otpvrfyreq value);

  Future<Response<dynamic>?> empotpvrfy(Otpvrfyreq value);

  Future<Response<dynamic>?> forgotpswrd(Otprsndreq value);

  Future<Response<dynamic>?> empforgotpswrd(Otprsndreq value);

  Future<Response<dynamic>?> forgotpswrdvrfy(Rstpswrdvrfy value);

  Future<Response<dynamic>?> empforgotpswrdvrfy(Rstpswrdvrfy value);

  Future<Response?> dwonloaddb(String dbname);

  Future<Response?> uploadimg(File? img, int? usrid, int typeid);

  Future<Response?> rateskill(Ratingreqmdl value);

  Future<Response?> delrate(int? rateId);

  Future<Response?> getrateskill(Getskillratereq value);

  Future<Response?> addtodolist(Addtodolist value);

  Future<Response?> gettodolist(int? userId);

  Future<Response?> deletetodolist(Deletetodoreq value);

  Future<Response?> edittodolist(Addtodolist value, int? todoId);

  Future<Response?> contactlog(Contactlog value);

  // Future<Response?> dwnldimg(int? usrid);
}

class Labourdata extends Apicalls {
  final dio = Dio();
  final url = Url();

  Labourdata() {
    //dio.options.headers=Options(headers: {'"Authorization":"Bearer $token"'});
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }

  /*register category */
  @override
  Future<Response<dynamic>?> createlabour(Createlabreq value) async {
    try {
      final result = await dio.post(
        url.registerUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
    //   final _resultAsjson = jsonDecode(_result.data);
    //   return Createlabresp.fromJson(_resultAsjson as Map<String, dynamic>);
    // }on DioError  catch (ex) {
    //   // var data = {"status":"error","message":ex.message};
    //   var data = {"success":"error","data":ex.response!.statusCode,"message":ex.message};
    //   return Createlabresp.fromJson(data);
    // }
  }

  /* *************************************** */

  /*employer register  */
  @override
  Future<Response?> createemp(Createlabreq value) async {
    try {
      final result = await dio.post(
        url.empregisterUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  /* *************************************** */

  /*login category */
  @override
  Future<Response<dynamic>?> login(Loginreq value) async {
    try {
      final result = await dio.post(
        url.loginUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  /* *************************************** */

  /*employer login  */
  @override
  Future<Response<dynamic>?> emplogin(Loginreq value) async {
    try {
      final result = await dio.post(
        url.emploginUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  /* *************************************** */

  /*district */
  @override
  Future<List<Districtmodel?>> district() async {
    try {
      Response result = await dio.get(
        url.districtUrl,
      );
      final resultAsjson = jsonDecode(result.data);
      // final Distlist= DistrictmodelList.fromJson(_resultAsjson);
      return (resultAsjson as List).map((district) {
        //print('Inserting $district');
        final distlist = Districtmodel.fromJson(district);
        LabourDb.instance.addDistrict(distlist);
      }).toList();
    } on DioException catch (ex) {
      // var data = {"status":"error","message":ex.message};
      var data = {
        "status": "error",
        "result": ex.message,
        "message": url.baseUrl + url.districtUrl
      };
      return [Districtmodel.fromJson(data)];
    }
  }

  /* *************************************** */

  /*Education */
  @override
  Future<List<Educationmodel?>> education() async {
    try {
      Response result = await dio.get(
        url.educationUrl,
      );
      final resultAsjson = jsonDecode(result.data);
      // final Distlist= DistrictmodelList.fromJson(_resultAsjson);
      return (resultAsjson as List).map((education) {
        //print('Inserting $education');
        final edulist = Educationmodel.fromJson(education);
        LabourDb.instance.addEducation(edulist);
      }).toList();
    } on DioException catch (ex) {
      // var data = {"status":"error","message":ex.message};
      var data = {
        "status": "error",
        "result": ex.message,
        "message": url.baseUrl + url.educationUrl
      };
      return [Educationmodel.fromJson(data)];
    }
  }

  /* *************************************** */

  /*LOCALBODYTYPE */
  @override
  Future<List<Localbdytypemodel?>> localbodytype() async {
    try {
      Response result = await dio.get(
        url.loclbdytypeUrl,
      );
      final resultAsjson = jsonDecode(result.data);
      // final Distlist= DistrictmodelList.fromJson(_resultAsjson);
      return (resultAsjson as List).map((localtype) {
        //print('Inserting $localtype');
        final typelist = Localbdytypemodel.fromJson(localtype);
        LabourDb.instance.addLocalbodyType(typelist);
      }).toList();
    } on DioException catch (ex) {
      // var data = {"status":"error","message":ex.message};
      var data = {
        "status": "error",
        "result": ex.message,
        "message": url.baseUrl + url.loclbdytypeUrl
      };
      return [Localbdytypemodel.fromJson(data)];
    }
  }

  /* *************************************** */

  /*Gender */
  @override
  Future<List<Gendermodel?>> gender() async {
    try {
      Response result = await dio.get(
        url.genderUrl,
      );
      final resultAsjson = jsonDecode(result.data);
      // final Distlist= DistrictmodelList.fromJson(_resultAsjson);
      return (resultAsjson as List).map((gender) {
        //print('Inserting $gender');
        final genderlist = Gendermodel.fromJson(gender);
        LabourDb.instance.addGenderType(genderlist);
      }).toList();
    } on DioException catch (ex) {
      // var data = {"status":"error","message":ex.message};
      var data = {
        "status": "error",
        "result": ex.message,
        "message": url.baseUrl + url.genderUrl
      };
      return [Gendermodel.fromJson(data)];
    }
  }

  /* localbodies */
  @override
  Future<List<Localbodiesmodel?>> localbodies() async {
    try {
      Response result = await dio.get(
        url.localbodiesUrl,
      );
      final resultAsjson = jsonDecode(result.data);
      // final Distlist= DistrictmodelList.fromJson(_resultAsjson);
      return (resultAsjson as List).map((localbodies) {
        //print('Inserting $localbodies');
        final localbodieslist = Localbodiesmodel.fromJson(localbodies);
        LabourDb.instance.addLocalbodies(localbodieslist);
      }).toList();
    } on DioException catch (ex) {
      // var data = {"status":"error","message":ex.message};
      var data = {
        "status": "error",
        "result": ex.message,
        "message": url.baseUrl + url.localbodiesUrl
      };
      return [Localbodiesmodel.fromJson(data)];
    }
  }

  /* *************************************** */

  /* occupations */
  @override
  Future<List<Occupationmodel?>> occupations() async {
    try {
      Response result = await dio.get(
        url.occupationUrl,
      );
      final resultAsjson = jsonDecode(result.data);
      // final Distlist= DistrictmodelList.fromJson(_resultAsjson);
      return (resultAsjson as List).map((occupations) {
        //print('Inserting $occupations');
        final occupationlist = Occupationmodel.fromJson(occupations);
        LabourDb.instance.addOccupations(occupationlist);
      }).toList();
    } on DioException catch (ex) {
      // var data = {"status":"error","message":ex.message};
      var data = {
        "status": "error",
        "result": ex.message,
        "message": url.baseUrl + url.occupationUrl
      };
      return [Occupationmodel.fromJson(data)];
    }
  }

  /* *************************************** */

  /* addskill */
  @override
  Future<Response<dynamic>?> addskill(
      Addrefskillreq value, String? locale) async {
    //print(value);
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post('${url.addskillUrl}/$locale',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }
  /* *************************************** */

  /* edit skill */

  @override
  Future<Response<dynamic>?> editskill(
      Addrefskillreq value, String? locale) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post('${url.editskillUrl}/$locale',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }
  /* *************************************** */

  /* getskill */

  @override
  Future<Response<dynamic>?> getskill(Getskillreq value) async {
    final usrid = value.userId;
    final localecd = value.locale;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post('${url.getskillUrl}/$usrid/$localecd',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  /* *************************************** */

  /* searchlab */
  @override
  Future<Response<dynamic>?> searchlab(Searchlabourmdl value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.searchlabUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  /* *************************************** */

  /* *************************************** */
  @override
  Future<Response<dynamic>?> viewProfile(Getskillreq value) async {
    final usrid = value.userId;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post('${url.viewProfileUrl}/$usrid',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> deleteskill(Deletereq value) async {
    final usrid = value.userId;
    final skillid = value.skillId;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.delete('${url.skilldeleteUrl}/$usrid/$skillid',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> edithometwn(Edithmtwnreq value) async {
    final usrid = value.userId;
    final place = value.place;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.put('${url.edithometwnUrl}/$usrid/$place',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> otpresend(Otprsndreq value) async {
    final type = value.type;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post('${url.otpresndUrl}/$type',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> empotpresend(Otprsndreq value) async {
    final type = value.type;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post('${url.empotpresndUrl}/$type',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> otpvrfy(Otpvrfyreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.otpvrfUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> empotpvrfy(Otpvrfyreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.empotpvrfUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> forgotpswrd(Otprsndreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.forgotpwrdUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> empforgotpswrd(Otprsndreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.empforgotpwrdUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> forgotpswrdvrfy(Rstpswrdvrfy value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.resetpwrdvrfyUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> empforgotpswrdvrfy(Rstpswrdvrfy value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.resetemppwrdvrfyUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> dwonloaddb(String dbname) async {
    try {
      Response result = await Dio().get(url.baseUrl + url.downloaddbUrl,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveDataWhenStatusError: true,
              //  connectTimeout:const Duration(seconds:30),
              receiveTimeout: const Duration(seconds: 30)
              //receiveTimeout: Duration.zero,
              ));

      return result;
    } on DioException catch (ex) {
      if (ex.type ==
          DioException.connectionTimeout(
            timeout: const Duration(seconds: 30),
            requestOptions: ex.requestOptions,
          )) {
        throw Exception("Connection Timeout");
      }

      throw Exception(ex.message);
      //return ex.response;
    }
  }

  @override
  Future<Response?> uploadimg(File? img, int? usrid, int typeid) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;

    try {
      if (img != null) {
        String fileName = img.path.split('/').last;
        FormData formdata = FormData.fromMap({
          "file": await MultipartFile.fromFile(img.path, filename: fileName),
          "user_id": usrid,
          "type_id": typeid
        });

        Response result = await Dio().post(url.baseUrl + url.uploadUrl,
            data: formdata,
            options: Options(
              headers: {
                "Authorization": "Bearer $token",
                "Accept": "application/json"
              },
              responseType: ResponseType.plain,
            ));
        return result;
      }
      return null;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  NetworkImage getImage(int? userid, String? token) {
    String urlval = '${url.baseUrl + url.downldimgUrl}/$userid';
    return NetworkImage(
      urlval,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );
  }

  @override
  Future<Response?> rateskill(Ratingreqmdl value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.ratingUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

    @override
  Future<Response?> delrate(int? rateId) async{
     final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.delete('${url.ratingUrl}/$rateId',
          //data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> getrateskill(Getskillratereq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    final userid = value.userId;
    final skillid = value.skillId;

    try {
      final result = await dio.get('${url.ratingUrl}/$userid/$skillid',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> addtodolist(Addtodolist value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.todolistaddUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> gettodolist(int? userId) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    //final userid = userId;
    //final skillid = value.skillId;

    try {
      final result = await dio.post('${url.todolistgetUrl}/$userId',
          // data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> deletetodolist(Deletetodoreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.delete(url.todolistdeleteUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> edittodolist(Addtodolist value, int? todoId) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.put('${url.todolistEditUrl}/$todoId',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> contactlog(Contactlog value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dio.post(url.contactlogUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }
  

}
