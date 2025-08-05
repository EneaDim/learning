# C Programming Exercises

This document provides a structured set of 25 C programming exercises. These are arranged progressively from fundamental syntax and control flow to more advanced topics like dynamic memory, file I/O, data structures, and algorithms. Each exercise includes a clear problem statement and a complete solution with explanations.

---

## 🧩 Exercise 1: Hello World

Write a program that prints "Hello, World!" to the console.

### ✅ Solution

This is the most basic C program. It uses the `main` function and the `printf` function from `stdio.h`.

```c
#include <stdio.h>

int main() {
    printf("Hello, World!\n"); // Print message with newline
    return 0; // Exit successfully
}
```

### 💬 Explanation

* `#include <stdio.h>` includes the Standard Input Output library.
* `main()` is the entry point of the program.
* `printf` is used to print a string to the console.

---

## 🧩 Exercise 2: Sum of Two Integers

Prompt the user to enter two integers and display their sum.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int a, b, sum;

    printf("Enter two integers: ");
    scanf("%d %d", &a, &b); // Input two integers

    sum = a + b;

    printf("Sum = %d\n", sum);
    return 0;
}
```

### 💬 Explanation

* `scanf` reads user input.
* The `%d` format specifier is used for integers.
* The result is calculated and printed.

---

## 🧩 Exercise 3: Check Even or Odd

Read an integer and determine whether it is even or odd.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int num;

    printf("Enter an integer: ");
    scanf("%d", &num);

    if (num % 2 == 0)
        printf("%d is even.\n", num);
    else
        printf("%d is odd.\n", num);

    return 0;
}
```

### 💬 Explanation

* The modulo operator `%` determines if there's a remainder when dividing by 2.
* If remainder is zero, it's even; otherwise, it's odd.

---

## 🧩 Exercise 4: Find the Largest of Three Numbers

Take three numbers as input and print the largest one.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int a, b, c;

    printf("Enter three integers: ");
    scanf("%d %d %d", &a, &b, &c);

    if (a >= b && a >= c)
        printf("Largest = %d\n", a);
    else if (b >= a && b >= c)
        printf("Largest = %d\n", b);
    else
        printf("Largest = %d\n", c);

    return 0;
}
```

### 💬 Explanation

* Simple conditional comparisons find the maximum of the three.

---

## 🧩 Exercise 5: Simple Calculator

Create a program that performs basic arithmetic operations: addition, subtraction, multiplication, and division.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    char op;
    float num1, num2;

    printf("Enter operator (+, -, *, /): ");
    scanf(" %c", &op); // Space before %c to consume any newline

    printf("Enter two operands: ");
    scanf("%f %f", &num1, &num2);

    switch(op) {
        case '+':
            printf("%.2f + %.2f = %.2f\n", num1, num2, num1 + num2);
            break;
        case '-':
            printf("%.2f - %.2f = %.2f\n", num1, num2, num1 - num2);
            break;
        case '*':
            printf("%.2f * %.2f = %.2f\n", num1, num2, num1 * num2);
            break;
        case '/':
            if (num2 != 0)
                printf("%.2f / %.2f = %.2f\n", num1, num2, num1 / num2);
            else
                printf("Error! Division by zero.\n");
            break;
        default:
            printf("Invalid operator\n");
    }

    return 0;
}
```

### 💬 Explanation

* The `switch` statement handles multiple possible operations.
* Care is taken to avoid division by zero.

---

## 🧩 Exercise 1: Hello World

Write a program that prints "Hello, World!" to the console.

---

## 🧩 Exercise 2: Sum of Two Integers

Prompt the user to enter two integers and display their sum.

---

## 🧩 Exercise 3: Check Even or Odd

Read an integer and determine whether it is even or odd.

---

## 🧩 Exercise 4: Find the Largest of Three Numbers

Take three numbers as input and print the largest one.

---

## 🧩 Exercise 5: Simple Calculator

Create a program that can perform basic arithmetic operations: addition, subtraction, multiplication, and division.

---

## 🧩 Exercise 6: Print Multiplication Table

Read a number and print its multiplication table up to 10.

