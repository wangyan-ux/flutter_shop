import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class GetRequestPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      body: Center(
      child: Text('首页')
      ),
    );
  }
}
void getHttp()async{
  try{
    Response response;
    response=await Dio().get('https://www.easy-mock.com/mock/5e3d051a09081a7abce27fc3/example/post_wang');
   return print(response.data);
  }catch(e){
     return print(e);
  }
}


