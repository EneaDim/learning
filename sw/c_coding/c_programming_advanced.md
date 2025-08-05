# C Programming Theory and Exercises: Arrays, Pointers, Two-Pointer, Stack, Linked List, and Hash Table

This document explains the foundational C data structures and techniques, including practical examples and complete, commented code for each topic.

---

## 🔢 Arrays

### 🧠 What is an Array?

An array is a fixed-size collection of elements of the same data type stored in contiguous memory locations.

### ✅ Why Arrays Are Useful:

* Efficient O(1) indexing
* Useful for storing and processing static lists

### 💡 Example: Reverse an Array

```c
#include <stdio.h>

int main() {
    int arr[] = {10, 20, 30, 40, 50};
    int n = sizeof(arr)/sizeof(arr[0]);

    for (int i = 0; i < n / 2; i++) {
        int temp = arr[i];
        arr[i] = arr[n - 1 - i];
        arr[n - 1 - i] = temp;
    }

    printf("Reversed Array: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    return 0;
}
```

---

## 🔗 Pointers

### 🧠 What is a Pointer?

A pointer is a variable that stores the memory address of another variable.

### ✅ Why Pointers Are Useful:

* Enable dynamic memory management
* Facilitate efficient data structure manipulation

### 💡 Example: Swap Two Numbers Using Pointers

```c
#include <stdio.h>

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main() {
    int x = 5, y = 10;
    swap(&x, &y);
    printf("x = %d, y = %d\n", x, y); // Output: x = 10, y = 5
    return 0;
}
```

---

## 🪝 Two-Pointer Technique

### 🧠 What Is It?

Use two indices (or pointers) to traverse a data structure from both ends or sides.

### ✅ Why It’s Useful:

* Efficient O(n) solutions for pair matching, reversing, partitioning

### 💡 Example: Check for Pair with Sum (Sorted Array)

```c
#include <stdio.h>
#include <stdbool.h>

bool hasPair(int arr[], int n, int target) {
    int left = 0, right = n - 1;
    while (left < right) {
        int sum = arr[left] + arr[right];
        if (sum == target) return true;
        else if (sum < target) left++;
        else right--;
    }
    return false;
}

int main() {
    int arr[] = {1, 2, 3, 4, 6, 8};
    int n = sizeof(arr)/sizeof(arr[0]);
    int target = 10;
    if (hasPair(arr, n, target))
        printf("Pair found.\n");
    else
        printf("No such pair.\n");
    return 0;
}
```

---

## 🧱 Stack

### 🧠 What is a Stack?

A stack is a LIFO (Last In First Out) data structure.

### ✅ Why Stacks Are Useful:

* Useful for expression parsing, undo mechanisms, and recursive calls

### 💡 Example: Reverse a String Using Stack

```c
#include <stdio.h>
#include <string.h>

#define MAX 100

int main() {
    char str[MAX], stack[MAX];
    int top = -1;

    printf("Enter a string: ");
    scanf("%s", str);

    for (int i = 0; str[i] != '\0'; i++) {
        stack[++top] = str[i]; // Push
    }

    printf("Reversed string: ");
    while (top >= 0) {
        printf("%c", stack[top--]); // Pop
    }
    printf("\n");
    return 0;
}
```

---

## 🔗 Linked List

### 🧠 What is a Linked List?

A linked list is a sequence of nodes where each node contains data and a pointer to the next node.

### ✅ Why Linked Lists Are Useful:

* Efficient insertions/deletions compared to arrays
* Flexible size

### 💡 Example: Insert at Beginning and Print

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

void insertFront(Node** head, int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data = value;
    newNode->next = *head;
    *head = newNode;
}

void printList(Node* head) {
    while (head != NULL) {
        printf("%d -> ", head->data);
        head = head->next;
    }
    printf("NULL\n");
}

