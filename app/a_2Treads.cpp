#include <bits/stdc++.h>
#include <iostream>
#include <thread>

void accumelate(uint64_t& sum, uint64_t start, uint64_t end) {

  for (uint64_t i = start; i < end; i++) {
    sum += i;
  }
}

int main() {
  uint64_t number_of_threads = 2;
  uint64_t number_of_element = 1000 * 1000 * 1000;
  uint64_t step = number_of_element / number_of_threads;
  std::vector<uint64_t> partial_sums(number_of_threads);

  std::thread t1(accumelate, std::ref(partial_sums[0]), 0, step);
  std::thread t2(accumelate, std::ref(partial_sums[1]), step,
                 number_of_threads * step);

  t1.join();
  t2.join();
  uint64_t total_sum =
      std::accumulate(partial_sums.begin(), partial_sums.end(), uint64_t(0));

  for (const auto& it : partial_sums) {
    std::cout << it << " , ";
  }
  std::cout << std::endl << total_sum << std::endl;

  std::cout << "############### Program Done!" << std::endl;
  return 0;
}