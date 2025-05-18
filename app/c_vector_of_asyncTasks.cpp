#include <bits/stdc++.h>
#include <iostream>
#include <thread>

uint64_t accumelate(uint64_t start, uint64_t end) {
  uint64_t sum = 0;

  for (uint64_t i = start; i < end; i++) {
    sum += i;
  }

  return sum;
}

int main() {
  uint64_t number_of_threads = 10;
  uint64_t number_of_element = 1000 * 1000 * 1000;
  uint64_t step = number_of_element / number_of_threads;
  std::vector<std::future<uint64_t>> tasks;

  for (uint64_t i = 0; i < number_of_threads; i++) {
    tasks.push_back(std::async(accumelate, (i * step), ((1 + i) * step)));
  }

  uint64_t total_sum = 0;
  for (auto& it : tasks) {
    total_sum += it.get();  // Waits for computeSum to finish and gets result
  }

  std::cout << std::endl << total_sum << std::endl;

  std::cout << "############### Program Done!" << std::endl;
  return 0;
}