#include <iostream>

int main(int argc, char *argv[]) {
    std::cout << "Hello world!" << std::endl;
}

extern "C" const char *__asan_default_options() {
    return "detect_odr_violation=1";
}