import 'dart:io';
import 'package:dio/dio.dart'as dio;
import 'package:dio/dio.dart';
import 'package:panipura/core/hooks/hook.dart';


abstract class Apicalls {
  Future<dio.Response<dynamic>?> createlabour(Createlabreq value);

  Future<dio.Response<dynamic>?> createemp(Createlabreq value);

  Future<dio.Response<dynamic>?> login(Loginreq value);

  Future<dio.Response<dynamic>?> emplogin(Loginreq value);

  Future<dio.Response<dynamic>?> district();

  Future<dio.Response<dynamic>?> education();

  Future<dio.Response<dynamic>?> localbodytype();

  Future<dio.Response<dynamic>?> gender();

  Future<dio.Response<dynamic>?> localbodies(LocbodyReq value);

  Future<dio.Response<dynamic>?> occupations();

  Future<dio.Response<dynamic>?> addskill(Addrefskillreq value, String? locale);

  Future<dio.Response<dynamic>?> editskill(Addrefskillreq value, String? locale);

  Future<dio.Response<dynamic>?> getskill(Getskillreq value);

  Future<dio.Response<dynamic>?> searchlab(Searchlabourmdl value);

  Future<dio.Response<dynamic>?> viewProfile(Getskillreq value);

  Future<dio.Response<dynamic>?> deleteskill(Deletereq value);

  Future<dio.Response<dynamic>?> edithometwn(Edithmtwnreq value);

  Future<dio.Response<dynamic>?> otpresend(Otprsndreq value);

  Future<dio.Response<dynamic>?> empotpresend(Otprsndreq value);

  Future<dio.Response<dynamic>?> otpvrfy(Otpvrfyreq value);

  Future<dio.Response<dynamic>?> empotpvrfy(Otpvrfyreq value);

  Future<dio.Response<dynamic>?> forgotpswrd(Otprsndreq value);

  Future<dio.Response<dynamic>?> empforgotpswrd(Otprsndreq value);

  Future<dio.Response<dynamic>?> forgotpswrdvrfy(Rstpswrdvrfy value);

  Future<dio.Response<dynamic>?> empforgotpswrdvrfy(Rstpswrdvrfy value);

  Future<dio.Response?> dwonloaddb(String dbname);

  Future<dio.Response?> uploadimg(File? img, int? usrid, int typeid);

  Future<dio.Response?> rateskill(Ratingreqmdl value);

  Future<dio.Response?> delrate(int? rateId);

  Future<dio.Response?> getrateskill(Getskillratereq value);

  Future<dio.Response?> addtodolist(Addtodolist value);

  Future<dio.Response?> gettodolist(int? userId);

  Future<dio.Response?> deletetodolist(Deletetodoreq value);

  Future<dio.Response?> edittodolist(Addtodolist value, int? todoId);

  Future<dio.Response?> contactlog(Contactlog value);

  // Future<Response?> dwnldimg(int? usrid);
  Future<dio.Response?> deleteuser(int? usrid);

  Future<dio.Response?> deleteEmp(int? usrid);
}

class Labourdata extends Apicalls {
  final dio.Dio dioclient = dio.Dio();
  final url = Url();

  Labourdata() {
    //dio.options.headers=Options(headers: {'"Authorization":"Bearer $token"'});
    dioclient.options = dio.BaseOptions(
      baseUrl: url.baseUrl,
      responseType: dio.ResponseType.plain,
    );
  }