int main() {
    Node* head = NULL;
    insertFront(&head, 10);
    insertFront(&head, 20);
    insertFront(&head, 30);

    printList(head); // Output: 30 -> 20 -> 10 -> NULL
    return 0;
}
```

---

## 🧮 Hash Table

### 🧠 What is a Hash Table?

A data structure that maps keys to values using a hash function.

### ✅ Why Hash Tables Are Useful:

* Average-case O(1) insert and lookup
* Used in dictionaries, caches, and symbol tables

### 💡 Example: String Key to Integer Value (Chained Hash Table)

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TABLE_SIZE 10

typedef struct Node {
    char key[50];
    int value;
    struct Node* next;
} Node;

Node* hashTable[TABLE_SIZE];

int hash(char* key) {
    int sum = 0;
    for (int i = 0; key[i] != '\0'; i++) {
        sum += key[i];
    }
    return sum % TABLE_SIZE;
}

void insert(char* key, int value) {
    int index = hash(key);
    Node* newNode = (Node*)malloc(sizeof(Node));
    strcpy(newNode->key, key);
    newNode->value = value;
    newNode->next = hashTable[index];
    hashTable[index] = newNode;
}

int search(char* key) {
    int index = hash(key);
    Node* temp = hashTable[index];
    while (temp) {
        if (strcmp(temp->key, key) == 0)
            return temp->value;
        temp = temp->next;
    }
    return -1; // Not found
}

void printTable() {
    for (int i = 0; i < TABLE_SIZE; i++) {
        printf("[%d]: ", i);
        Node* temp = hashTable[i];
        while (temp) {
            printf("(%s, %d) -> ", temp->key, temp->value);
            temp = temp->next;
        }
        printf("NULL\n");
    }
}

int main() {
    insert("apple", 5);
    insert("banana", 3);
    insert("orange", 2);

    printTable();

    printf("Search 'banana': %d\n", search("banana"));  // Output: 3
    printf("Search 'grape': %d\n", search("grape"));    // Output: -1
    return 0;
}
```

---

## 🌳 Binary Tree

### 🧠 What is a Binary Tree?

A binary tree is a hierarchical data structure in which each node has at most two children: left and right.

### ✅ Why Trees Are Useful:

* Efficient for representing hierarchical data
* Used in databases, parsers, and search algorithms

### 💡 Example: Inorder Traversal of a Binary Tree

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node* left;
    struct Node* right;
} Node;

Node* newNode(int data) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->data = data;
    node->left = node->right = NULL;
    return node;
}

void inorder(Node* root) {
    if (root != NULL) {
        inorder(root->left);
        printf("%d ", root->data);
        inorder(root->right);
    }
}

