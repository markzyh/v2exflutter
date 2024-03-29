import 'package:v2exflutter/utils/http_request.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'hot_topic.g.dart';

@JsonSerializable()
class TopHot {
  HotMember member;
  HotNode node;
  String title, url;
  @JsonKey(name: "last_reply_by")
  String lastReplyBy;

  @JsonKey(name: "last_touched")
  num lastTouched;

  num replies;
  TopHot(this.node, this.member, this.title, this.url, this.lastReplyBy,
      this.lastTouched, this.replies);

  factory TopHot.fromJson(Map<String, dynamic> json) => _$TopHotFromJson(json);
  Map<String, dynamic> toJson() => _$TopHotToJson(this);
}

class HotList {
  final List<TopHot> hotList;

  HotList({
    this.hotList,
  });

  factory HotList.fromJson(List<dynamic> parsedJson) {
    List<TopHot> hotList = List<TopHot>();
    hotList = parsedJson.map((i) => TopHot.fromJson(i)).toList(); //转换为list
    return HotList(
      hotList: hotList,
    );
  }
}

@JsonSerializable()
class HotNode {
  String title;
  HotNode(this.title);

  factory HotNode.fromJson(Map<String, dynamic> json) =>
      _$HotNodeFromJson(json);
  Map<String, dynamic> toJson() => _$HotNodeToJson(this);
}

@JsonSerializable()
class HotMember {
  @JsonKey(name: "avatar_normal")
  String avatarNormal;
  String username;
  HotMember(this.username, this.avatarNormal);

  factory HotMember.fromJson(Map<String, dynamic> json) =>
      _$HotMemberFromJson(json);
  Map<String, dynamic> toJson() => _$HotMemberToJson(this);
}

class HotTopic {
  static getHotTopic(url, method) async {
    var response = await HttpRequest.httpRequest(url, method: method);
    var jsonResponse = json.decode(response.toString()); //反序列化
    HotList hotList = HotList.fromJson(jsonResponse);
    return hotList.hotList;
  }
}