  /*register category */
  @override
  Future<dio.Response<dynamic>?> createlabour(Createlabreq value) async {
    try {
      final result = await dioclient.post(
        url.registerUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /*employer register  */
  @override
  Future<dio.Response?> createemp(Createlabreq value) async {
    try {
      final result = await dioclient.post(
        url.empregisterUrl,
        data: value.toJson(),
      );
      return result;
    }on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /*login category */
  @override
  Future<dio.Response<dynamic>?> login(Loginreq value) async {
    try {
      final result = await dioclient.post(
        url.loginUrl,
        data: value.toJson(),
      );
      return result;
    }on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /*employer login  */
  @override
  Future<dio.Response<dynamic>?> emplogin(Loginreq value) async {
    try {
      final result = await dioclient.post(
        url.emploginUrl,
        data: value.toJson(),
      );
      return result;
    }on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /*district */
  @override
  Future<dio.Response<dynamic>?> district() async {
    try {
      final result = await dioclient.get(
        url.districtUrl,
      );
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /*Education */
  @override
  Future<dio.Response<dynamic>?> education() async {
    try {
      final result = await dioclient.get(
        url.educationUrl,
      );
      //final resultAsjson = jsonDecode(result.data);
      // final Distlist= DistrictmodelList.fromJson(_resultAsjson);
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /*LOCALBODYTYPE */
  @override
  Future<dio.Response<dynamic>?> localbodytype() async {
    try {
      final result = await dioclient.get(
        url.loclbdytypeUrl,
      );

      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /*Gender */
  @override
  Future<dio.Response<dynamic>?> gender() async {
    try {
      final result = await dioclient.get(
        url.genderUrl,
      );
      //final resultAsjson = jsonDecode(result.data);
      // final Distlist= DistrictmodelList.fromJson(_resultAsjson);
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* localbodies */
  @override
  Future<dio.Response<dynamic>?> localbodies(LocbodyReq value) async {
    try {
      final result = await dioclient.get(
        url.localbodiesUrl,
        data: value.toJson(),
      );
      return result;
    }on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /* occupations */
  @override
  Future<dio.Response<dynamic>?> occupations() async {
    try {
      final result = await dioclient.get(
        url.occupationUrl,
      );
      //final resultAsjson = jsonDecode(result.data);
      // final Distlist= DistrictmodelList.fromJson(_resultAsjson);
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /* addskill */
  @override
  Future<dio.Response<dynamic>?> addskill(
      Addrefskillreq value, String? locale) async {
    //print(value);
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post('${url.addskillUrl}/$locale',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
  /* *************************************** */

  /* edit skill */

  @override
  Future<dio.Response<dynamic>?> editskill(
      Addrefskillreq value, String? locale) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post('${url.editskillUrl}/$locale',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
  /* *************************************** */

  /* getskill */

  @override
  Future<dio.Response<dynamic>?> getskill(Getskillreq value) async {
    final usrid = value.userId;
    final localecd = value.locale;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post('${url.getskillUrl}/$usrid/$localecd',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /* searchlab */
  @override
  Future<dio.Response<dynamic>?> searchlab(Searchlabourmdl value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.searchlabUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  /* *************************************** */

  /* *************************************** */
  @override
  Future<dio.Response<dynamic>?> viewProfile(Getskillreq value) async {
    final usrid = value.userId;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post('${url.viewProfileUrl}/$usrid',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> deleteskill(Deletereq value) async {
    final usrid = value.userId;
    final skillid = value.skillId;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.delete('${url.skilldeleteUrl}/$usrid/$skillid',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> edithometwn(Edithmtwnreq value) async {
    final usrid = value.userId;
    final place = value.place;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.put('${url.edithometwnUrl}/$usrid/$place',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> otpresend(Otprsndreq value) async {
    final type = value.type;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post('${url.otpresndUrl}/$type',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> empotpresend(Otprsndreq value) async {
    final type = value.type;
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post('${url.empotpresndUrl}/$type',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> otpvrfy(Otpvrfyreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.otpvrfUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> empotpvrfy(Otpvrfyreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.empotpvrfUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> forgotpswrd(Otprsndreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.forgotpwrdUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> empforgotpswrd(Otprsndreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.empforgotpwrdUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> forgotpswrdvrfy(Rstpswrdvrfy value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.resetpwrdvrfyUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> empforgotpswrdvrfy(Rstpswrdvrfy value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.resetemppwrdvrfyUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> dwonloaddb(String dbname) async {
    try {
      dio.Response result = await Dio().get(url.baseUrl + url.downloaddbUrl,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveDataWhenStatusError: true,
              //  connectTimeout:const Duration(seconds:30),
              receiveTimeout: const Duration(seconds: 30)
              //receiveTimeout: Duration.zero,
              ));

      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> uploadimg(File? img, int? usrid, int typeid) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;

    try {
      if (img != null) {
        String fileName = img.path.split('/').last;
        dio.FormData formdata = dio.FormData.fromMap({
          "file": await dio.MultipartFile.fromFile(img.path, filename: fileName),
          "user_id": usrid,
          "type_id": typeid
        });

        dio.Response result = await Dio().post(url.baseUrl + url.uploadUrl,
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
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
  Future<dio.Response?> rateskill(Ratingreqmdl value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.ratingUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> delrate(int? rateId) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.delete('${url.ratingUrl}/$rateId',
          //data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> getrateskill(Getskillratereq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    final userid = value.userId;
    final skillid = value.skillId;

    try {
      final result = await dioclient.get('${url.ratingUrl}/$userid/$skillid',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> addtodolist(Addtodolist value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.todolistaddUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> gettodolist(int? userId) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    //final userid = userId;
    //final skillid = value.skillId;

    try {
      final result = await dioclient.post('${url.todolistgetUrl}/$userId',
          // data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> deletetodolist(Deletetodoreq value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.delete(url.todolistdeleteUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> edittodolist(Addtodolist value, int? todoId) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.put('${url.todolistEditUrl}/$todoId',
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> contactlog(Contactlog value) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.post(url.contactlogUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> deleteuser(int? usrid) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.delete('${url.deleteuserUrl}/$usrid',
          //data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> deleteEmp(int? usrid) async {
    final userval = await Sharedata.instance.getdata();
    final token = userval!.token;
    try {
      final result = await dioclient.delete('${url.deleteEmpUrl}/$usrid',
          //data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
}
