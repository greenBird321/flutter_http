import 'package:flutter/material.dart';

const CITY_NAMES = [
  '北京',
  '上海',
  '广州',
  '深圳',
  '杭州',
  '苏州',
  '台湾',
  '成都',
  '武汉',
  '郑州',
  '洛阳',
  '厦门',
  '青岛',
  '拉萨'
];

class ListDemo extends StatefulWidget {
  ListDemoState createState() => ListDemoState();
}

class ListDemoState extends State<ListDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('List组件详解'),
        ),
        body: Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildList(),
          ),
        )
      ),
    );
  }

  List<Widget> _buildList() {   // 此处必须指定返回类型，否则程序报错误，返回的是List<dynamic> 类型，并不是List<Widget>类型
    return CITY_NAMES
        .map((city) => _item(city))
        .toList(); // children用一个List<widget>, 所以需要.toList()
  }

  Widget _item(String city) {
    return Container(
      //height: 80.0,
      width: 160,
      margin: EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
