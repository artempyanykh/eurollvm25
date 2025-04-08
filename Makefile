CLANG_BEFORE := llvm-before/build-reldeb/bin/clang++
CLANG_AFTER := llvm-after/build-reldeb/bin/clang++

$(CLANG_BEFORE):
	cd llvm-before && \
	time cmake -S llvm -B build-reldeb -G Ninja -DLLVM_ENABLE_PROJECTS="clang;lld;compiler-rt" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DLLVM_TARGETS_TO_BUILD=host -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLLVM_USE_LINKER=lld && \
	cd build-reldeb && \
	time ninja clang projects/compiler-rt/lib/asan/all

$(CLANG_AFTER):
	cd llvm-after && \
	time cmake -S llvm -B build-reldeb -G Ninja -DLLVM_ENABLE_PROJECTS="clang;lld;compiler-rt" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DLLVM_TARGETS_TO_BUILD=host -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLLVM_USE_LINKER=lld && \
	cd build-reldeb && \
	time ninja clang projects/compiler-rt/lib/asan/all

before_patch: main.cpp gen/lib1.so gen/lib2.so gen/lib3.so gen/lib4.so gen/lib5.so
	$(CLANG_BEFORE) $^ -o $@ -fsanitize=address -g2

gen/lib%.so: gen/src%.cpp
	$(CLANG_BEFORE) -shared -fpic $< -o $@ -fsanitize=address -g2

after_patch: main.cpp gen/patched_lib1.so gen/patched_lib2.so gen/patched_lib3.so gen/patched_lib4.so gen/patched_lib5.so
	$(CLANG_AFTER) $^ -o $@ -fsanitize=address -g2

gen/patched_lib%.so: gen/src%.cpp
	$(CLANG_AFTER) -shared -fpic $< -o $@ -fsanitize=address -g2

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
	rm -f before_patch after_patch
	rm -f gen/*