import 'package:flutter/material.dart';

/// 一个DDL事件单元的显示微件
class DDLItemCell extends StatelessWidget {
  final String name;
  final String place;
  final String details;

  /// 设置标题的样式
  final nameTextStyle = const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 18,
    fontWeight:  FontWeight.bold
  );

  /// 设置地点和详情的样式
  final placeAndDetailsTextStyle = const TextStyle(
    color: Color.fromARGB(122, 139, 136, 136),
    fontSize: 14,
    fontWeight: FontWeight.normal
  );

  /// 构造函数
  /// 
  /// [name] DDL的名称
  /// 
  /// [place] DDL的地点
  /// 
  /// [details] DDL的详情
  const DDLItemCell({
    Key? key,
    required this.name,
    required this.place,
    required this.details
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          name,
          style: nameTextStyle,
          maxLines: 1,// 标题只显示一行
          overflow: TextOverflow.ellipsis // 多余的用省略号代替
        ),
        Text(
          place,
          style: placeAndDetailsTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis
        ),
        Text(
          details,
          style: placeAndDetailsTextStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis
        )
      ],
    );
  }
}