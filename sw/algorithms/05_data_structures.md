# 📘 Data Structures – Dynamic Sets and Basic Structures

## 🔀 Introduction to Dynamic Sets

Sets are a core concept in both mathematics and computer science. However, while mathematical sets are static, computer science often deals with **dynamic sets**, which allow for addition, deletion, and modification of elements.

These sets are the foundation of many algorithms. Depending on the required operations, different data structures may be used to implement them efficiently.

* **Dictionary:** A dynamic set that supports insertions, deletions, and membership queries.
* **Min-priority queue:** Requires support for operations like `insert` and `extract-min`.

The implementation choice depends on the required operations.

---

## 🔑 Structure of Dynamic Set Elements

### Object Representation

Each element is typically represented as an **object**:

* Contains an **identifying key** (assumed unique).
* May also contain **satellite data**, which is used by applications but not by the data structure itself.
* Might include **pointers** or other attributes used internally for structuring the data (e.g., linked list pointers).

### Key Ordering

* Keys are often drawn from a **totally ordered set** (e.g., integers, strings).
* Allows the definition of operations like:

  * `MINIMUM`
  * `SUCCESSOR`
  * Sorted enumeration

---

## ⚖️ Operations on Dynamic Sets

### Categories

* **Queries:** Return information without changing the structure.
* **Modifications:** Alter the structure by adding or removing elements.

### Standard Operations

* `SEARCH(S, k)`: Returns a pointer to the element with key `k` or `NIL`.
* `INSERT(S, x)`: Adds an element `x`.
* `DELETE(S, x)`: Deletes element `x` given its pointer.
* `MINIMUM(S)`: Returns element with the smallest key.
* `MAXIMUM(S)`: Returns element with the largest key.
* `SUCCESSOR(S, x)`: Returns the next element larger than `x`.
* `PREDECESSOR(S, x)`: Returns the next element smaller than `x`.

### Note

* For sets with `n` keys, `MINIMUM` followed by `n-1` `SUCCESSOR` calls produces elements in sorted order.
* Operation time is usually measured in terms of the size `n`.

---

## 📚 Implementing Dynamic Sets


### Elementary Data Structures

* Stacks (LIFO)
* Queues (FIFO)
* Linked Lists
* Rooted Trees

### Hash Tables

* Dictionary implementation
* Average-case: O(1)
* Worst-case: Ω(n)

### Binary Search Trees (BST)

* Support all operations
* Average time: O(log n)
* Worst-case: Ω(n)

### Red-Black Trees

* Balanced BST
* Guaranteed O(log n) for all operations
* Intricate balancing logic

### Augmented Red-Black Trees

* Maintain extra info like:

  * Order statistics
  * Intervals

---

## 🔢 Stacks and Queues

### Stacks (LIFO)

* Last-In, First-Out
* `PUSH(S, x)` adds to top
* `POP(S)` removes from top

#### Implementation

* Array with `S.top`
* Stack is empty if `S.top = 0`
* Time: O(1)

#### Errors

* **Underflow:** Popping from empty stack
* **Overflow:** Exceeding array bounds (not checked in pseudocode)

### Queues (FIFO)

* First-In, First-Out
* `ENQUEUE(Q, x)` adds to tail
* `DEQUEUE(Q)` removes from head

#### Implementation

* Circular array
* Uses `Q.head` and `Q.tail`
* Time: O(1)

#### Errors

* **Underflow:** Dequeue from empty
* **Overflow:** Enqueue to full

---

## 🔗 Linked Lists

### Variants

* **Singly/Doubly linked**
* **Sorted/Unsorted**
* **Circular or not**

### Operations

* `LIST-SEARCH(L, k)`: Linear search – O(n)
* `LIST-INSERT(L, x)`: Insert at head – O(1)
* `LIST-DELETE(L, x)`: Remove via pointer – O(1)

### Use of Sentinels

* Dummy nodes simplify edge-case handling
* Common in circular, doubly linked lists
* Reduces constant factors but not asymptotic time

