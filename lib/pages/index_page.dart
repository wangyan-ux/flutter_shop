import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './home_page.dart';
import './category_page.dart';
import './member_page.dart';
import './shpping_car_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem>_bottom=[
    BottomNavigationBarItem(  
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(  
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
    ),
    BottomNavigationBarItem(  
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车')
    ),
    BottomNavigationBarItem(  
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心')
    ),
  ];
  final List<Widget> tabBodies=[
    HomePage(),
    CategoryPage(),
    MemberPage(),
    ShoppingCarPage()
  ];
  int _currentIndex=0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottom,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
        ),
        body: IndexedStack(
          index: _currentIndex,
          children:tabBodies,
        ),
    );
  }
}