# Layout Lab: Team Board

Name: Aitzaz Ul Hassan
Roll no: 04072313026

A1: 21
A2: 7
A3: 4
A4: 75

## B1: Stateless and Stateful classes

Stateless: LabApp, HomePage, SettingsCard, SummaryRow, Welcome, Probe,
InfoPanel, ShareRow, InfoBox, StampStack. They only describe fixed UI from
their constructor arguments or global values. They hold nothing that changes
by itself, so they never need setState.

Stateful: Clock, Tile, SwapBoard. Each one keeps data that changes while the
app runs. Clock has the Timer, the seconds and the build count. Tile has its
taps counter. SwapBoard has the list of tiles that gets reversed. This data
lives in the State object, which survives rebuilds, and setState tells Flutter
to rebuild when it changes.

## B2: Widget, Element, RenderObject

The Widget is rebuilt (created again) on every setState. It is only a cheap,
immutable description, thrown away and replaced each time. The Element and the
RenderObject are kept and reused. The Element holds the State and the widget's
place in the tree, and the RenderObject does layout and painting.

Probe showed this. Every second the Widget number (identityHashCode(this))
changed, because a new Probe object was created in Clock's build. The Element
number (identityHashCode(context)) stayed the same, because Flutter reused the
same Element for the same type at the same position. Context belongs to: Probe
and Scaffold above me: true showed that context is the widget's address in the
tree, and that from it we can look up to ancestors.

## B3: Constraints go down, sizes go up (Step 7)

In SummaryRow, the Row passes constraints down to its children. A plain Row
gives each Text unlimited width, so each long Text chose a one-line size wider
than the screen and the Row overflowed (yellow-black stripes). After wrapping
each Text in Expanded, the Row divides the available width into three equal
shares and passes each Text a bounded width as its constraint. The Text then
wraps its words to fit inside that width and reports its chosen size (that
width and the height of its wrapped lines) back up to the Row. So the parent
sets the limits going down, the child picks a size within them, and the size
goes back up to the parent.
