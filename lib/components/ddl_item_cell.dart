import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/routes/route_config.dart';

/// 一个DDL事件单元的显示微件
class DDLItemCell extends StatelessWidget {
  final DDLModel item;

  /// 设置标题的样式
  final nameTextStyle = const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 28,
      fontWeight: FontWeight.bold);

  /// 设置地点和详情的样式
  final placeAndDetailsTextStyle = const TextStyle(
      color: Color.fromARGB(122, 139, 136, 136),
      fontSize: 20,
      fontWeight: FontWeight.normal);

  const DDLItemCell({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点击事件跳转到详情界面
        Get.toNamed(RouteConfig.ddlMorePage + "?id=${item.id}");
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(width: 2, color: Colors.grey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(item.name,
                  style: nameTextStyle,
                  maxLines: 1, // 标题只显示一行
                  overflow: TextOverflow.ellipsis // 多余的用省略号代替
                  ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(item.place,
                        style: placeAndDetailsTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Text(item.details,
                      style: placeAndDetailsTextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
