// abstract class
// abstract class is a class that cannot be instantiated (you cannot create an object of an abstract class)
// abstract class is a blueprint for other classes
// abstract class can have abstract methods (methods without body)
// abstract class can have non-abstract methods (methods with body)

// interface is an abstract class that contains only abstract methods
// interface is a contract that a class must follow (derived class must implement all abstract methods of the interface)

// data encapsulation: using getter and setter to access private variables
// private variable: a variable that cannot be accessed outside the class (prefix with _)
// getter: a method that returns the value of a private variable
// setter: a method that sets the value of a private variable

// polymorphism: the ability of a variable, function or object to take on multiple forms
// polymorphism is achieved through inheritance and interfaces

abstract class Vehicle {
  void start(); // abstract method
  void move_forward(); // abstract method
  void stop() { // non-abstract method
    print("Vehicle stopped");
  }
  void speed(); // abstract method
}

// you cannot create an instance of an abstract class (no object of an abstract class)
// vehicle v = vehicle(); // error

class Car extends Vehicle {
  @override
  void start() {
    print("Car started");
  }

  @override
  void move_forward() {
    print("Car moving forward");
  }

  @override
  void speed() {
    print("Car speed is 60 mph");
  }
}

// you can create an instance of a derived class (object of a derived class)
// Car c = Car(); // ok

class Train extends Vehicle {
  @override
  void start() {
    print("Train started");
  }

  @override
  void move_forward() {
    print("Train moving forward");
  }
  
  @override
  void stop() { // overriding non-abstract method
    print("Train stopped");
  }

  @override
  void speed() {
    print("Train speed is 80 mph");
  }
}

// implementing an interface (need to implement all abstract methods of the interface)
class Bike implements Vehicle { // implements keyword is used to implement an interface
  int bikeSpeed = 0;
  @override
  void start() {
    print("Bike started");
  }

  @override
  void move_forward() {
    print("pedal faster");
  }

  @override
  void stop() {
    print("Bike stopped");
  }

  @override
  void speed() {
    print("Bike speed is $bikeSpeed mph");
  }

  int get getSpeed { // getter
    return bikeSpeed;
  }
  set setSpeed(int value) { // setter
    this.bikeSpeed = value;
  }
}

void main() {
  Car myCar = Car();
  Vehicle racer = Car(); // polymorphism
  myCar.start();
  racer.start(); // racer still can call start() method of Car class
  myCar.move_forward();
  racer.move_forward(); // racer still can call move_forward() method of Car class
  myCar.stop();
  racer.stop(); // racer can call stop() method of Vehicle class
  myCar.speed();
  racer.speed(); // racer still can call speed() method of Car class

  Train myTrain = Train();
  myTrain.start();
  myTrain.move_forward();
  myTrain.stop(); // calls overridden stop() method of Train class
  myTrain.speed();

  Bike myBike = Bike();
  myBike.start();
  myBike.setSpeed = 10; // setting bike speed using setter
  myBike.speed(); // getting bike speed using getter
  myBike.move_forward();
  myBike.stop();
}