
/// 表示用户信息的模型类
class UserInfo {
  int id;
  String userName;
  int studentID;
  int classNumber;

  UserInfo({required this.id,
    required this.userName,
    required this.studentID,
    required this.classNumber});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(id: json["id"],
        userName: json["userName"],
        studentID: json["studentID"],
        classNumber: json["classNumber"]);
  }

  int get classNumberShort => classNumber - 2021211000;
}