### Sentinel-based Simplifications

* Head becomes `L.nil.next`
* Tail is `L.nil.prev`
* Empty list: `L.nil.next = L.nil`, `L.nil.prev = L.nil`

---

## 🛠️ Synthesizing Pointers and Objects

### Without Native Pointers

* **Multiple-array representation**:

  * Separate arrays for `key`, `next`, and `prev`
  * Index `x` identifies object

* **Single-array representation**:

  * Object is a subarray
  * Fields accessed via offset

### Memory Management

* Maintain **free list** of unused objects
* `ALLOCATE-OBJECT`: O(1)
* `FREE-OBJECT`: O(1)
* Can service multiple lists with one free list

### Compactify Lists

* Keep active list in first `n` slots
* Adjust free list accordingly
* Used in virtual-memory systems

---

## 🌳 Representing Rooted Trees

### Binary Trees

* Node has: `key`, `p`, `left`, `right`
* Tree has `T.root`
* `NIL` denotes absence of child

### Arbitrary Trees

* **Left-child, right-sibling representation**:

  * `left-child`: First child
  * `right-sibling`: Next sibling
  * Requires only O(n) space

### Application-Specific Representations

* Heaps (Chapter 6): Array-based
* Disjoint Sets (Chapter 21): Only `parent` pointers

---

## ✍️ Exercises and Problems

### Practice Tasks:

* Stack and queue simulations
* Implementing two stacks in one array
* Building queues using stacks (and vice versa)
* Singly/doubly/circular list problems
* Reversing lists
* XOR-based pointer optimizations

### Tree Tasks:

* Drawing trees from pointer tables
* Recursive and non-recursive traversal
* Printing trees in `O(n)`
* Reducing tree pointers with a Boolean flag

### Advanced Exercises:

* Implementing mergeable heaps
* Analyzing randomized list search
* Designing compact array storage for linked structures

---

## 📆 Final Notes

This chapter lays the foundational knowledge for:

* Efficient algorithm design
* Data manipulation with optimal performance
* Future learning on advanced structures like hash tables, trees, and heaps

Through the use of dynamic sets, queues, stacks, and trees, you gain both a conceptual and practical understanding essential for computer science problem solving.

## Hash Tables

### Overview

Hash tables are dynamic data structures that support dictionary operations: `INSERT`, `SEARCH`, and `DELETE`. These are critical in applications like compilers, where a symbol table maps identifiers (strings) to data. Hashing provides an efficient means of implementing such dictionaries. While the worst-case search time can be as bad as `Θ(n)`, the average case is `O(1)` under simple uniform hashing.

### Direct-Address Tables (Section 11.1)

* **Direct addressing** works well when the universe `U` of keys is small. It uses an array `T[0...m-1]`, where each key `k ∈ U` maps directly to `T[k]`.
* **Assumption**: Keys are distinct.
* **Operations**:

  * `DIRECT-ADDRESS-SEARCH(T, k)`: Returns `T[k]`.
  * `DIRECT-ADDRESS-INSERT(T, x)`: Sets `T[x.key] = x`.
  * `DIRECT-ADDRESS-DELETE(T, x)`: Sets `T[x.key] = NIL`.
* **Performance**: All operations take `O(1)` time.
* **Variants and Optimizations**:

  * Can store the data directly in `T[k]` instead of using pointers.
  * Bit vectors can represent presence/absence efficiently.
  * For non-distinct keys or with satellite data, use dynamic structures like linked lists per slot.
  * For very large arrays, a stack-like structure can validate initialized entries in `O(1)` time.

### Hash Tables (Section 11.2)

* **Purpose**: Reduce memory usage compared to direct-address tables when `|U|` is large and `|K|` is small.
* **Core Concept**: A hash function `h` maps keys to slot indices.
* **Collision**: Multiple keys may map to the same slot; resolved using techniques like:

#### Chaining

