import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive=>true;
  @override
  Widget build(BuildContext context) {
        super.build(context);

    return Scaffold(
      appBar: AppBar(title: Text('莫宇晗的小主场~')),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigators = (data['data']['category'] as List).cast();
            String adpicture=(data['data']['advertesPicture']['PICTURE_ADDRESS']);
            String leadImg=(data['data']['shopInfo']['leaderImage']);
            String leadNum=(data['data']['shopInfo']['leaderPhone']); 
            List<Map> products = (data['data']['recommend'] as List).cast();
            String titleImg1=(data['data']['floor1Pic']['PICTURE_ADDRESS']);
            String titleImg2=(data['data']['floor2Pic']['PICTURE_ADDRESS']);
            String titleImg3=(data['data']['floor3Pic']['PICTURE_ADDRESS']);
            List<Map> floorImg1 = (data['data']['floor1'] as List).cast();
            List<Map> floorImg2 = (data['data']['floor2'] as List).cast();
            List<Map> floorImg3 = (data['data']['floor3'] as List).cast();
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
                child: Column(
                children: <Widget>[
                  SwiperDly(swiperDateList: swiper),
                  TopNavigator(navigatorData: navigators),
                   SmallGray(),
                  AdPicture(adPicture: adpicture,),
                  LeaderPhone(leaderImage: leadImg,phoneNumber: leadNum,),
                  ProductionShow(pdData: products,),
                  FloorTitle(titleImg:titleImg1),
                  FloorBody(floordata:floorImg1),
                  FloorTitle(titleImg:titleImg2),
                  FloorBody(floordata:floorImg2),
                  FloorTitle(titleImg:titleImg3),
                  FloorBody(floordata:floorImg3)

                 
                  ],
              ),
            );
          } else {
            return Center(
              child: Text(
                '加载中',
                style: TextStyle(fontSize: ScreenUtil().setSp(28)),
              ),
            );
          }
        },
      ),
    );
  }
}

//首页轮播组件

class SwiperDly extends StatelessWidget {
  final List swiperDateList;
  SwiperDly({Key key, this.swiperDateList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperDateList.length,
        itemBuilder: (context, index) {
          return Image.network(
            '${swiperDateList[index]['image']}',
            fit: BoxFit.cover,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//导航区组件
class TopNavigator extends StatelessWidget {
  final List navigatorData;
  TopNavigator({Key key, this.navigatorData}) : super(key: key);
  Widget _gridItemUI(item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(navigatorData.length>8){
      navigatorData.removeLast();
    }
    return Container(
      padding: EdgeInsets.all(3.0),
      height: ScreenUtil().setHeight(350),
      child: GridView.count(
        crossAxisCount: 4,
        physics: new NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(3.0),
        children: navigatorData.map((item) {
          return _gridItemUI(item);
        }).toList(),
      ),
    );
  }
}
//小灰条
class SmallGray extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:20,bottom: 5),
      height:ScreenUtil().setHeight(10),
      color: Colors.black12,
    );
  }
}

//广告条组件
class AdPicture extends StatelessWidget {
  final String adPicture;
  const AdPicture({Key key,this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Center(
        child: Image.network(adPicture),
      ),
    );
  }
}

//拨打店长电话模块
class LeaderPhone extends StatelessWidget {
  const LeaderPhone({Key key,this.leaderImage,this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  final String leaderImage;
  _launchURL() async {
  String url = 'tel:'+ phoneNumber;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }
}

//商品展示模块

class ProductionShow extends StatelessWidget {
  final List pdData;
  const ProductionShow({Key key,this.pdData}) : super(key: key);
  Widget _title(){
    return Container( 
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 0.5
          )
        )
      ),
      child: Text('商品推荐',style: TextStyle(color:Colors.pink),),
    );
  }
  Widget _item(index){
    return InkWell (
      onTap: (){},
        child: Container( 
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color:Colors.white,
          border: Border(
            bottom: BorderSide(width:0.5,color:Colors.black12),
            left: BorderSide(width:0.5,color:Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(pdData[index]['image'],fit:BoxFit.cover),
            Text('￥${pdData[index]['price']}'),
            Text('￥${pdData[index]['mallPrice']}',style: TextStyle(decoration:TextDecoration.lineThrough,color: Colors.grey)),

          ],
        ),
      ),
    );
  }
  Widget _listView(){
   return Container(
       height: ScreenUtil().setHeight(347),
       child: ListView.builder(
       itemCount: pdData.length,
       scrollDirection: Axis.horizontal,
       itemBuilder: (BuildContext context, int index) {
       return _item(index);
      },
     ),
   );

  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(410),
        margin: EdgeInsets.only(top:10.0),
        child: Column(
    children: <Widget>[
      _title(),
      _listView()
    ],
        ),
      );
  }
}


class FloorTitle extends StatelessWidget {
  final String titleImg;
  FloorTitle ({Key key,this.titleImg}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell( 
        onTap: (){},
        child: Image.network(titleImg),
      ),
    );
  }
}

class FloorBody extends StatelessWidget {
 final List floordata;
  const FloorBody({Key key,this.floordata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(  
        children: <Widget>[
         Row(
           children: <Widget>[
             _floorItem(floordata[0]),
             Column(
               children: <Widget>[
                 _floorItem(floordata[1]),
                 _floorItem(floordata[2])
               ],
             ),
             
           ],
         ),
         Row(
               children: <Widget>[
                 _floorItem(floordata[3]),
                 _floorItem(floordata[4])
               ],
             )
        ],
      ),
    );
  }
Widget _floorItem(item){
  return Container(
    width: ScreenUtil().setWidth(375),
    child: InkWell( 
      child: Image.network(item['image']),
      onTap: (){},
    ),
  );
}


}