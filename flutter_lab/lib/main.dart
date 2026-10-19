// main.dart - Study Tracker lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'AITZAZ-UL-HASSAN';
const String rollNo = '04072313026'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

final String course = courses[u]; // your course name
final int startCount = 3 + u; // where the tally starts
final int stepSize = 1 + t % 4; // how much + and - change the tally
final int maxCount = 20 + 2 * t; // the tally may never go above this
final int startSeconds = 5 + (t + u) % 6; // where the countdown starts
final int bugStep = 1 + u % 4; // used by BuggyCounter in Step 7
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
// Stateless: it only builds the app shell and holds nothing that changes.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Study Tracker', home: HomePage());
  }
}

// Stateless: it only lays out data it was given, nothing inside it changes.
// Think: runApp receives the root widget of the whole app (LabApp), which
// Flutter attaches to the screen. MaterialApp receives `home`, the first
// page shown inside the app, here HomePage.
// Think (widget tree): LabApp > MaterialApp > HomePage > Scaffold >
// SingleChildScrollView > Column > Row > Text('Max: ..').
// Counting LabApp as level 1, the Max Text is 8 levels deep.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Study Tracker: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentCard(name: studentName, roll: rollNo, course: course),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('info-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max')),
              ],
            ),
            const SizedBox(height: 12),
            const Tally(),
            const SizedBox(height: 12),
            const Countdown(),
            const SizedBox(height: 12),
            const BuggyCounter(),
          ],
        ),
      ),
    );
  }
}

// Stateless: it only shows the name, roll and course it was given.
// Think: the fields are final because a StatelessWidget is immutable. Flutter
// can rebuild or reuse it at any time, so its data must never change. Without
// final, the analyzer warns that a class marked @immutable has non-final fields.
class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  final String name;
  final String roll;
  final String course;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }
}

// Stateless: it only displays the count and max it was given.
// Think: GoalBanner needs no setState because it holds no changing data of
// its own; it just draws its inputs. To show a new count, its parent must
// rebuild it with a new `count` value (a new GoalBanner(count: ...)).
class GoalBanner extends StatelessWidget {
  const GoalBanner({super.key, required this.count, required this.max});

  final int count;
  final int max;

  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;
    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }
}

// Stateful: the count changes when the user taps, so it needs memory.
// Think: the Tally widget itself is only immutable configuration. The
// changing _count lives in the separate State object, which survives
// rebuilds. Two classes let Flutter recreate the cheap widget freely
// while keeping the State (the memory) alive.
class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

// Think (hot reload vs restart): hot reload keeps the State object, so the
// count stays 12; only the widget code (configuration) is swapped in.
// Hot restart throws away all State and rebuilds from scratch, so _count
// goes back to startCount (9).
class _TallyState extends State<Tally> {
  int _count = startCount;

  void _plus() {
    setState(() {
      _count += stepSize;
      if (_count > maxCount) _count = maxCount;
    });
  }

  void _minus() {
    setState(() {
      _count -= stepSize;
      if (_count < 0) _count = 0;
    });
  }

  void _reset() {
    setState(() {
      _count = startCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),
        GoalBanner(count: _count, max: maxCount),
        Row(
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              key: const Key('minus'),
              onPressed: _minus,
              child: Text('-$stepSize'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              key: const Key('reset'),
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// ---- Provided for Step 7. It has a bug on purpose. Do not rename anything.
// Stateful: it holds _clicks, which changes on every tap.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

// Think: before the fix, after 3 taps _clicks inside the State was 9
// (3 taps x bugStep 3), but the screen still showed 0, because without
// setState Flutter was never told to call build again.
class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Bug clicks: $_clicks', key: const Key('bug-text')),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            setState(() {
              _clicks += bugStep;
            });
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}

// Stateful: the remaining seconds change every second, so it needs memory.
class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

// // Think: if _timer.cancel() is missing from dispose and the widget is
// // removed, the Timer keeps firing and calls setState() on a disposed State.
// // The console shows "setState() called after dispose()" (a FlutterError),
// // and the timer also leaks memory.
// class _CountdownState extends State<Countdown> {
//   late int _left;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _left = startSeconds;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() => _left--);
//       if (_left <= 0) timer.cancel(); // stop at zero
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_left > 0) {
//       return Text('Time left: $_left s', key: const Key('time-left'));
//     }
//     return const Text('Time is up!', key: Key('time-left'));
//   }
// }

// Think: Builds goes up by one per second, not two, because each timer tick
// calls setState exactly once, and each setState triggers exactly one build.
// To prove dispose ran, print lifecycleLog (for example with
// debugPrint(lifecycleLog.toString()) in dispose, or show it in a Text).
class _CountdownState extends State<Countdown> {
  late int _left;
  late Timer _timer;
  int _builds = 0;

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState');
    _left = startSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _left--);
      if (_left <= 0) timer.cancel(); // stop at zero
    });
  }

  @override
  void dispose() {
    lifecycleLog.add('dispose');
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _left > 0
            ? Text('Time left: $_left s', key: const Key('time-left'))
            : const Text('Time is up!', key: Key('time-left')),
        Text('Builds: $_builds', key: const Key('builds')),
      ],
    );
  }
}
