/// DDL状态枚举
enum DDLStatus {
  /// 未完成
  todo,

  /// 已完成
  finished,

  /// 已过期
  outdated,

  /// 已删除
  deleted
}
