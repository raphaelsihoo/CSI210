// In-class activity: BASE and DERIVED CLASSES

class Person {
  // super class OR base class
  int age = 0;
  String name = "";
}

class Student extends Person {
  // sub-class OR derived class
  int id = 0;
}

class Employee extends Person {
  // sub-class
  num wage = 0;
}

class SalaryEmployee extends Employee {}

void main() {}
