# Analyzing Algorithms

## 🔹 What Does It Mean to Analyze an Algorithm?

**Analyzing an algorithm** refers to predicting the **resource requirements** necessary for it to run effectively. While several types of resources might be relevant, such as:

- **Memory usage**
- **Hardware utilization**
- **Latency** (How much time from input\_n to output\_n)
- **Bandwidth** (How much time from output\_n to output\_n+1)

the **primary focus is on computational time** — how long the algorithm takes to complete.

### Why Analyze?
- To **compare alternative algorithms** for the same task and select the most efficient one.
- To **discard inefficient candidates** early in the design process.
- To **understand algorithm behavior** as input sizes grow.

---

## 🔹 The RAM Model: Our Computational Framework

To make algorithm analysis practical and consistent, we assume a theoretical **Random Access Machine (RAM)** model of computation.

### Core Features of the RAM Model:

- **Sequential Execution**: One instruction executes at a time (no parallelism).
- **Basic Instruction Set**: Includes operations commonly found on real computers.

  | Category         | Example Instructions                                      |
  |------------------|-----------------------------------------------------------|
  | Arithmetic        | `add`, `subtract`, `multiply`, `divide`, `remainder`, `floor`, `ceiling` |
  | Data Movement     | `load`, `store`, `copy`                                  |
  | Control Flow      | `if`, `goto`, `branch`, `subroutine call/return`         |

- **Constant Time Assumption**: Each instruction is assumed to take **O(1)** time, regardless of input size.

### Data Representation:

- Algorithms operate on **integers** and **floating-point numbers**.
- We assume data is stored in **fixed-size words**:
  - Each word is `c * log n` bits long, where:
    - `n` is the size of the input.
    - `c ≥ 1` is a constant.
  - This ensures:
    - Integers up to size `n` can be represented (useful for indexing arrays).
    - We don’t unrealistically store massive data in a single word.

---

## 🔹 Handling Edge Cases in the RAM Model

Real-world computers have instructions that can blur the lines of constant-time assumptions:

### ✅ Examples We Accept as Constant Time:
- **Bit shifting**: e.g., shift left by `k` bits (often equals multiplying by `2^k`)
  - Most computers implement this efficiently.
  - So, we assume computing `2^k` is constant-time *if* `k` is small and bounded.

### ❌ Unrealistic Shortcuts:
- If a RAM had a "sort" instruction, then sorting would take one step — clearly **unrealistic**.
- We avoid assuming such high-level instructions exist in the base model.

The key principle: **stick to what’s reasonable based on real computer architectures**.

---

## 🔹 What We Don’t Model (but Matters in Practice)

### Memory Hierarchies:
- The RAM model assumes uniform memory access time.
- **Real computers** use **caches**, **virtual memory**, and **multi-level storage hierarchies**.
- Though important in practice, these are not included in most algorithm analyses in this book.
- Models that account for memory hierarchies do exist, but they are significantly more complex.
- In most cases, RAM model predictions are **good approximations** of actual performance, especially for algorithmic comparisons.

---

## 🔹 Mathematical Tools and Challenges

Analyzing an algorithm requires:
- **Mathematical rigor** to describe performance.
- **Combinatorics** to understand permutations and combinations.
- **Probability theory** (e.g., average-case analysis).
- **Algebraic simplification** to derive closed-form expressions.
- **Asymptotic analysis** to simplify performance descriptions.

Even **simple-looking algorithms** can be mathematically tricky to analyze correctly.

---

## 🔹 Summarizing Algorithm Performance

Because algorithm behavior varies across inputs, we use **summaries** that generalize performance:

### Goals of Performance Summaries:

- Express in a **simple, readable format**
- Highlight **key efficiency characteristics**
- **Suppress irrelevant implementation details**
- Allow easy comparison between algorithms

Typically, we describe performance using **asymptotic notation** (e.g., O(n), O(n log n)), which focuses on growth rates rather than exact step counts.

---

## 🔹 Summary Takeaways

- Analyzing algorithms is crucial for understanding and improving performance.
- The **RAM model** gives a practical, though idealized, framework for measuring resource use.
- Real-world complexities like memory hierarchy are generally **ignored** but still important to understand.
- Mathematical tools help distill complex behavior into manageable performance insights.

