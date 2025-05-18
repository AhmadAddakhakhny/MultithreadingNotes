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