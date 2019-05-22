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

class gridViewDemo extends StatefulWidget {
  @override
  _gridViewDemoState createState() => _gridViewDemoState();
}

class _gridViewDemoState extends State<gridViewDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GridViewDemo'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,    // 纵向的分割线
          mainAxisSpacing: 1.0,     // 横向分割线
          children: _buildList(),
        ),
      ),
    );
  }
}

List<Widget> _buildList() {
  return CITY_NAMES.map((city) => _buildItem(city)).toList();
}

Widget _buildItem(String city) {
  return Container(
    height: 120,
    alignment: Alignment.center,
    decoration: BoxDecoration(color: Colors.teal),
    child: Text(
      city,
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    ),
  );
}
