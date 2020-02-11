import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
class GetDemo extends StatefulWidget {
  @override
  _GetDemoState createState() => _GetDemoState();
}

class _GetDemoState extends State<GetDemo> {
  TextEditingController _textEditingController=TextEditingController();
  String _text='欢迎来到前端高级会所';
   _choiceAction(){
  print('开始选择您喜欢的类型....');
  if (_textEditingController.text.toString()=='') {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('美女类型不能为空'),
      ),
    );
  }else{
    gethttp(_textEditingController.text.toString()).then((val){
      setState(() {
        _text=val['data']['name'];
      });
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('美好人间')
      ),
          body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller:_textEditingController ,
              decoration: InputDecoration(
                helperText: '请输入你喜欢的类型',
                labelText: '美女类型'
              ),
            ),
            RaisedButton(
              child: Text('选择完毕'),
              onPressed: _choiceAction
              ),
              Text('$_text')
          ],
        ),
      ),
    );
  }
}

Future gethttp(String text) async{
try {
  Response response;
  var data={'name':text};
  response=await Dio().get('https://www.easy-mock.com/mock/5e3d051a09081a7abce27fc3/example/post_wang',
  queryParameters: data
  );
  return response.data;
} catch (e) {
 return print(e);
}

}