# 📘 Insertion Sort

## 🔹 Problem Definition: Sorting

**Sorting Problem**

* **Input**: A sequence of `n` numbers ⟡a₁, a₂, ..., aₙ⟢
* **Output**: A permutation ⟡a‾₁, a‾₂, ..., a‾ₙ⟢ such that:

  ```
  a‾₁ ≤ a‾₂ ≤ ... ≤ a‾ₙ
  ```

The values to be sorted are called **keys**, and they are stored in an **array** of size `n`.

---

## 🔹 Intuition Behind Insertion Sort

Insertion Sort mimics how people sort cards in their hands:

* Start with an empty hand (left side of the array).
* Pick one card at a time from the table (right side).
* Insert it into the correct position in the hand (sorted subarray).
* Always compare from **right to left**.

At each step, the left portion of the array is sorted; the next item is inserted where it belongs.

---

## 🔹 Insertion Sort Pseudocode

```text
INSERTION-SORT(A)
1  for j = 2 to A.length
2      key = A[j]
3      // Insert A[j] into the sorted sequence A[1..j-1]
4      i = j - 1
5      while i > 0 and A[i] > key
6          A[i + 1] = A[i]
7          i = i - 1
8      A[i + 1] = key
```

* This algorithm **sorts in place**: it rearranges elements inside the array.
* Uses only a constant amount of additional memory.

---

## 🔹 Step-by-Step Example

Given: `A = [5, 2, 4, 6, 1, 3]`

### Iterations:

1. Insert 2 → `[2, 5, 4, 6, 1, 3]`
2. Insert 4 → `[2, 4, 5, 6, 1, 3]`
3. Insert 6 → `[2, 4, 5, 6, 1, 3]` (no change)
4. Insert 1 → `[1, 2, 4, 5, 6, 3]`
5. Insert 3 → `[1, 2, 3, 4, 5, 6]`

**Final Sorted Array**: `[1, 2, 3, 4, 5, 6]`

---

## 🔹 Proving Correctness with Loop Invariants

A **loop invariant** is used to prove that the algorithm works correctly.

> **Invariant**: At the start of each iteration of the `for` loop, the subarray `A[1..j-1]` is sorted and contains the original elements from `A[1..j-1]`.

### Three-Part Proof:

1. **Initialization**: Before the first iteration (`j = 2`), subarray `A[1..1]` contains a single element, which is trivially sorted.

2. **Maintenance**: If `A[1..j-1]` is sorted, then inserting `A[j]` into its correct place ensures `A[1..j]` is also sorted. The next iteration begins with a larger sorted subarray.

3. **Termination**: When `j = A.length + 1`, the entire array `A[1..n]` is sorted.

This process is analogous to **mathematical induction**.

---

## 🔹 Pseudocode Conventions Summary

* **Indentation** shows block structure (no `begin`/`end`).
* **Loops** (`for`, `while`) and **conditionals** (`if`, `else`) work like in C/Java/Python.
* **Loop counters** retain their value after loop ends.
* Arrays are accessed via `A[i]`; subarrays as `A[1..j]`.
* **Objects** and attributes follow dot notation, e.g., `A.length`.
* **Pass-by-value** for parameters, but object and array references are passed as pointers.
* **Boolean expressions** short-circuit: e.g., `x ≠ NIL and x.f = y` avoids null dereference.
* `//` starts a **comment**.
* `NIL` denotes a pointer to no object.
* `return` may return one or multiple values.

---

## 📒 Exercises

1. **2.1-1**: Illustrate `INSERTION-SORT` on `A = [31, 41, 59, 26, 41, 58]`.
2. **2.1-2**: Rewrite `INSERTION-SORT` to sort in **nonincreasing** order.
3. **2.1-3**: Write and prove correct a **linear search** algorithm using a loop invariant.
4. **2.1-4**: Write pseudocode to add two `n`-bit binary integers stored in arrays `A` and `B` and output to array `C` of size `n + 1`.

# 📈 Analysis of Insertion Sort

## 🔹 Why Analyze Insertion Sort?

