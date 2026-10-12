# OOP Lab Answers

Name: Aitzaz-Ul-Hassan
Roll no: 04072313026

**Q1. What can a subclass using extends use for free that a class using implements has to write itself?**
A class that uses `extends` inherits the parent's fields and the bodies of its methods, so it can use them without rewriting anything. A class that uses `implements` gets only the names and types of the members, so it has to write every field and method body itself.

**Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?**
I would pick a mixin when only some classes need the same ready-made code and they are not all related, like Book and Dvd but not Magazine. I would pick an abstract parent class when all the subclasses share an "is-a" relationship and a common base, like LibraryItem, because a class can have only one parent.

**Q3. Why must you override hashCode whenever you override ==?**
Sets and maps use hashCode to find where an object is stored and then use == to compare it. If two objects are equal but have different hash codes, they can land in different places and be treated as different, so lookups and set sizes become wrong.

**Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?**
An extension just adds methods to the existing String type without creating a new type, so it works on a class I cannot change. A subclass would create a new type, and String is a final class in Dart that cannot be extended.
