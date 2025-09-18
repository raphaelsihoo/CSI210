//abstract class
// abstract class is a class that cannot be instantiated (you cannot create an object of an abstract class)
// abstract class is a blueprint for other classes
// abstract class can have abstract methods (methods without body)
// abstract class can have non-abstract methods (methods with body)

abstract class Vehicle {
  void start(); // abstract method
  void move_forward(); // abstract method
  void stop() { // non-abstract method
    print("Vehicle stopped");
  }
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
  Train myTrain = Train();
  myTrain.start();
  myTrain.move_forward();
  myTrain.stop(); // calls overridden stop() method of Train class
}