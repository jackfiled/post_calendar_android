import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// 单独的DDL事件单元微件
class DDLCellWidget extends StatelessWidget {
  final void Function() onPressed;
  final List<Widget> slidableChildren;
  final String title;
  final DateTime endTime;
  final String details;

  const DDLCellWidget({
    Key? key,
    required this.onPressed,
    required this.slidableChildren,
    required this.title,
    required this.endTime,
    required this.details
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          border: Border.all(
              width: 2, color: const Color.fromARGB(122, 123, 123, 123))),
      child: GestureDetector(
        onTap: onPressed,
        child: Slidable(
          key: const ValueKey(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline5,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${endTime.year}年${endTime.month}月${endTime.day}日",
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  details,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            children: slidableChildren,
          ),
        ),
      ),
    );
  }
}
