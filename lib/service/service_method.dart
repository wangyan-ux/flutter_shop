import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url_.dart';
Future getHomePageContent()async{
  try {
Response response;
Dio dio=new Dio();
dio.options.contentType= Headers.formUrlEncodedContentType;
var formData={'lon':'115.02932','lat':'35.76189'};
response=await dio.post(servicePath['homePageContent'],data:formData,);
if (response.statusCode==200) {
  return response.data;
}else{
  throw Exception('后端接口出现异常');
}
  } catch (e) {
    return print('error==============>$e');
  }


}