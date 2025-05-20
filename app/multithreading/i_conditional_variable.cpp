#include <bits/stdc++.h>
#include <iostream>
#include <thread>

std::condition_variable g_cv;
std::mutex g_mtx_balance;
uint64_t g_balance = 0;

void withdraw(uint64_t amount) {
  std::unique_lock<std::mutex> ul(g_mtx_balance);
  g_cv.wait(ul, []() { return g_balance != 0; });

  if (amount <= g_balance) {
    g_balance -= amount;
    std::cout << "Withdraw operation done, current balance = " << g_balance
              << std::endl;
  } else {
    std::cout << "Operation denied, as current balance is " << g_balance
              << std::endl;
  }
}

void addMoney(uint64_t amount) {
  std::unique_lock<std::mutex> ul(g_mtx_balance);
  g_balance += amount;
  g_cv.notify_one();
}

int main() {
  std::thread t1(withdraw, 600);
  std::this_thread::sleep_for(std::chrono::seconds(5));
  std::thread t2(addMoney, 500);

  t1.join();
  t2.join();

  std::cout << "############### Program Done!" << std::endl;
  return 0;
}