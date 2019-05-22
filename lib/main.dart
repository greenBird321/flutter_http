import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_demo/shared_preferences.dart';
import 'package:http_demo/list.dart';
import 'package:http_demo/ExpansionTile.dart';
import 'package:http_demo/gridViewDemo.dart';
import 'package:http_demo/refreshIndicator.dart';

void main() => runApp(refreshDemo());

class MyApp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  String showResult = '';

  Future<CommonModel> fetchGet() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    Utf8Decoder utf8decoder = Utf8Decoder(); // 解决返回中文展示乱码的问题
    final result = json.decode(utf8decoder.convert(response
        .bodyBytes)); // TODO: Utf8Decoder convert 必须修改response的bodyBytes
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('http_demo'),
      ),
      body: FutureBuilder<CommonModel>(
          future: fetchGet(),
          builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
            switch (snapshot.connectionState) {
              // 判断网络返回状态
              case ConnectionState.none:
                return Text('Input a URL to Start');

              case ConnectionState.waiting:
                return Center(
                  child: new CircularProgressIndicator(),
                ); // 如果是等待状态则展示一个等待指示器

              case ConnectionState.active:
                return Text('');

              case ConnectionState.done:
                if (snapshot.hasError) {
                  // 注意在请求完成之后，需要判断是否有错误 有过有错误则展示错误
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  );
                } else {
                  return new Column(
                    children: <Widget>[
                      Text('icon: ${snapshot.data.icon}'),
                      Text('statusBarColor: ${snapshot.data.statusBarColor}'),
                      Text('title: ${snapshot.data.title}'),
                      Text('url: ${snapshot.data.url}'),
                      Text('hideAppBar: ${snapshot.data.hideAppBar}')
                    ],
                  );
                }
            }
          }),
    ));
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