* The time it takes to execute `INSERTION-SORT` depends on both the **size** and the **initial order** of the input.
* The **input size** (usually denoted `n`) is the most important factor.
* Different inputs of the same size can result in different execution times.

---

## 🔹 Defining Input Size

* Input size depends on the nature of the problem:

  * For **sorting**, it's usually the number of elements `n`.
  * For **binary arithmetic**, it might be the number of bits.
  * For **graphs**, both number of vertices and edges may be used.

We define **running time** as the number of **primitive operations (steps)** executed.

> Each line of pseudocode is assigned a constant time `cᵢ`. Total running time is the sum of these across all iterations.

---

## 🔹 Cost Table for INSERTION-SORT

Each statement in the pseudocode has an associated **cost (cᵢ)** and a **number of executions**:

| Line | Statement                    | Cost | Times Executed              |
| ---- | ---------------------------- | ---- | --------------------------- |
| 1    | `for j = 2 to A.length`      | c1   | `n` (Loop test j<=A.lenght) |
| 2    | `key = A[j]`                 | c2   | `n - 1`                     |
| 4    | `i = j - 1`                  | c4   | `n - 1`                     |
| 5    | `while i > 0 and A[i] > key` | c5   | $\sum_{j=2}^{n} t_j$        |
| 6    | `A[i + 1] = A[i]`            | c6   | $\sum_{j=2}^{n} (t_j - 1)$  |
| 7    | `i = i - 1`                  | c7   | $\sum_{j=2}^{n} (t_j - 1)$  |
| 8    | `A[i + 1] = key`             | c8   | `n - 1`                     |

> `tⱼ` = Number of times the while condition is checked for each `j`.

---

## 🔹 Best-Case Analysis (Already Sorted Input)

* In the best case, the `while` loop condition fails immediately for each `j`, so `tⱼ = 1`.
* Total running time:

```math
T(n) = c1n + c2(n - 1) + c4(n - 1) + c5(n - 1) + c8(n - 1)
```

* This simplifies to a **linear function**: $\Theta(n)$

---

## 🔹 Worst-Case Analysis (Reversed Input)

* In the worst case, every element must be compared with all previous ones: `tⱼ = j`

* Summations:

  * $\sum_{j=2}^{n} j = \frac{n(n+1)}{2} - 1$
  * $\sum_{j=2}^{n} (j-1) = \frac{n(n-1)}{2}$

* Final running time:

```math
T(n) = an^2 + bn + c
```

* Which is $\Theta(n^2)$ — a **quadratic** function.

---

## 🔹 Average-Case Analysis

* On average, each element is compared to **half** of the sorted subarray before it.
* So $t_j \approx \frac{j}{2}$
* The average-case also results in a **quadratic** function: $\Theta(n^2)$

---

## 🔹 Why We Focus on Worst-Case Analysis

1. **Upper Bound Guarantee**: Ensures the algorithm won’t perform worse.
2. **Worst-Case is Common**: In some problems (like searching), it occurs frequently.
3. **Average ≈ Worst in Practice**: For many algorithms, including insertion sort.

---

## 🔹 Order of Growth

We simplify analysis by focusing on the term that **grows fastest with input size**:

* Ignore constant factors and lower-order terms.
* For insertion sort, worst-case running time:

  ```math
  T(n) \in \Theta(n^2)
  ```
* $\Theta(n^2)$ describes the **order of growth** — a key concept in comparing algorithmic efficiency.

---

## 📒 Exercises

1. **2.2-1**: Express the function $\frac{n^3}{1000} - 100n^2 - 100n + 3$ in $\Theta$-notation.
2. **2.2-2**: Write pseudocode for **selection sort**. Define its loop invariant. Give best- and worst-case running times.
3. **2.2-3**: For **linear search**, how many elements are checked on average and in the worst case? Express both in $\Theta$-notation.
4. **2.2-4**: How can we modify any algorithm to ensure a good **best-case** running time?

# 🧠 Designing Algorithms and Merge Sort

## 🔹 Algorithm Design Techniques

* **Insertion sort** used an **incremental approach**: sort a subarray, then insert the next element.
* Another powerful design strategy is **divide-and-conquer**, often used in more efficient algorithms like **merge sort**.