---

## 🧩 Exercise 7: Factorial of a Number

Calculate the factorial of a positive integer using a loop.

---

## 🧩 Exercise 8: Reverse a Number

Reverse the digits of an integer entered by the user.

---

## 🧩 Exercise 9: Count Digits in a Number

Count and print the number of digits in an input integer.

---

## 🧩 Exercise 10: Check for Prime Number

Determine if the user-provided number is prime.

---

## 🧩 Exercise 11: Fibonacci Series

Print the first `n` terms of the Fibonacci series.

---

## 🧩 Exercise 12: Swap Two Variables (With and Without Temp)

Write two versions of a swap: one using a temporary variable, one without.

---

## 🧩 Exercise 13: String Length

Implement your own function to calculate the length of a string.

---

## 🧩 Exercise 14: String Reverse

Write a function that reverses a string.

---

## 🧩 Exercise 15: Palindrome Checker

Check if a given string is a palindrome.

---

## 🧩 Exercise 16: Count Vowels and Consonants

Count the number of vowels and consonants in a string.

---

## 🧩 Exercise 17: Sum of Array Elements

Read an array of integers and return the sum of all elements.

---

## 🧩 Exercise 18: Find Max and Min in Array

Find the maximum and minimum values in an integer array.

---

## 🧩 Exercise 19: Linear Search in Array

Search for a specific value in an array using linear search.

---

## 🧩 Exercise 20: Bubble Sort

Sort an array using the bubble sort algorithm.

---

## 🧩 Exercise 21: Pointers and Arrays

Use pointers to access and modify array elements.

---

## 🧩 Exercise 22: Dynamic Memory Allocation

Dynamically allocate memory for an array, input its values, and free it.

---

## 🧩 Exercise 23: Structure for Student Records

Define a struct for student info (name, roll number, marks) and print the records.

---

## 🧩 Exercise 24: File I/O – Read and Write Text

Write a program that writes user input to a text file and then reads it back.

---

## 🧩 Exercise 25: Simple Linked List

Implement a singly linked list with insert and display operations.

---

## 🧩 Exercise 6: Print Multiplication Table

Read a number and print its multiplication table up to 10.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int num;

    printf("Enter a number: ");
    scanf("%d", &num); // Read input number

    // Loop from 1 to 10 and print the multiplication table
    for (int i = 1; i <= 10; i++) {
        printf("%d x %d = %d\n", num, i, num * i);
    }

    return 0;
}
```

### 💬 Explanation

* A `for` loop runs from 1 to 10.
* Each line multiplies the input number by the loop counter.

---

## 🧩 Exercise 7: Factorial of a Number

Calculate the factorial of a positive integer using a loop.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n;
    unsigned long long factorial = 1; // Use long long for larger range

    printf("Enter a positive integer: ");
    scanf("%d", &n);

    // Factorial is not defined for negative numbers
    if (n < 0) {
        printf("Factorial of a negative number doesn't exist.\n");
    } else {
        for (int i = 1; i <= n; ++i) {
            factorial *= i; // Multiply progressively
        }
        printf("Factorial of %d = %llu\n", n, factorial);
    }

    return 0;
}
```

### 💬 Explanation

* The result is stored in a `long long` variable to handle large values.
* Uses a loop from 1 to `n`.

---

## 🧩 Exercise 8: Reverse a Number

Reverse the digits of an integer entered by the user.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int num, reversed = 0;

    printf("Enter an integer: ");
    scanf("%d", &num);

    while (num != 0) {
        int digit = num % 10;       // Extract last digit
        reversed = reversed * 10 + digit; // Append digit to reversed number
        num /= 10;                  // Remove last digit
    }

    printf("Reversed number = %d\n", reversed);

    return 0;
}
```

### 💬 Explanation

* Uses modulo and division to break and rebuild the number in reverse.

---

## 🧩 Exercise 9: Count Digits in a Number

Count and print the number of digits in an input integer.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int num, count = 0;

    printf("Enter an integer: ");
    scanf("%d", &num);

    if (num == 0) {
        count = 1; // Special case for 0
    } else {
        while (num != 0) {
            num /= 10; // Remove a digit each time
            count++;
        }
    }

    printf("Number of digits = %d\n", count);

    return 0;
}
```