* **Approach**: Each slot contains a linked list of entries.
* **Operations**:

  * `CHAINED-HASH-INSERT(T, x)`: Inserts `x` at the head of list `T[h(x.key)]`.
  * `CHAINED-HASH-SEARCH(T, k)`: Searches list `T[h(k)]` for key `k`.
  * `CHAINED-HASH-DELETE(T, x)`: Deletes `x` from `T[h(x.key)]`.
* **Assumptions**:

  * Uses doubly linked lists for efficient deletion.
* **Performance**:

  * Worst-case: `Θ(n)` (all keys hash to one slot).
  * Average-case: `Θ(1 + α)` where `α = n/m` is the load factor.
* **Theoretical Guarantees**:

  * Under simple uniform hashing:

    * Unsuccessful search: `Θ(1 + α)`.
    * Successful search: `Θ(1 + α)`.

### Hash Functions (Section 11.3)

* **Goals**: Simulate simple uniform hashing — each key should map uniformly and independently.
* **When keys are not numbers**: Convert them using methods like radix interpretation of strings.

#### Division Method

* `h(k) = k mod m`
* `m` should be prime and not close to a power of 2.

#### Multiplication Method

* `h(k) = floor(m * (k * A mod 1))`, with `0 < A < 1`.
* Efficient when `m = 2^p` and word size `w` is used.
* Suggested value: `A ≈ (sqrt(5) - 1)/2 ≈ 0.6180339887`.

#### Universal Hashing

* **Definition**: A class `H` of hash functions is universal if for any distinct `k ≠ l`, `Pr[h(k) = h(l)] ≤ 1/m`.
* **Hash Function Form**: `h_ab(k) = ((a * k + b) mod p) mod m`, with `a ≠ 0`.
* **Advantages**: Guarantees good average performance regardless of input distribution.

### Open Addressing (Section 11.4)

* **Concept**: All data stored in the table itself. No external chains.
* **Probing Sequence**: Determined by `h(k, i)` where `i` is the probe number.
* **Requirement**: The probe sequence for any `k` must cover all slots (i.e., be a permutation of `[0, ..., m-1]`).
* **Deletion**: Requires a special `DELETED` marker since setting to `NIL` may break probe sequences.

#### Probing Methods

1. **Linear Probing**:

   * `h(k, i) = (h'(k) + i) mod m`
   * Suffers from primary clustering.
2. **Quadratic Probing**:

   * `h(k, i) = (h'(k) + c1*i + c2*i^2) mod m`
   * Suffers from secondary clustering.
3. **Double Hashing**:

   * `h(k, i) = (h1(k) + i * h2(k)) mod m`
   * Minimizes clustering, approximates uniform hashing best.

#### Performance (Assuming Uniform Hashing)

* Unsuccessful search: `≤ 1 / (1 - α)`
* Successful search: `≤ (1/α) * ln(1 / (1 - α))`
* Insertion: Same as unsuccessful search

### Perfect Hashing (Section 11.5)

* **Scenario**: Static set of keys (no insertions/deletions after setup).
* **Goal**: Achieve `O(1)` worst-case search time.

#### Two-Level Scheme

1. **First Level**: Hash `n` keys into `m = n` slots using universal hash function `h`.
2. **Second Level**:

   * For each slot `j` with `n_j` keys, create table `S_j` of size `m_j = n_j^2`.
   * Choose `h_j` from universal family `Hp,mj` such that no collisions occur in `S_j`.

#### Analysis

* **Collision-Free Guarantee**:

  * Probability of collision in `S_j` is `< 1/2` when `m_j = n_j^2`.
* **Expected Space Usage**:

  * `E[Σ m_j] < 2n`, hence total expected space is `O(n)`.
* **Storage Bound**:

  * Probability total space ≥ 4n is < 1/2 (Markov's Inequality).

### Conclusion

Hash tables are highly effective data structures with fast average-case performance. Techniques like chaining and open addressing help manage collisions, while careful design of hash functions (especially universal hashing) ensures robustness. Perfect hashing allows `O(1)` worst-case performance for static sets. Understanding load factors, probing strategies, and theoretical guarantees is critical to effective implementation.

