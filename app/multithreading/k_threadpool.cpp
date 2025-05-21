#include <bits/stdc++.h>
#include <iostream>

class Threadpool {
 public:
  Threadpool() = delete;
  Threadpool(size_t number_of_threads) : m_stop(false) {
    /* create the threads */
    for (size_t i = 0; i < number_of_threads; i++) {
      m_workers.push_back(std::thread([this]() {
        for (;;) {
          std::unique_lock<std::mutex> ul(m_mtxPool);
          m_cvPool.wait(ul, [this]() { return m_stop || !m_qTasks.empty(); });

          if (m_stop && m_qTasks.empty())
            return;

          auto task = std::move(m_qTasks.front());
          m_qTasks.pop();
          ul.unlock();
          task();
        }
      }));
    }
  }

  ~Threadpool() {
    std::unique_lock<std::mutex> ul(m_mtxPool);
    m_stop = true;
    ul.unlock();
    m_cvPool.notify_all();
    for (auto& worker : m_workers) {
      worker.join();
    }
  }

  void enque(std::function<void(void)> funPtr) {
    std::unique_lock<std::mutex> ul(m_mtxPool);
    m_qTasks.push(funPtr);
    ul.unlock();
    m_cvPool.notify_one();
  }

 private:
  bool m_stop;  // flag identify that program ends and perform grace distruction
  std::queue<std::function<void(void)>> m_qTasks;  // tasks to be performed
  std::vector<std::thread> m_workers;
  std::mutex m_mtxPool;
  std::condition_variable m_cvPool;
};

int main() {
  size_t no_of_threads = 4;
  int no_of_task = 8;
  Threadpool pool(no_of_threads);

  for (int i = 0; i < no_of_task; i++) {
    pool.enque([i]() {
      auto myId = std::this_thread::get_id();
      std::stringstream ss;
      ss << myId;
      std::string myStr = ss.str();
      printf("Thread id of number %d = %s running\n", i, myStr.c_str());
      std::this_thread::sleep_for(std::chrono::seconds(1));
    });
  }

  // std::cout << "############### Program Done!" << std::endl;
  return 0;
}