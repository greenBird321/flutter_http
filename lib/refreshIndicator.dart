import 'package:flutter/material.dart';

class refreshDemo extends StatefulWidget {
  @override
  _refreshDemoState createState() => _refreshDemoState();
}

class _refreshDemoState extends State<refreshDemo> {
  List<String> cityNames = [
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

  // 只有controller才能添加listener
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      // 滚动位置达到最底端
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('高级ListView使用方法(增加下拉刷新与上拉加载)'),
        ),
        body: RefreshIndicator(
          child: ListView(
            controller: _scrollController,    // controller 相关联
            children: _buildList(),
          ),
          onRefresh: _handleRefresh, // onRefresh方法
        ),
      ),
    );
  }

  //TODO: 上拉加载 耗时操作
  _loadData() async {
    await Future.delayed(Duration(milliseconds: 200));
    // 复制数组
    List<String> list = List<String>.from(cityNames);
    // 将list追加到复制中的数组
    list.addAll(cityNames);
    setState(() {
      // 修改数据源
      cityNames = list;
    });
  }

  //TODO: onRefresh方法需要一个返回Future 由于加载是耗时操作，需要使用async,await 下拉刷新
  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    //修改显示
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
  }

  List<Widget> _buildList() {
    return cityNames.map((city) => _buildItem(city)).toList();
  }

  Widget _buildItem(String name) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        name,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
