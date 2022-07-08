import 'package:test/test.dart';

import 'package:post_calendar_android/network/squid_request.dart';

void main() {

  test("NetWork Json Text", () async {
    Map<String, dynamic> paras = {
      "class": "dddd",
      "noticeType": 0,
      "start": 0,
      "step": 20
    };
    final request = SquidRequest();

    final list = await request.getList(paras);

    for(var item in list){
      print(item.title);
    }

  });

}

