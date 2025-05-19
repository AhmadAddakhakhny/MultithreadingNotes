#include <bits/stdc++.h>
#include <iostream>
#include <thread>

std::mutex g_mtx_cntr;
uint64_t g_cntr = 0;

void increment() {
  g_mtx_cntr.lock();
  for (int i = 0; i < 100; i++) {
    g_cntr++;
  }
  g_mtx_cntr.unlock();
}

int main() {

  for (int ii = 0; ii < 1000; ii++) {
    g_cntr = 0;
    std::vector<std::thread> threads;
    for (int i = 0; i < 100; i++) {
      threads.push_back(std::thread(increment));
    }

    for (auto& t : threads) {
      t.join();
    }

    std::cout << g_cntr << " , ";
  }

  std::cout << std::endl << "############### Program Done!" << std::endl;
  return 0;
}