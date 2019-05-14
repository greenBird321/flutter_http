import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  String showResult = '';

  Future<CommonModel> fetchGet() async {
    final response = await http.get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    final result = json.decode(response.body);
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  Text('http_demo'),
        ),
        body: Column(
          children: <Widget>[
            InkWell(
              child: Text('Come on', style: TextStyle(fontSize: 26),),
              onTap: () {
                fetchGet().then((CommonModel value) {
                  setState(() {
                    showResult = '请求结果: \nhideAppBar: ${value.hideAppBar} \nicon: ${value.icon} \ntitle: ${value.title} \nurl: ${value.url} \nstatusBarColor: ${value.statusBarColor}';
                  });
                });
              },
            ),
            Text(showResult),
          ],
        ),
      )
    );
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