### 💬 Explanation

* The number is divided by 10 repeatedly to count its digits.

---

## 🧩 Exercise 10: Check for Prime Number

Determine if the user-provided number is prime.

### ✅ Solution

```c
#include <stdio.h>
#include <stdbool.h>

int main() {
    int num;
    bool isPrime = true;

    printf("Enter a positive integer: ");
    scanf("%d", &num);

    if (num <= 1) {
        isPrime = false; // 0 and 1 are not prime
    } else {
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                isPrime = false; // Found a divisor
                break;
            }
        }
    }

    if (isPrime)
        printf("%d is a prime number.\n", num);
    else
        printf("%d is not a prime number.\n", num);

    return 0;
}
```

### 💬 Explanation

* Checks divisibility from 2 up to √n.
* Uses `bool` from `stdbool.h` for readability.

---
## 🧩 Exercise 11: Fibonacci Series

Print the first `n` terms of the Fibonacci series.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n, t1 = 0, t2 = 1, nextTerm;

    printf("Enter the number of terms: ");
    scanf("%d", &n);

    printf("Fibonacci Series: ");

    for (int i = 1; i <= n; ++i) {
        printf("%d ", t1);           // Print current term
        nextTerm = t1 + t2;          // Calculate next term
        t1 = t2;                     // Update t1 to t2
        t2 = nextTerm;               // Update t2 to nextTerm
    }

    printf("\n");
    return 0;
}
```

### 💬 Explanation

* Fibonacci starts with 0 and 1.
* Each next number is the sum of the two preceding ones.

---

## 🧩 Exercise 12: Swap Two Variables (With and Without Temp)

Write two versions of a swap: one using a temporary variable, one without.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int a, b;
    printf("Enter two numbers: ");
    scanf("%d %d", &a, &b);

    // Swap using a temporary variable
    int temp = a;
    a = b;
    b = temp;
    printf("After swap using temp: a = %d, b = %d\n", a, b);

    // Swap back using arithmetic
    a = a + b;  // sum of a and b
    b = a - b;  // original a
    a = a - b;  // original b
    printf("After swap without temp: a = %d, b = %d\n", a, b);

    return 0;
}
```

### 💬 Explanation

* The first swap uses an intermediate variable.
* The second swap uses arithmetic (without extra storage).

---

## 🧩 Exercise 13: String Length

Implement your own function to calculate the length of a string.

### ✅ Solution

```c
#include <stdio.h>

int string_length(char str[]) {
    int length = 0;
    while (str[length] != '\0') { // Loop until null terminator
        length++;
    }
    return length;
}

int main() {
    char str[100];

    printf("Enter a string: ");
    scanf("%s", str);

    int len = string_length(str);
    printf("Length = %d\n", len);

    return 0;
}
```

### 💬 Explanation

* Loops through the string until it finds the null terminator `\0`.

---

## 🧩 Exercise 14: String Reverse

Write a function that reverses a string.

### ✅ Solution

```c
#include <stdio.h>
#include <string.h>

void reverse_string(char str[]) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }
}

int main() {
    char str[100];

    printf("Enter a string: ");
    scanf("%s", str);

    reverse_string(str);
    printf("Reversed string: %s\n", str);

    return 0;
}
```

### 💬 Explanation

* Swaps characters from both ends moving toward the center.
* `strlen()` is used to find the string's length.

---

## 🧩 Exercise 15: Palindrome Checker

Check if a given string is a palindrome.

### ✅ Solution

```c
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

bool is_palindrome(char str[]) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        if (str[i] != str[len - 1 - i]) {
            return false;
        }
    }
    return true;
}

int main() {
    char str[100];

    printf("Enter a string: ");
    scanf("%s", str);

    if (is_palindrome(str))
        printf("%s is a palindrome.\n", str);
    else
        printf("%s is not a palindrome.\n", str);

    return 0;
}
```

### 💬 Explanation

* Compares each character with its mirror from the end.
* Returns true only if all pairs match.

