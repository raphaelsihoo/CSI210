// create a 10x10 grid
// with random numbers 1-10 in each cell
import 'dart:math';

class Grid {
    int n = 0; // Initialize n as a zero
    List< List<int> > grid;
    Random rand = Random();

    // Constructor for n by n grid
    Grid(int n) :  grid = [] { // : grid is an initializer. (executes before body)
        this.n = n;

        for (int i = 0; i < n; i++) {
            List<int> row = [];
            for (int j = 0; j < n; j++) {
                row.add(rand.nextInt(10) + 1); // random number from 1 - 10 inclusive
            }
            grid.add(row);
            
        }
    }

    void cityPopulate() {
        // Two random coordinate x and y
        for (int i = 0; i < 2; i++) {
            int x = rand.nextInt(n);
            int y = rand.nextInt(n); 
            applyCity(x, y);
        }
    }

    void applyCity(int x, int y) {
        setIfHigher(x, y, 100);
        setNeighbors(x, y, 1, 50);
        setNeighbors(x, y, 2, 25);
    }

    void setNeighbors(int x, int y, int dist, int value) {
        // up
        if (x - dist >= 0 && value > grid[x - dist][y]) { // x - dist: avoid index out of range
            grid[x - dist][y] = value;
        }
        // up-right (diagonal)
        if (x - dist >= 0 && y + dist < n && value > grid[x - dist][y + dist]) {
            grid[x - dist][y + dist] = value;
        }
        // up-left (diagonal)
        if (x - dist >= 0 && y - dist >= 0 && value > grid[x - dist][y - dist]) {
            grid[x - dist][y - dist] = value;
        }

        // down
        if (x + dist < n && value > grid[x + dist][y]) {
            grid[x + dist][y] = value;
        }
        // down-right (diagonal)
        if (x + dist < n && y + dist < n && value > grid[x + dist][y + dist]) {
            grid[x + dist][y + dist] = value;
        }
        // down-left (diagonal)
        if (x + dist < n && y - dist >= 0 && value > grid[x + dist][y - dist]) {
            grid[x + dist][y - dist] = value;
        }

        // right
        if (y + dist < n && value > grid[x][y + dist]) {
            grid[x][y + dist] = value;
        }
        // left
        if (y - dist >= 0 && value > grid[x][y - dist]) {
            grid[x][y - dist] = value;
        }

        if (dist == 2) {
            // up 2 cells and right 1 cell
            if (x - dist >= 0 && y + dist - 1 < n && value > grid[x - dist][y + dist - 1]) {
                grid[x - dist][y + dist - 1] = value;
            }
            // up 2 cells and left 1 cell
            if (x - dist >= 0 && y - dist + 1 >= 0 && value > grid[x - dist][y - dist + 1]) {
                grid[x - dist][y - dist + 1] = value;
            }
            // up 1 cell and right 2 cells
            if (x - dist + 1 >= 0 && y + dist < n && value > grid[x - dist + 1][y + dist]) {
                grid[x - dist + 1][y + dist] = value;
            }
            // up 1 cell and left 2 cells
            if (x - dist + 1 >= 0 && y - dist >= 0 && value > grid[x - dist + 1][y - dist]) {
                grid[x - dist + 1][y - dist] = value;
            }
            // down 1 cell and right 2 cells
            if (x + dist - 1 < n && y + dist < n && value > grid[x + dist - 1][y + dist]) {
                grid[x + dist - 1][y + dist] = value;
            }
            // down 1 cell and left 2 cells
            if (x + dist - 1 >= 0 && y - dist >= 0 && value > grid[x + dist - 1][y - dist]) {
                grid[x + dist - 1][y - dist] = value;
            }
            // down 2 cells and right 1 cell
            if (x + dist < n && y + dist - 1 < n && value > grid[x + dist][y + dist - 1]) {
                grid[x + dist][y + dist - 1] = value;
            }
            // down 2 cells and left 1 cell
            if (x + dist < n && y - dist + 1 >= 0 && value > grid[x + dist][y - dist + 1]) {
                grid[x + dist][y - dist + 1] = value;
            }
        }
    }

    void setIfHigher(int x, int y, int value) {
        if (value > grid[x][y]) {
            grid[x][y] = value;
        }
    }
  
    void printGrid() {
      for (int i = 0; i < n; i++) {
          String rowStr = "[" + grid[i].join(",  ") + "]"; // join allows to convert List to String with a separator
          print(rowStr);
      }
    }
}

void main() {
    Grid g = new Grid(10); // 10 by 10 cell as an example
    g.cityPopulate();
    g.printGrid();
}