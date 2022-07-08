import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:post_calendar_android/data_structures/squid_ddl_json.dart';

class SquidRequest {
  final http.Client _client = http.Client();

  static String getListUrl = "https://squidward.top/api/get_list";

  /// 访问接口获得数据
  /// 
  /// [parameters] 访问的参数
  Future<List<SquidDDLModel>> getList(Map<String, dynamic> parameters) async {
    http.Response response;

    // 如果没有请求参数
    if(parameters.isEmpty){
      response = await _client.get(Uri.parse(getListUrl));
    }else{

      var parameterString = "?";
      parameters.forEach((key, value) {
        if(value != null){
          parameterString += key + "=" + value.toString() + "&";
        }
      });

      response = await _client.get(
        // 这里需要干掉最后面的&
        Uri.parse(getListUrl + parameterString.substring(0, parameters.length - 1))
      );
    }

    final List jsonMaps = jsonDecode(utf8.decode(response.bodyBytes));

    return List<SquidDDLModel>.generate(jsonMaps.length, (index){
      return SquidDDLModel.fromJson(jsonMaps[index]);
    });
  }

  /// 将json数据转化为对象列表
  Future<List<SquidDDLModel>> convert2List(http.Response response) async {
    final List jsonMaps = jsonDecode(utf8.decode(response.bodyBytes));
    return List<SquidDDLModel>.generate(jsonMaps.length, (index) {
      return SquidDDLModel.fromJson(jsonMaps[index]);
    });
  }
}