---
## 🧩 Exercise 11: Fibonacci Series

Print the first `n` terms of the Fibonacci series.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n, t1 = 0, t2 = 1, nextTerm;

    printf("Enter the number of terms: ");
    scanf("%d", &n);

    printf("Fibonacci Series: ");

    for (int i = 1; i <= n; ++i) {
        printf("%d ", t1);           // Print current term
        nextTerm = t1 + t2;          // Calculate next term
        t1 = t2;                     // Update t1 to t2
        t2 = nextTerm;               // Update t2 to nextTerm
    }

    printf("\n");
    return 0;
}
```

### 💬 Explanation

* Fibonacci starts with 0 and 1.
* Each next number is the sum of the two preceding ones.

---

## 🧩 Exercise 12: Swap Two Variables (With and Without Temp)

Write two versions of a swap: one using a temporary variable, one without.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int a, b;
    printf("Enter two numbers: ");
    scanf("%d %d", &a, &b);

    // Swap using a temporary variable
    int temp = a;
    a = b;
    b = temp;
    printf("After swap using temp: a = %d, b = %d\n", a, b);

    // Swap back using arithmetic
    a = a + b;  // sum of a and b
    b = a - b;  // original a
    a = a - b;  // original b
    printf("After swap without temp: a = %d, b = %d\n", a, b);

    return 0;
}
```

### 💬 Explanation

* The first swap uses an intermediate variable.
* The second swap uses arithmetic (without extra storage).

---

## 🧩 Exercise 13: String Length

Implement your own function to calculate the length of a string.

### ✅ Solution

```c
#include <stdio.h>

int string_length(char str[]) {
    int length = 0;
    while (str[length] != '\0') { // Loop until null terminator
        length++;
    }
    return length;
}

int main() {
    char str[100];

    printf("Enter a string: ");
    scanf("%s", str);

    int len = string_length(str);
    printf("Length = %d\n", len);

    return 0;
}
```

### 💬 Explanation

* Loops through the string until it finds the null terminator `\0`.

---

## 🧩 Exercise 14: String Reverse

Write a function that reverses a string.

### ✅ Solution

```c
#include <stdio.h>
#include <string.h>

void reverse_string(char str[]) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }
}

int main() {
    char str[100];

    printf("Enter a string: ");
    scanf("%s", str);

    reverse_string(str);
    printf("Reversed string: %s\n", str);

    return 0;
}
```

### 💬 Explanation

* Swaps characters from both ends moving toward the center.
* `strlen()` is used to find the string's length.

---

## 🧩 Exercise 15: Palindrome Checker

Check if a given string is a palindrome.

### ✅ Solution

```c
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

bool is_palindrome(char str[]) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        if (str[i] != str[len - 1 - i]) {
            return false;
        }
    }
    return true;
}

int main() {
    char str[100];

    printf("Enter a string: ");
    scanf("%s", str);

    if (is_palindrome(str))
        printf("%s is a palindrome.\n", str);
    else
        printf("%s is not a palindrome.\n", str);

    return 0;
}
```

### 💬 Explanation

* Compares each character with its mirror from the end.
* Returns true only if all pairs match.

---

## 🧩 Exercise 16: Count Vowels and Consonants

Count the number of vowels and consonants in a string.

### ✅ Solution

```c
#include <stdio.h>
#include <ctype.h>

int main() {
    char str[100];
    int vowels = 0, consonants = 0;

    printf("Enter a string: ");
    scanf("%s", str);

    for (int i = 0; str[i] != '�'; i++) {
        char ch = tolower(str[i]); // Convert to lowercase for simplicity
        if (ch >= 'a' && ch <= 'z') {
            if (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u')
                vowels++;
            else
                consonants++;
        }
    }

    printf("Vowels: %d
", vowels);
    printf("Consonants: %d
", consonants);
    return 0;
}
```

### 💬 Explanation

* Uses `tolower` to handle both uppercase and lowercase letters.
* Checks each character if it's a letter, then classifies as vowel or consonant.

---

## 🧩 Exercise 17: Sum of Array Elements

