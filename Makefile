PATCHED_CLANG := /home/arr/dev/llvm-project-asan-after/build-reldeb/bin/clang++

main: main.cpp gen/lib1.so gen/lib2.so gen/lib3.so gen/lib4.so gen/lib5.so gen/lib6.so gen/lib7.so
	clang++ $^ -o main -fsanitize=address

gen/lib%.so: gen/src%.cpp
	clang++ -shared -fpic $< -o $@ -fsanitize=address

patched_main: main.cpp gen/patched_lib1.so gen/patched_lib2.so gen/patched_lib3.so gen/patched_lib4.so gen/patched_lib5.so gen/patched_lib6.so gen/patched_lib7.so
	$(PATCHED_CLANG) $^ -o patched_main -fsanitize=address

gen/patched_lib%.so: gen/src%.cpp
	$(PATCHED_CLANG) -shared -fpic $< -o $@ -fsanitize=address

gen/src1.cpp: gen.py
	python3 gen.py 1

gen/src2.cpp: gen.py
	python3 gen.py 2

gen/src3.cpp: gen.py
	python3 gen.py 3

gen/src4.cpp: gen.py
	python3 gen.py 4

gen/src5.cpp: gen.py
	python3 gen.py 5

gen/src6.cpp: gen.py
	python3 gen.py 6

gen/src7.cpp: gen.py
	python3 gen.py 7

clean:
	rm -f main
	rm -f gen/*