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
}