Read an array of integers and return the sum of all elements.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n, sum = 0;
    int arr[100];

    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter %d integers:
", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
        sum += arr[i];
    }

    printf("Sum = %d
", sum);
    return 0;
}
```

### 💬 Explanation

* A simple loop adds each array element to the running total.

---

## 🧩 Exercise 18: Find Max and Min in Array

Find the maximum and minimum values in an integer array.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n, arr[100], max, min;

    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter %d integers:
", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    max = min = arr[0]; // Initialize with first element

    for (int i = 1; i < n; i++) {
        if (arr[i] > max)
            max = arr[i];
        if (arr[i] < min)
            min = arr[i];
    }

    printf("Maximum = %d
", max);
    printf("Minimum = %d
", min);
    return 0;
}
```

### 💬 Explanation

* Initializes `max` and `min` with the first array element, then compares the rest.

---

## 🧩 Exercise 19: Linear Search in Array

Search for a specific value in an array using linear search.

### ✅ Solution

```c
#include <stdio.h>
#include <stdbool.h>

int main() {
    int n, arr[100], key;
    bool found = false;

    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter %d integers:
", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    printf("Enter value to search: ");
    scanf("%d", &key);

    for (int i = 0; i < n; i++) {
        if (arr[i] == key) {
            printf("Found %d at index %d
", key, i);
            found = true;
            break;
        }
    }

    if (!found) {
        printf("%d not found in the array.
", key);
    }

    return 0;
}
```

### 💬 Explanation

* Checks each array element linearly until the key is found.

---

## 🧩 Exercise 20: Bubble Sort

Sort an array using the bubble sort algorithm.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n, arr[100];

    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter %d integers:
", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    // Bubble sort logic
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

    printf("Sorted array: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("
");

    return 0;
}
```

### 💬 Explanation

* Repeatedly swaps adjacent elements if they are in the wrong order.

---
## 🧩 Exercise 11: Fibonacci Series

Print the first `n` terms of the Fibonacci series.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n, t1 = 0, t2 = 1, nextTerm;

    printf("Enter the number of terms: ");
    scanf("%d", &n);

    printf("Fibonacci Series: ");

    for (int i = 1; i <= n; ++i) {
        printf("%d ", t1);           // Print current term
        nextTerm = t1 + t2;          // Calculate next term
        t1 = t2;                     // Update t1 to t2
        t2 = nextTerm;               // Update t2 to nextTerm
    }

    printf("\n");
    return 0;
}
```

### 💬 Explanation

* Fibonacci starts with 0 and 1.
* Each next number is the sum of the two preceding ones.

---

## 🧩 Exercise 12: Swap Two Variables (With and Without Temp)

Write two versions of a swap: one using a temporary variable, one without.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int a, b;
    printf("Enter two numbers: ");
    scanf("%d %d", &a, &b);

    // Swap using a temporary variable
    int temp = a;
    a = b;
    b = temp;
    printf("After swap using temp: a = %d, b = %d\n", a, b);

    // Swap back using arithmetic
    a = a + b;  // sum of a and b
    b = a - b;  // original a
    a = a - b;  // original b
    printf("After swap without temp: a = %d, b = %d\n", a, b);

    return 0;
}
```

### 💬 Explanation

* The first swap uses an intermediate variable.
* The second swap uses arithmetic (without extra storage).

---

## 🧩 Exercise 13: String Length

Implement your own function to calculate the length of a string.

### ✅ Solution

```c
#include <stdio.h>

int string_length(char str[]) {
    int length = 0;
    while (str[length] != '\0') { // Loop until null terminator
        length++;
    }
    return length;
}

int main() {
    char str[100];

    printf("Enter a string: ");
    scanf("%s", str);

    int len = string_length(str);
    printf("Length = %d\n", len);

    return 0;
}
```

### 💬 Explanation

* Loops through the string until it finds the null terminator `\0`.

---

## 🧩 Exercise 14: String Reverse

Write a function that reverses a string.

### ✅ Solution

```c
#include <stdio.h>
#include <string.h>

void reverse_string(char str[]) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }
}

