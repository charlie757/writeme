import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'constant.dart';
import 'util.dart';


class NetworkHelper {

  String urlStr = "";
  NetworkHelper(this.urlStr);


  Future<String> getServerResponse(var body) async {

    Util.showLoader();

    print("URL:"+urlStr);
    print("Body:-"+body.toString());

    String responseStr = "";
    try {
      var dio = Util.getDiaObject();
      dio.options.headers["lang"] = Util.isEnglishLan() ? "en" : "de";

      var response = await dio.post(urlStr, data: body);
      responseStr = response.toString();


    }on DioError catch (e) {
      String msg = "something_went_wrong".tr;//e.message;
      responseStr = "{\"success\":0, \"message\":\"$msg\"}";

        print(e.message);
    }
    return responseStr;
  }

  Future<String> getServerResponseWithHeader(var body, var token) async {

    Util.showLoader();

    print("URL:"+urlStr);
    print("Body:-"+body.toString());

    String responseStr = "";
    try {
      var dio = Util.getDiaObject();

      dio.options.headers["authorization"] = "bearer ${token}";
      dio.options.headers["lang"] = Util.isEnglishLan() ? "en" : "de";

      var response = await dio.post(urlStr, data: body,);
      responseStr = response.toString();


    }on DioError catch (e) {
      String msg = "something_went_wrong".tr;//e.message;
      responseStr = "{\"status\":0, \"message\":\"$msg\"}";

      print(e.message);
    }
    return responseStr;
  }

  Future<String> getServerResponseWithGET(var token) async {

    Util.showLoader();

    print("URL:"+urlStr);

    String responseStr = "";
    try {
      var dio = Util.getDiaObject();

      dio.options.headers["authorization"] = "bearer ${token}";
      dio.options.headers["lang"] = Util.isEnglishLan() ? "en" : "de";

      var response = await dio.get(urlStr);
      responseStr = response.toString();


    }on DioError catch (e) {
      String msg = "something_went_wrong".tr;//e.message;
      responseStr = "{\"success\":0, \"message\":\"$msg\"}";

      print(e.message);
    }
    return responseStr;
  }

  Future<String> sendFCMNotification(var body) async {

    // Util.showLoader();

    print("URL:"+urlStr);
    print("Body:-"+body.toString());

    String responseStr = "";
    try {
      var dio = Util.getDiaObject();
      dio.options.headers["authorization"] = "key=${Constants.FCMSERVERKEY}";
      var response = await dio.post(Constants.FCMURL, data: body,);
      responseStr = response.toString();


    }on DioError catch (e) {
      String msg = "something_went_wrong".tr;//e.message;
      responseStr = "{\"status\":0, \"message\":\"$msg\"}";

      print(e.message);
    }
    return responseStr;
  }

}