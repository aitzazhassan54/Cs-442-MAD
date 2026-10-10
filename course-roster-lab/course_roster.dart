/// Prints a welcome banner for the given app name.
void printWelcome(String appName) {
  print('=== $appName ===');
}

// void main() {
//   printWelcome('Course Roster Manager');
// }

// Part 2

void main() {
  printWelcome('Course Roster Manager');
  String generateCode(String title) =>
      title.substring(0, 2).toUpperCase() + '101';

  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();
  String courseTitle = 'CS201: Mobile App Development';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;
  List<String> enrolledStudents = ['Aitzaz', 'ahmad', 'Mehdi'];
  Set<String> waitlist = {'saqib', 'waseel'};
  Map<String, int> attendanceCount = {'Aitzaz': 3, 'ahmad': 4, 'Mehdi': 2};

  print(
    '$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}',
  );
  //part 3
  String? teacherEmail;
  print(teacherEmail ?? 'TBA');

  late String enrollmentCode;
  enrollmentCode = generateCode(courseTitle);
  print('Enrollment code: $enrollmentCode');

  print(teacherEmail?.length ?? 0);
  //part 4
  // ---------- Part 4: Formatting Strings ----------
  String rawNames = ' Aitzaz , Ahmad, Mehdi , abu bakr  ';
  List<String> cleanNames = [];
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }
  print(cleanNames);

  String courseDescription =
      '''
  $courseTitle
  Credit Hours: $creditHours
  Created At: $createdAt
  ''';
  print(courseDescription);
  print('Seats left: ${capacity - enrolledStudents.length}');

  // ---------- Part 5: Operators in Action ----------
  // ---------- Part 5: Operators in Action ----------
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;
  print('Full groups of 3: $fullGroups, leftover: $leftover');

  Object formInput = 'twenty-two';
  if (formInput is String) {
    print('This is text!');
  }
  if (formInput is! int) {
    print('This is definitely not an int!');
  }

  StringBuffer reportBuffer = StringBuffer();
  reportBuffer
    ..write('Report: $courseTitle')
    ..write(' | Cap: $capacity')
    ..write(' | Roster: ${enrolledStudents.length}');
  print(reportBuffer.toString());

  List<String>? extraNotes;
  extraNotes?..add('Room change pending');
  print('Extra notes: $extraNotes');

  int? bonusSeats;
  bonusSeats ??= 0;
  print('Bonus seats: $bonusSeats');

  if (isOpen && enrolledStudents.length < capacity) {
    print("You're in! Welcome aboard.");
  } else {
    print('Sorry, enrollment is closed or the course is full.');
  }

  int enrollmentStatusCode = 200;
  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown error');
      break;
  }

  String statusTag = isOpen ? 'OPEN' : 'FULL';
  print(statusTag);

  //  Part 7: Reports & Loops
  for (var student in enrolledStudents) {
    print(student);
  }

  attendanceCount.forEach((student, count) {
    print('$student: $count');
  });

  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL — waitlist open',
    for (var student in waitlist)
      'Reminder: $student, please confirm attendance',
  ];
  for (var announcement in announcements) {
    print(announcement);
  }
}