int main() {
    char str[100];

    printf("Enter a string: ");
    scanf("%s", str);

    reverse_string(str);
    printf("Reversed string: %s\n", str);

    return 0;
}
```

### 💬 Explanation

* Swaps characters from both ends moving toward the center.
* `strlen()` is used to find the string's length.

---

## 🧩 Exercise 15: Palindrome Checker

Check if a given string is a palindrome.

### ✅ Solution

```c
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

bool is_palindrome(char str[]) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        if (str[i] != str[len - 1 - i]) {
            return false;
        }
    }
    return true;
}

int main() {
    char str[100];

    printf("Enter a string: ");
    scanf("%s", str);

    if (is_palindrome(str))
        printf("%s is a palindrome.\n", str);
    else
        printf("%s is not a palindrome.\n", str);

    return 0;
}
```

### 💬 Explanation

* Compares each character with its mirror from the end.
* Returns true only if all pairs match.

---

## 🧩 Exercise 16: Count Vowels and Consonants

Count the number of vowels and consonants in a string.

### ✅ Solution

```c
#include <stdio.h>
#include <ctype.h>

int main() {
    char str[100];
    int vowels = 0, consonants = 0;

    printf("Enter a string: ");
    scanf("%s", str);

    for (int i = 0; str[i] != '�'; i++) {
        char ch = tolower(str[i]); // Convert to lowercase for simplicity
        if (ch >= 'a' && ch <= 'z') {
            if (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u')
                vowels++;
            else
                consonants++;
        }
    }

    printf("Vowels: %d
", vowels);
    printf("Consonants: %d
", consonants);
    return 0;
}
```

### 💬 Explanation

* Uses `tolower` to handle both uppercase and lowercase letters.
* Checks each character if it's a letter, then classifies as vowel or consonant.

---

## 🧩 Exercise 17: Sum of Array Elements

Read an array of integers and return the sum of all elements.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n, sum = 0;
    int arr[100];

    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter %d integers:
", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
        sum += arr[i];
    }

    printf("Sum = %d
", sum);
    return 0;
}
```

### 💬 Explanation

* A simple loop adds each array element to the running total.

---

## 🧩 Exercise 18: Find Max and Min in Array

Find the maximum and minimum values in an integer array.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n, arr[100], max, min;

    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter %d integers:
", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    max = min = arr[0]; // Initialize with first element

    for (int i = 1; i < n; i++) {
        if (arr[i] > max)
            max = arr[i];
        if (arr[i] < min)
            min = arr[i];
    }

    printf("Maximum = %d
", max);
    printf("Minimum = %d
", min);
    return 0;
}
```

### 💬 Explanation

* Initializes `max` and `min` with the first array element, then compares the rest.

---

## 🧩 Exercise 19: Linear Search in Array

Search for a specific value in an array using linear search.

### ✅ Solution

```c
#include <stdio.h>
#include <stdbool.h>

int main() {
    int n, arr[100], key;
    bool found = false;

    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter %d integers:
", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    printf("Enter value to search: ");
    scanf("%d", &key);

    for (int i = 0; i < n; i++) {
        if (arr[i] == key) {
            printf("Found %d at index %d
", key, i);
            found = true;
            break;
        }
    }

    if (!found) {
        printf("%d not found in the array.
", key);
    }

    return 0;
}
```

### 💬 Explanation

* Checks each array element linearly until the key is found.

---

## 🧩 Exercise 20: Bubble Sort

Sort an array using the bubble sort algorithm.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int n, arr[100];

    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter %d integers:
", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    // Bubble sort logic
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

    printf("Sorted array: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("
");

    return 0;
}
```

### 💬 Explanation

* Repeatedly swaps adjacent elements if they are in the wrong order.

---

## 🧩 Exercise 21: Pointers and Arrays

Use pointers to access and modify array elements.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    int arr[5] = {10, 20, 30, 40, 50};
    int *ptr = arr; // Pointer to first element of array

    printf("Original array values:
");
    for (int i = 0; i < 5; i++) {
        printf("arr[%d] = %d
", i, *(ptr + i)); // Access using pointer arithmetic
    }

    // Modify elements using pointer
    for (int i = 0; i < 5; i++) {
        *(ptr + i) += 5; // Add 5 to each element
    }

    printf("Modified array values:
");
    for (int i = 0; i < 5; i++) {
        printf("arr[%d] = %d
", i, arr[i]);
    }

    return 0;
}
```

### 💬 Explanation

* Demonstrates pointer arithmetic to both read and write array contents.

---

## 🧩 Exercise 22: Dynamic Memory Allocation

Dynamically allocate memory for an array, input its values, and free it.

### ✅ Solution

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    printf("Enter number of elements: ");
    scanf("%d", &n);

    int *arr = (int*) malloc(n * sizeof(int)); // Dynamically allocate memory
    if (arr == NULL) {
        printf("Memory allocation failed!
");
        return 1;
    }

    printf("Enter %d integers:
", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    printf("Entered elements are:
");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("
");

    free(arr); // Free allocated memory
    return 0;
}
```

### 💬 Explanation

* `malloc` is used to allocate memory at runtime.
* Always check for `NULL` and free memory to avoid leaks.

---

## 🧩 Exercise 23: Structure for Student Records

Define a struct for student info (name, roll number, marks) and print the records.

### ✅ Solution

```c
#include <stdio.h>

struct Student {
    char name[50];
    int roll;
    float marks;
};

int main() {
    struct Student s;

    printf("Enter name: ");
    scanf("%s", s.name);

    printf("Enter roll number: ");
    scanf("%d", &s.roll);

    printf("Enter marks: ");
    scanf("%f", &s.marks);

    printf("
Student Details:
");
    printf("Name: %s
", s.name);
    printf("Roll Number: %d
", s.roll);
    printf("Marks: %.2f
", s.marks);

    return 0;
}
```

### 💬 Explanation

* Structures allow grouping of related data under one name.

---

## 🧩 Exercise 24: File I/O – Read and Write Text

Write a program that writes user input to a text file and then reads it back.

### ✅ Solution

```c
#include <stdio.h>

int main() {
    FILE *fp;
    char str[100];

    // Write to file
    fp = fopen("example.txt", "w");
    if (fp == NULL) {
        printf("Unable to open file for writing!
");
        return 1;
    }

    printf("Enter a string to write to file: ");
    scanf("%s", str);
    fprintf(fp, "%s", str);
    fclose(fp);

    // Read from file
    fp = fopen("example.txt", "r");
    if (fp == NULL) {
        printf("Unable to open file for reading!
");
        return 1;
    }

    fscanf(fp, "%s", str);
    printf("Read from file: %s
", str);
    fclose(fp);

    return 0;
}
```

### 💬 Explanation

* Demonstrates file creation, writing, reading, and closing using standard I/O.

---

## 🧩 Exercise 25: Simple Linked List

Implement a singly linked list with insert and display operations.

### ✅ Solution

```c
#include <stdio.h>
#include <stdlib.h>

// Node structure
typedef struct Node {
    int data;
    struct Node* next;
} Node;

// Function to insert node at end
void insert_end(Node** head, int value) {
    Node* new_node = (Node*)malloc(sizeof(Node));
    new_node->data = value;
    new_node->next = NULL;

    if (*head == NULL) {
        *head = new_node;
    } else {
        Node* temp = *head;
        while (temp->next != NULL)
            temp = temp->next;
        temp->next = new_node;
    }
}

// Function to display linked list
void display(Node* head) {
    Node* temp = head;
    printf("Linked list: ");
    while (temp != NULL) {
        printf("%d -> ", temp->data);
        temp = temp->next;
    }
    printf("NULL
");
}

int main() {
    Node* head = NULL;
    int n, value;

    printf("Enter number of nodes: ");
    scanf("%d", &n);

    for (int i = 0; i < n; i++) {
        printf("Enter value for node %d: ", i + 1);
        scanf("%d", &value);
        insert_end(&head, value);
    }

    display(head);
    return 0;
}
```

### 💬 Explanation

* Uses dynamic memory and a linked structure to insert and display nodes.
* Demonstrates how linked lists work internally.

---