---

## 🔹 Divide-and-Conquer Paradigm

This paradigm involves solving a problem recursively through 3 key steps:

1. **Divide**: Break the problem into smaller subproblems of the same type.
2. **Conquer**: Solve subproblems recursively (or directly if small enough).
3. **Combine**: Merge the subproblem solutions into the overall solution.

---

## 🔹 Merge Sort Overview

* **Divide**: Split the array into two halves.
* **Conquer**: Recursively sort each half.
* **Combine**: Merge the sorted halves using the `MERGE` procedure.

> Base case: a single-element array is already sorted.

---

## 🔹 MERGE Procedure (Detailed)

* Merges two sorted subarrays into one sorted array.
* Uses **sentinels** (∞ values) to simplify comparisons.
* Takes $\Theta(n)$ time where $n = r - p + 1$

### Pseudocode (simplified):

```text
MERGE(A, p, q, r):
  1. n1 = q - p + 1
  2. n2 = r - q
  3. Create arrays L[1..n1+1] and R[1..n2+1]
  4. Copy A[p..q] into L[1..n1]
  5. Copy A[q+1..r] into R[1..n2]
  6. Set L[n1+1] = ∞ and R[n2+1] = ∞  // Sentinels
  7. Initialize i = 1, j = 1
  8. For k = p to r:
      - If L[i] ≤ R[j]: set A[k] = L[i], increment i
      - Else: set A[k] = R[j], increment j
```

### Loop Invariant (Lines 12–17)

> At the start of each iteration:
>
> * `A[p..k-1]` contains the smallest `k - p` elements in sorted order
> * `L[i]` and `R[j]` are the smallest unmerged elements in their respective arrays

* **Initialization**: A\[p..k-1] is empty, i = j = 1
* **Maintenance**: At each step, copy the smaller of L\[i] or R\[j] into A\[k] and increment pointers
* **Termination**: Once all elements are copied, A\[p..r] is sorted

---

## 🔹 MERGE-SORT Procedure

```text
MERGE-SORT(A, p, r):
  if p < r:
    q = floor((p + r)/2)
    MERGE-SORT(A, p, q)
    MERGE-SORT(A, q + 1, r)
    MERGE(A, p, q, r)
```

To sort the full array `A[1..n]`, call:

```text
MERGE-SORT(A, 1, A.length)
```

---

## 🔹 Analyzing Merge Sort with Recurrence

Let `T(n)` be the running time:

* **Divide**: Constant time → $D(n) = \Theta(1)$
* **Conquer**: Two recursive calls → $2T(n/2)$
* **Combine**: Merge step → $C(n) = \Theta(n)$

### Recurrence Relation:

```math
T(n) = \begin{cases} 
\Theta(1) & \text{if } n = 1 \
2T(n/2) + \Theta(n) & \text{if } n > 1
\end{cases}
```

### Solving Recurrence:

* Merge sort performs $\log_2 n$ levels of recursion
* Each level does $\Theta(n)$ work
* Total cost: $\Theta(n \log n)$

> Merge sort is faster than insertion sort for large inputs ($n \log n$ vs. $n^2$).

---

## 🔹 Recursion Tree Intuition

* Each level of recursion has a total cost of $cn$
* There are $\log n + 1$ levels (if $n$ is a power of 2)
* Total work:

```math
cn + cn + cn + ... + cn = cn \log n + cn = \Theta(n \log n)
```

---

## 📒 Exercises

1. **2.3-1**: Illustrate merge sort on the array $A = [3, 41, 52, 26, 38, 57, 9, 49]$.
2. **2.3-2**: Rewrite `MERGE` without sentinels.
3. **2.3-3**: Prove that the recurrence $T(n) = 2T(n/2) + n$ solves to $\Theta(n \log n)$.
4. **2.3-4**: Write a recurrence for recursive insertion sort.
5. **2.3-5**: Write and analyze binary search. Prove its worst-case is $\Theta(\log n)$.
6. **2.3-6**: Can binary search improve insertion sort’s worst-case time?
7. **2.3-7**: Design a $\Theta(n \log n)$ algorithm to check if two elements in set S sum to x.

