PATCHED_CLANG := /home/arr/dev/llvm-project-asan-after/build-reldeb/bin/clang++

before_patch: main.cpp gen/lib1.so gen/lib2.so gen/lib3.so gen/lib4.so gen/lib5.so
	clang++ $^ -o $@ -fsanitize=address -g2

gen/lib%.so: gen/src%.cpp
	clang++ -shared -fpic $< -o $@ -fsanitize=address -g2

after_patch: main.cpp gen/patched_lib1.so gen/patched_lib2.so gen/patched_lib3.so gen/patched_lib4.so gen/patched_lib5.so
	$(PATCHED_CLANG) $^ -o $@ -fsanitize=address -g2

gen/patched_lib%.so: gen/src%.cpp
	$(PATCHED_CLANG) -shared -fpic $< -o $@ -fsanitize=address -g2

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

clean:
	rm -f program_before program_after
	rm -f gen/*