int main() {
    Node* root = newNode(1);
    root->left = newNode(2);
    root->right = newNode(3);
    root->left->left = newNode(4);
    root->left->right = newNode(5);

    printf("Inorder traversal: ");
    inorder(root);
    printf("
");
    return 0;
}
```

---

## 📥 Queue

### 🧠 What is a Queue?

A queue is a linear data structure that follows the FIFO (First In First Out) principle.

### ✅ Why Queues Are Useful:

* Suitable for task scheduling, breadth-first search, and buffering

### 💡 Example: Implement a Queue Using Array

```c
#include <stdio.h>
#define SIZE 5

int queue[SIZE];
int front = -1, rear = -1;

void enqueue(int value) {
    if (rear == SIZE - 1) {
        printf("Queue is full
");
    } else {
        if (front == -1) front = 0;
        queue[++rear] = value;
    }
}

void dequeue() {
    if (front == -1 || front > rear) {
        printf("Queue is empty
");
    } else {
        printf("Dequeued: %d
", queue[front++]);
    }
}

void display() {
    if (front == -1 || front > rear) {
        printf("Queue is empty
");
    } else {
        for (int i = front; i <= rear; i++) {
            printf("%d ", queue[i]);
        }
        printf("
");
    }
}

int main() {
    enqueue(10);
    enqueue(20);
    enqueue(30);
    display();
    dequeue();
    display();
    return 0;
}
```

---

## ⚙️ Algorithmic Technique: Sliding Window

### 🧠 What is Sliding Window?

A method for optimizing problems involving subarrays or substrings using a moving window.

### ✅ Why It's Useful:

* Reduces nested loops to linear time
* Solves problems like max/min subarray, anagram detection, etc.

### 💡 Example: Maximum Sum Subarray of Size k

```c
#include <stdio.h>

int maxSum(int arr[], int n, int k) {
    int max = 0, sum = 0;
    for (int i = 0; i < k; i++) {
        sum += arr[i];
    }
    max = sum;
    for (int i = k; i < n; i++) {
        sum = sum + arr[i] - arr[i - k];
        if (sum > max) max = sum;
    }
    return max;
}

int main() {
    int arr[] = {2, 1, 5, 1, 3, 2};
    int k = 3;
    int n = sizeof(arr)/sizeof(arr[0]);
    printf("Maximum sum of subarray of size %d: %d
", k, maxSum(arr, n, k));
    return 0;
}
```

---

## 🔁 Recursion

### 🧠 What is Recursion?

A technique where a function calls itself to solve a smaller instance of the problem.

### ✅ Why Recursion Is Useful:

* Elegant for problems that can be broken into sub-problems (e.g., tree traversal, backtracking)

### 💡 Example: Factorial using Recursion

```c
#include <stdio.h>

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int main() {
    int n = 5;
    printf("Factorial of %d is %d
", n, factorial(n));
    return 0;
}
```

---

## 🔃 Sorting Algorithms

### 🧠 What is Sorting?

Sorting arranges elements in a specific order (e.g., ascending or descending).

### ✅ Why Sorting Is Useful:

* Optimizes searching, organizing, and simplifies complex operations

### 💡 Example: Selection Sort

```c
#include <stdio.h>

void selectionSort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        int min_idx = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[min_idx]) min_idx = j;
        }
        int temp = arr[i];
        arr[i] = arr[min_idx];
        arr[min_idx] = temp;
    }
}

int main() {
    int arr[] = {64, 25, 12, 22, 11};
    int n = sizeof(arr) / sizeof(arr[0]);

    selectionSort(arr, n);

    printf("Sorted array: ");
    for (int i = 0; i < n; i++) printf("%d ", arr[i]);
    printf("
");
    return 0;
}
```

---

## 🧠 Graph Theory (Adjacency List)

### 🧠 What is a Graph?

A set of vertices connected by edges.

### ✅ Why Graphs Are Useful:

* Models networks like web links, maps, social networks

### 💡 Example: Simple Undirected Graph using Adjacency List

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int vertex;
    struct Node* next;
} Node;

#define MAX_VERTICES 5

Node* adjList[MAX_VERTICES];

Node* createNode(int v) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->vertex = v;
    newNode->next = NULL;
    return newNode;
}

void addEdge(int src, int dest) {
    Node* newNode = createNode(dest);
    newNode->next = adjList[src];
    adjList[src] = newNode;

    newNode = createNode(src);
    newNode->next = adjList[dest];
    adjList[dest] = newNode;
}

void printGraph() {
    for (int i = 0; i < MAX_VERTICES; i++) {
        Node* temp = adjList[i];
        printf("Vertex %d:", i);
        while (temp) {
            printf(" -> %d", temp->vertex);
            temp = temp->next;
        }
        printf("
");
    }
}

int main() {
    for (int i = 0; i < MAX_VERTICES; i++) adjList[i] = NULL;

    addEdge(0, 1);
    addEdge(0, 4);
    addEdge(1, 2);
    addEdge(1, 3);
    addEdge(1, 4);
    addEdge(2, 3);
    addEdge(3, 4);

    printGraph();
    return 0;
}
```

---

## 💡 Dynamic Programming

### 🧠 What is Dynamic Programming?

A technique to solve complex problems by breaking them into overlapping sub-problems and storing results to avoid recomputation.

### 💡 Example: Fibonacci using DP

```c
#include <stdio.h>

int fib(int n) {
    int dp[n+1];
    dp[0] = 0;
    dp[1] = 1;
    for (int i = 2; i <= n; i++) {
        dp[i] = dp[i-1] + dp[i-2];
    }
    return dp[n];
}

int main() {
    int n = 10;
    printf("Fibonacci(%d) = %d
", n, fib(n));
    return 0;
}
```

---

## 🔍 Backtracking

### 🧠 What is Backtracking?

A recursive algorithm that tries all possibilities and backtracks when constraints are violated.

### 💡 Example: Solve N-Queens for N=4

```c
#include <stdio.h>
#include <stdbool.h>

#define N 4

void printSolution(int board[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("%d ", board[i][j]);
        }
        printf("
");
    }
    printf("
");
}

bool isSafe(int board[N][N], int row, int col) {
    for (int i = 0; i < col; i++) if (board[row][i]) return false;
    for (int i=row, j=col; i>=0 && j>=0; i--, j--) if (board[i][j]) return false;
    for (int i=row, j=col; j>=0 && i<N; i++, j--) if (board[i][j]) return false;
    return true;
}

bool solveNQUtil(int board[N][N], int col) {
    if (col >= N) return true;
    for (int i = 0; i < N; i++) {
        if (isSafe(board, i, col)) {
            board[i][col] = 1;
            if (solveNQUtil(board, col + 1)) return true;
            board[i][col] = 0;
        }
    }
    return false;
}

void solveNQ() {
    int board[N][N] = {0};
    if (!solveNQUtil(board, 0)) {
        printf("Solution does not exist");
        return;
    }
    printSolution(board);
}

int main() {
    solveNQ();
    return 0;
}
```

---
