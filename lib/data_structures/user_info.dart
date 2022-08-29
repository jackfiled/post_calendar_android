import 'dart:convert';

/// 表示用户信息的模型类
class UserInfo {
  String userName;
  int studentID;
  int classNumber;

  UserInfo(
      {required this.userName,
      required this.studentID,
      required this.classNumber});

  int get classNumberShort => classNumber - 2021211000;

  factory UserInfo.fromJson(String json) {
    final jsonMap = jsonDecode(json);

    return UserInfo(
        userName: jsonMap["username"] as String,
        studentID: jsonMap["student_id"] as int,
        classNumber: jsonMap["class_number"] as int);
  }

  String toJson() {
    final jsonMap = <String, dynamic>{
      "username": userName,
      "student_id": studentID,
      "class_number": classNumber,
    };

    return jsonEncode(jsonMap);
  }
}
