import 'package:test/test.dart';

import 'package:post_calendar_android/network/course_info_request.dart';

void main() {
  test("Test the get courses function", () async {
    var courses =
        await CourseInfoRequest.getCourses("114514", "191980", "2021-2022-1");

    for (var course in courses) {
      print(course.toMap());
    }

    expect(courses.length, 183);
  });

  test("Test the get semesters function", () async {
    final semesters = await CourseInfoRequest.getSemesters();

    final list = <String>[];
    for (var semester in semesters) {
      list.add(semester.semester);
    }

    expect(list.contains("2021-2022-1"), true);
    expect(list.contains("2021-2022-2"), true);
    expect(list.contains("2022-2023-1"), true);
  });
}
