### Q1. How to create threads?
> 1. via std::**thread:** doesn't reuturn a value  
> 2. via std::**async:** returns a value  

### Q2. how to inject the function/taks to the thread instance?
> 1. pointer to function  
> 2. Functor  
> 3. Lambda function  

### Q3. When the thread executes via std::thread?
> Right after creating an instance of it.

### Q4. What does thread::join() do?
> It is used to wait for a thread to finish execution before the calling thread (usually main) continues.

### Q5. When the thread executes via std::thread?
> Maybe. It might not start until .get() is called!

### Q6. When to use std::ref(some_var)?
> To pass a variable by reference to the thread in order to receive some values from the thread after being executed.

### Q7. What does async::get() do?
> wait for the task to execute and returns the value.

### Q8. Is the main thread blocked untill all of the threads get executed?
> Yes, and for that reason when need to find a way to let threads go sleep and roll over between them. how???

### Q9. Whe to use std::future<T>?
>  It's a placeholder or promise for a value of type T that will become available later.

---

### Q10. What is race condition?
> There are one or more thread trying to access/write the same member variable at the same time and would result to undefined behaviour.  
> The main problem is with **share data** across threads:
> > Race condition  
> > Wrong order of operations

### Q11. What are the solutions for race conditions?
> 1. Mutex and Locks
> 2. std::atomic: memory models
> 3. Abstraction: CSP, Actors, Map-Reduce

### Q12. List the types of mutex?
> lock/unlock
> lock_guard
> unique_lock
> shared_lock
> scoped_lock

### Q13. What is the idea of Mutex?
> Either-Me-Or-You policy (Mutual Execlusion)
> Makes operations atomic
> If one thread is in the critical section, the other must block and wait!

### Q14. What do you need to know about std::mutex?
> One mutex per critical section  
> It has to be shared variable!  

### Q15. What do you need to know about lock-unlock?
> lock and unlock should match
> don't forget to unlock
> * If exception happens, mutex stays locked.

### Q15. What do you need to know about std::lock_guard?
> if exception happens, mutex gets released. follows RAII
```cpp
std::mutex g_mtx_cntr;
uint64_t g_cntr = 0;
for (int i =0; i < 100; i++) {
  std::lock_guard<std::mutex> guard(g_mtx_cntr);
  /* critical section*/
  g_cntr++;
}
```
### Q16. What do you need to know about std::unique_guard?
> it's same as lock_guard + lock/unlock option.

### Q17. What do you need to know about std::shared_mutex, std::shared_lock?
> Only a single thread can mutate the attributes, but multiple threads can read if no writer has locked

```cpp
std::shared_mutex g_shared_mtx_cntr;
uint64_t g_cntr = 0;

void increment() {
  for (int i = 0; i < 100; i++) {
    std::unique_lock<std::shared_mutex> u(g_shared_mtx_cntr);
    g_cntr++; // critical section
  }
}

void iamJustReader() {
  std::shared_lock<std::shared_mutex> s(g_shared_mtx_cntr);
  std::cout << g_cntr; << std::endl;
}
```
### Q18. How to do multiple lock for several mutexes std::scoped_lock?
> it's better to prevent from dead lock scenarios.
```cpp
void increment () {
  for (int i = 0; i < 100; i++) {
    std::scoped_lock scoped_lock_gaurd(g_mtx_one, g_mtx_two);
    g_cntr++;
  }
}
```
---
# Conditional Variables
> it's being used to let one thread able to send a message to another thread.
> it resolves producer-consumer pattern

### Q19. What are the key elements should be placed in the critical section to implement based on conditional variable approach?
> 1. instance of conditional variable build by the mutex
> 2. flag for read and write permission
> 3. shared data between 2 threads
> Remark: these variables + the mutex should be created in shared memory location between the threads.

### Q20. Explain std::conditional_variable::wait()?
> it takes two arguments
> 1st: lock_gaurd for the mutex
> 2nd: functor/LambdExpression
> it's responsiple for letting the thread blocked if either the mutex locked by another worker or the functor valuation is false

### Q21. Explain std::conditional_variable::notify_once() or std::conditional_variable::notify_all()?
> once it's being called all the blocked threads will be notified to wake up.
---
# Thread pool
> a pool of many threads that are running and waiting for task to handle.
