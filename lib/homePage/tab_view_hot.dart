import 'package:flutter/material.dart';
import 'package:v2exflutter/components/list_view_spearated.dart';
import 'package:v2exflutter/api/hot/hot_topic.dart';

class TabViewHot extends StatefulWidget {
  @override
  _TabViewHotState createState() => _TabViewHotState();
}

class _TabViewHotState extends State<TabViewHot>
    with AutomaticKeepAliveClientMixin {
  List hotList;

  @override
  void initState() {
    super.initState();
    getHotList();
  }

  void getHotList() async {
    var response =
        await HotTopic.getHotTopic('/api/topics/hot.json', 'GET'); //list
    print('重新请求');
    setState(() {
      hotList = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListViewSpearated(hotList, getHotList);
  }

  @override
  bool get wantKeepAlive => true;
}
