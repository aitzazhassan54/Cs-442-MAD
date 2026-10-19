Name: AITZAZ-UL-HASSAN
Roll no: 04072313026

A1: 5
A2: 8
A3: 9
A4: 37

B1: Stateless classes: LabApp, HomePage, StudentCard, GoalBanner, because they only display data they are given and nothing inside them changes. Stateful classes: Tally, Countdown, BuggyCounter, because they hold values that change (the count, the seconds left, the click number) and need a State object to remember them.
B2: The Timer keeps running after the widget is removed. If it is not cancelled in dispose(), it keeps firing, leaks memory, and calls setState() on a disposed State, which causes an error.
B3: Widgets whose arguments are compile-time constants can be const: const Tally(), const Countdown(), const BuggyCounter(), const SizedBox(...), const Text('Reset'). const widgets are created once and reused, so Flutter can skip rebuilding them, which saves memory and work.
