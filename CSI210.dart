// CSI210 class activity

// create a 10x10 grid
// with random numbers 1-10 in each cell
import 'dart:math';

// we could do List of Lists
// we could do a single List of 10
// It's like a 2D array in Java or maybe more like an ArrayList
List< List<int> > createGrid(int n) { // a function with return value of List of List
    List< List<int> > grid = []; // Outer list, holds the rows
    Random rand = Random();
    for (int i = 0; i < n; i++) {
        List<int> row = []; // New row for each iteration
        for (int j = 0; j < n; j++) {
            row.add(rand.nextInt(10) + 1); // random number between 1 and 10
        }
        grid.add(row);
    }
    return grid;
}

void main() {
    List<int> list = [1,2,3,4,5];
    list.add(6);
    print('Type: ${list}'); 
    list.remove(5);
    print('Type: ${list}');

    List<double> doubleList = new List<double>();
    for (int i in list) {
        doubleList.add(i.toDouble());
    }
    List<num> numList = [1, 2, 3.141592]; // num is a superclass of int and double

    createGrid(10);
}