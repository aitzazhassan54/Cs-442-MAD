// library_lab.dart - Campus Library System
// Name: Aitzaz-Ul-Hassan Roll no: 04072313026
const String rollNo = '04072313026'; // e.g. '21F-0347'
// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit
const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];
int yearOf(int i) => 1995 + 2 * i + t; // publication year of titles[i]
final int feePerDay = 5 + t; // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6; // normal number of days late
final int daysBig = 10 + u; // a long overdue period
final int feeCap = 150 + 10 * t; // no single fee may exceed this
final int renewLimit = 1 + t % 3; // renewals allowed per item
final int renewAttempts = 2 + u; // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4; // items on the shelf in Steps 9-10

// ===========================================================================
abstract class LibraryItem {
  final String title;
  final int year;
  LibraryItem(this.title, this.year);
  String describe() => '$title ($year)';
  int lateFee(int days);
}

class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;
  Book(super.title, super.year, this.pages);
  @override
  String describe() => '${super.describe()}, $pages pages';
  @override
  int lateFee(int days) => days * feePerDay;
  @override
  bool get isAvailable => !_out;
  @override
  void borrow() => _out = true;
  @override
  void giveBack() => _out = false;
}

class Magazine extends LibraryItem {
  final int issue;
  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';
  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

class Dvd extends LibraryItem with Renewable {
  final int minutes;
  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

Book mainBook() => Book(titles[u], yearOf(u), 100 + 3 * seed);

abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

mixin Renewable {
  int renewals = 0;
  bool renew(int limit) {
    if (renewals >= limit) return false;
    renewals++;
    return true;
  }
}

enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;
  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) => fee - (fee * discountPercent ~/ 100);
}

extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((w) => w[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) => fold(0, (sum, i) => sum + i.lateFee(days));
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');
  Book b = mainBook();
  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');

  LibraryItem item = b;
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // Think: Why is item.pages a compile error even though the object has pages?
  //  The compiler only checks the
  // variable's declared type (LibraryItem), which has no `pages` field.
  // The real object is a Book, but Dart only knows that at runtime.
}

void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // Think: What would happen if I forgot @override and mistyped the
  // method name as descibe()?
  // Dart would not complain. It
  // would just create a  new method called descibe(), and
  // describe() would still run the parent's version, so the output
  // would silently be wrong.
}

void step3() {
  print('--- Step 3 ---');
  print(
    'Step 3: Book late fee for $daysLate days = ${mainBook().lateFee(daysLate)}',
  );
  print(
    'Step 3: Magazine late fee for $daysLate days = ${mainMagazine().lateFee(daysLate)}',
  );
  print(
    'Step 3: Dvd late fee for $daysLate days = ${mainDvd().lateFee(daysLate)}',
  );

  // Think: Why can you not create an abstract class directly?
  // Try LibraryItem('x', 2000); once, read the error, then delete that line.
  //  an abstract class has methods with
  // no body (lateFee), so there would be nothing to run if you called
  // them. Only concrete subclasses that fill in every method can be created.
}

void step4() {
  print('--- Step 4 ---');
  Book book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (var item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }

  // Think: What would extends Borrowable have given you for free, and
  // why is that not what you wanted?
  //  extends would inherit working code
  // (fields and method bodies) from Borrowable, but Borrowable has no
  // code, only a promise. Also Book already has one parent
  // (LibraryItem), and Dart allows only one extends.
}

void step5() {
  print('--- Step 5 ---');
  Book book = mainBook();
  int ok = 0;
  for (int k = 0; k < renewAttempts; k++) {
    if (book.renew(renewLimit)) ok++;
  }
  print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  // Think: Book and Dvd need the same renew code but Magazine must not
  // have it. Why is a mixin a better fit than putting renew in LibraryItem?
  // anything in LibraryItem is inherited by
  // every subclass, including Magazine. A mixin lets me add the code
  // only to the classes that should have it, without a shared parent.
}

void step6() {
  print('--- Step 6 ---');
  final type = MemberType.values[seed % 3];
  final fee = mainBook().lateFee(daysLate);
  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print('Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');

  // Think: Why is MemberType.student safer than the string 'student'?
  //  a typo like 'studnet' in a string compiles
  // and fails silently at runtime, but a typo in MemberType.studnet is a
  // compile error. The enum also limits the choices to a fixed set.
}

void step7() {
  print('--- Step 7 ---');
  final type = MemberType.values[seed % 3];
  final fee = mainBook().lateFee(daysLate);
  final discounted = type.applyDiscount(fee);
  print('Step 7: ${discounted.rs}');

  final title = titles[u];
  print('Step 7: initials of "$title" = ${title.initials}');

  final List<LibraryItem> shelf = [mainBook(), mainMagazine(), mainDvd()];
  print(
    'Step 7: shelf fee for $daysLate days = ${shelf.totalLateFee(daysLate).rs}',
  );

  // Think: You could have written plain functions rs(int x). What do you
  // gain by writing 72.rs instead?
  //  it reads naturally, like a built-in
  // method, it chains left to right, and the editor autocompletes it on
  // any int, so it is easier to find and use than a separate function.
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
