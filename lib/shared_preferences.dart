import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedDemo extends StatefulWidget {
  @override
  SharedDemoState createState() => SharedDemoState();
}

class SharedDemoState extends State<SharedDemo> {
  String countString = ''; // 点击增加后的次数记录
  String localCount = ''; // 本地存储的次数记录

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('本地存储(shared_preferences)'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _incrementCounter,
              child: Text('Increment  Counter'),
            ),
            RaisedButton(
              onPressed: _getCounter,
              child: Text('Get Counter'),
            ),
            // 显示结果集
            Text(
              countString,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              localCount,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  // 累加+存入到本地数据库
  _incrementCounter() async {
    // 实例化本地存储插件
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      countString += ' 1';
    });
    // 从本地的存储中获取数据，并执行+1次的操作
    int counter = (preferences.getInt('counter') ?? 0) + 1;
    await preferences.setInt('counter', counter);
  }

  // 获取本地数据库数据
  _getCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      localCount = preferences.getInt('counter').toString();
    });
  }
}
