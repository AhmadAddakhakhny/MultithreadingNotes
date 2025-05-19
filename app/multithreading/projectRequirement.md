🧠 Project Title:
Multithreaded Task Scheduler in Modern C++

🎯 Project Goal:
Design and implement a basic task scheduler that can:

Accept and schedule tasks dynamically

Use multiple worker threads to execute tasks concurrently

Handle task prioritization (optional)

Support task cancellation and graceful shutdown

📋 Functional Requirements:
Task Interface

Tasks are defined as callable functions (e.g., std::function<void()>).

Optionally accept a task name or ID for logging/tracking.

Task Queue

Thread-safe queue to store pending tasks.

Use a std::queue with std::mutex and std::condition_variable.

Worker Threads

Spawn a fixed number of worker threads (e.g., from a thread pool).

Each thread picks up tasks from the queue and executes them.

Scheduler Manager

Manages worker threads and task queue.

Allows submitting new tasks at runtime.

Gracefully shuts down all threads.

Optional Features (for extra challenge):

Support for task priority levels (via std::priority_queue)

Support for delayed task execution (scheduling for future execution)

Track task execution time

Retry failed tasks

🧪 Use Cases:
Submit a task from the main thread

E.g., simulate logging, computation, or printing operations.

Run N tasks in parallel

E.g., compute Fibonacci for a set of numbers concurrently.

Cancel task execution before it's picked up

Optional advanced feature

Monitor thread pool status

Number of active threads, pending tasks, completed tasks

🧱 Suggested Class Design:
cpp
Copy
Edit
class TaskScheduler {
public:
    TaskScheduler(size_t numThreads);
    ~TaskScheduler();

    void submit(std::function<void()> task);
    void shutdown();

private:
    void workerLoop();

    std::vector<std::thread> workers;
    std::queue<std::function<void()>> taskQueue;
    std::mutex queueMutex;
    std::condition_variable cv;
    bool stop = false;
};
🕒 Estimated Time Breakdown:
Task	Duration
Design and planning	1 day
Implement core scheduler	2–3 days
Add task submission + thread pool	2–3 days
Add synchronization (mutex, condition vars)	1 day
Add optional features (priorities, delays, etc.)	2–3 days
Testing + Debugging + Logging	2 days
Documentation & cleanup	1 day

⏳ Total: ~7 to 10 days (for solid version)

🧰 Tech Suggestions:
C++17 or C++20 (std::jthread if C++20)

std::mutex, std::condition_variable, std::thread, std::future

Unit testing: GoogleTest

Logging: Simple std::cout or spdlog