#include <bits/stdc++.h>
#include <iostream>
#include <thread>

std::deque<uint64_t> g_dq;
std::mutex g_mtx_dq;
std::condition_variable g_cv;
uint64_t g_dq_cap = 100;

void producer_task(uint64_t val) {
  while (val) {
    std::unique_lock<std::mutex> ul(g_mtx_dq);
    g_cv.wait(ul, []() {
      return g_dq.size() < g_dq_cap;
    });  // wait as long as g_dq reaches the limit
    g_dq.push_back(val);
    std::cout << "producer: " << val << std::endl;
    val--;
    ul.unlock();
    g_cv.notify_one();
  }
}

void consumer_task() {
  while (true) {
    std::unique_lock<std::mutex> ul(g_mtx_dq);
    g_cv.wait(ul, []() {
      return g_dq.size() > 0;
    });  // wait as long as g_dq is empty.
    uint64_t val = g_dq.front();
    std::cout << "consumer: " << val << std::endl;
    g_dq.pop_front();
    ul.unlock();
    g_cv.notify_one();
  }
}

int main() {
  std::thread producer(producer_task, 50);
  std::thread consumer(consumer_task);

  producer.join();
  consumer.join();

  std::cout << "############### Program Done!" << std::endl;
  return 0;
}