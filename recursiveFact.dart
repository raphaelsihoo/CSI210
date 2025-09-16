// Recursive Factorial

int factorial(int n) {
  if (n <= 1) { // base case
    return 1;
  } else {
    return n * factorial(n - 1); // recursive case
  }
}

void main() {
  int num = 5;
  int result = factorial(num);
  print("result: ${result}");
}