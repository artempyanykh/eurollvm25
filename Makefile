main: main.cpp gen/lib1.so gen/lib2.so gen/lib3.so gen/lib4.so gen/lib5.so
	clang++ $^ -o main -fsanitize=address

gen/lib%.so: gen/src%.cpp
	clang++ -shared $< -o $@ -fsanitize=address

clean:
	rm main
	rm lib*.so