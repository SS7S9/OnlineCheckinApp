import 'package:dio/dio.dart';
class NetConfig {
  static String baseUrl = '';

  static Future post(String username, String name, String password,
      String passwordconf, String phone, String email) async {
    Response response;
    var dio = Dio();
    dio.options.baseUrl = baseUrl;
    String path = '';
    response = await dio
        .post(path, queryParameters: {'username': username, 'name': name,
        'password': password, 'passwordconf': passwordconf, 'phone': phone,
        'email': email, });
    print(response.data.toString());
    if(response.statusCode==200){
      return response;
    }else{
      return null;
    }
  }
}