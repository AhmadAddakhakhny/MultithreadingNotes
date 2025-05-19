#include <bits/stdc++.h>
#include <iostream>
#include <thread>

void incrementCounter(uint64_t& cntr) {
  for (int i = 0; i < 100; i++) {
    cntr++;
  }
}

int main() {

  int N = 1000;

  for (int ii = 0; ii < N; ii++) {

    uint64_t cntr = 0;
    std::vector<std::thread> threads;

    for (int i = 0; i < 100; i++) {
      threads.push_back(std::thread(incrementCounter, std::ref(cntr)));
    }

    for (auto& it : threads) {
      it.join();
    }

    std::cout << cntr << " , ";  // expected output 10,000

  }

  std::cout << std::endl << "############### Program Done!" << std::endl;
  return 0;
}