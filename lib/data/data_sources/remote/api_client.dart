import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:frenly_app/presentation/auth/login_screen/login_screen.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../core/constants/app_dialogs.dart';
import '../../../core/utils/pref_utils.dart';
import 'package:get/route_manager.dart';
import '../../../presentation/auth/no_internet/no_internet.dart';

class ApiClient {
  //live
   static const String mainUrl = "https://www.frenly.se:4000/";

  //local
 // static const String mainUrl = "http://192.168.29.177:3001/";

  late Dio dio;
  late BaseOptions baseOptions;
  late Options options;

  ApiClient() {
    baseOptions = BaseOptions(
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        baseUrl: mainUrl);
    dio = Dio(baseOptions);
    options = Options(headers: {"Authorization": "Bearer ${PrefUtils().getAuthToken()}"});
    dio.interceptors.add(PrettyDioLogger(requestBody: true, requestHeader: true));
  }

  /// get Request


  Future<dynamic> getRequest({required String endPoint}) async {
    try {
      Response<dynamic> response = await dio.get(endPoint, options: options);
      return _processResponse(response);
    }  on DioException catch (e) {
      Response<dynamic> response = createErrorEntity(e);
      return _processResponse(response);
    }
  }

  /// postRequest

  Future<dynamic> postRequest({required String endPoint, required dynamic body}) async {
    try {
      Response<dynamic> response = await dio.post(endPoint, data: body, options: options);
      return _processResponse(response);
    } on DioException catch (e) {
      Response<dynamic> response = createErrorEntity(e);
      return _processResponse(response);
    }
  }



  /// delete Request

  Future<dynamic> deleteRequest({required String endPoint, required dynamic body}) async {
    try {
      Response<dynamic> response = await dio.delete(endPoint, data: body, options: options);
      return _processResponse(response);
    } on DioException catch (e) {
      Response<dynamic> response = createErrorEntity(e);
      return _processResponse(response);
    }
  }


 Future<dynamic> patchRequest({required String endPoint, required dynamic body}) async {
    try {
      Response<dynamic> response = await dio.patch(endPoint, data: body, options: options);
      return _processResponse(response);
    } on DioException catch (e) {
      Response<dynamic> response = createErrorEntity(e);
      return _processResponse(response);
    }
  }



}

Response createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 400:
          return error.response!;
        case 401:
          return error.response!;
        case 404:
          return Response(data: {
            'message': 'Url Not Found',
            "statusCode": 404,
          }, statusCode: 404, requestOptions: RequestOptions());
        case 500:
          return error.response!;
      }
      return error.response!;

    case DioExceptionType.connectionError:
      Get.offAll(()=>NoInternetScreen());
      return Response(data: {
        'message':
            'Network connection error. Please check your internet connection.',
        "statusCode": -6,
      }, statusCode: -6, requestOptions: RequestOptions());

    case DioExceptionType.connectionTimeout:
      return Response(data: {
        'message': 'Connection timed out',
        "statusCode": -1,
      }, statusCode: -1, requestOptions: RequestOptions());

    case DioExceptionType.sendTimeout:
      return Response(data: {
        'message': 'Send timed out',
        "statusCode": -2,
      }, statusCode: -2, requestOptions: RequestOptions());

    case DioExceptionType.receiveTimeout:
      return Response(data: {
        'message': 'Receive timed out',
        "statusCode": -3,
      }, statusCode: -3, requestOptions: RequestOptions());

    case DioExceptionType.badCertificate:
      return Response(data: {
        'message': 'Bad SSL certificates',
        "statusCode": -4,
      }, statusCode: -4, requestOptions: RequestOptions());

    case DioExceptionType.cancel:
      return Response(data: {
        'message': 'Server canceled it',
        "statusCode": -5,
      }, statusCode: -5, requestOptions: RequestOptions());

    case DioExceptionType.unknown:
      return Response(data: {
        'message': 'Unknown error',
        "statusCode": -7,
      }, statusCode: -7, requestOptions: RequestOptions());

    default:
      return Response(data: {
        'message': 'Unknown error',
        "statusCode": -8,
      }, statusCode: -8, requestOptions: RequestOptions());
  }
}

Future<Map<String, dynamic>?> _processResponse(
    Response<dynamic> response) async {
  print("response===>${response.data} ");
  switch (response.statusCode) {
    case 200:
      return response.data;
    case 201:
      return response.data;
    case 400:
      AppDialog.taostMessage("${response.data["message"]}", );
      print("fdsffsfsfsf");
      return Future.value(null);
    case 401:
      // PrefUtils().logout();
      // Get.offAll(()=>LoginScreen());
      print("response===>401${response.data} ");
      return Future.value(null);
      case 403:
      PrefUtils().logout();
      Get.offAll(()=>const LoginScreen());
      print("response===>401${response.data} ");
      return Future.value(null);

    case 404:
      return Future.value(null);

    case 500:
      print("${response.data}");
      AppDialog.taostMessage("${response.data["message"]}");
      return Future.value(null);
    case 204:
      var responseJson = jsonDecode(response.data);
      return responseJson;

    case -6:
      AppDialog.taostMessage("${response.data["message"]}");
      return Future.value(null);

    case -1:
      AppDialog.taostMessage("${response.data["message"]}");
      return Future.value(null);

    default:
      print("defaultdefaultdefaultdefault${response.data}");
      //var responseJson = jsonDecode(response.data);
      return Future.value(null);
  }
}


extension IntToSizedBox on int {
  SizedBox get toSizedBox {
    return SizedBox(
      width: this.toDouble(),
      height: this.toDouble(),
    );
  }
}

