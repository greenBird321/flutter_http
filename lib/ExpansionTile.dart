import 'package:flutter/material.dart';

const CITY_NAMES = {
  // 如果想要使用ExpansionTile组件 数据格式必须遵循这样
  '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
  '上海': ['黄埔区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
  '广州': ['越秀', '海珠', '荔湾', '天河', '白云', '黄埔', '南沙', '番禺'],
  '深圳': ['南山', '福田', '罗湖', '盐田', '龙岗', '宝安', '龙华'],
  '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
  '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区']
};

class CityDemo extends StatefulWidget {
  @override
  CityDemoState createState() => CityDemoState();
}

class CityDemoState extends State<CityDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('列表的展开与收起(ExpansionTile的使用)'),
        ),
        body: ListView(
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> widgets = []; // 保存EXpansionTile组件的数组
    CITY_NAMES.keys.forEach((city) {
      widgets.add(_item(city, CITY_NAMES[city]));
    });
    return widgets;
  }

  Widget _item(String city, List<String> subCities) {
    return ExpansionTile(
      title: Text(city, style: TextStyle(fontSize: 20, color: Colors.black54),),
      children: subCities.map((cities) {
        return FractionallySizedBox(    // 撑满一行的组件 FractionallySizedBox
          widthFactor: 1,
          alignment: Alignment.center,
          child: Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(color:Colors.lightBlueAccent),
            child: Text(cities),
          )
        );
      }).toList(),
    );
  }
}
