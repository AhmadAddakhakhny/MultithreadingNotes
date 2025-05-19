#include <bits/stdc++.h>
#include <iostream>
#include <thread>

void setValue(int& target, int val) {
  target = val;
}

int main() {

  int var = 0;
  for (int i = 0; i < 1000; i++) {
    std::thread t1(setValue, std::ref(var), 1);
    std::thread t2(setValue, std::ref(var), 2);

    t1.join();
    t2.join();

    std::cout << var << " , ";
  }

  std::cout << std::endl << "############### Program Done!" << std::endl;
  return 0;
}